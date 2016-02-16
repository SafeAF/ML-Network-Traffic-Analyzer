require 'octokit'
require 'mongo'
require 'gchart'
require 'date'
require 'JSON'

include Mongo

class IssueDownload

  def initialize (repository, optionsDefaultsOverrides = {})
    optionsDefaults = {
        :mongoURL => "localhost",
        :mongoPort => 27017,
        :mongoDBName => "GitHub-Analytics",
        :mongoIssuesColl => "Issues",
        :mongoRepoEventsColl => "Repo-Events",
        :mongoIssueEventsColl => "Issue-Events",
        :mongoOrgMembersColl => "Org-Members",
        :mongoOrgTeamsInfoColl => "Org-Teams-Info",
        :mongoRepoLabelsColl => "Repo-Labels",
        :mongoRepoMilestonesColl => "Repo-Milestones",
        :mongoClearRecords => false
    }
    optionsDefaults.merge!(optionsDefaultsOverrides)

    @repository = repository.to_s
    @organization = @repository.slice(0..(repository.index('/')-1 ))

    # MongoDB Database Connect
    @client = MongoClient.new(optionsDefaults[:mongoURL], optionsDefaults[:mongoPort])
    @db = @client[optionsDefaults[:mongoDBName]]

    @collIssues = @db[optionsDefaults[:mongoIssuesColl]]
    @collRepoEvents = @db[optionsDefaults[:mongoRepoEventsColl]]
    @collRepoIssueEvents = @db[optionsDefaults[:mongoIssueEventsColl]]
    @collOrgMembers = @db[optionsDefaults[:mongoOrgMembersColl]]
    @collOrgTeamsInfoAllList = @db[optionsDefaults[:mongoOrgTeamsInfoColl]]
    @collRepoLabelsList = @db[optionsDefaults[:mongoRepoLabelsColl]]
    @collRepoMilestonesList = @db[optionsDefaults[:mongoRepoMilestonesColl]]

    # Debug code to empty out mongoDB records
    if optionsDefaults[:mongoClearRecords] == true
      @collIssues.remove
      @collRepoEvents.remove
      @collRepoIssueEvents.remove
      @collOrgMembers.remove
      @collRepoLabelsList.remove
      @collRepoMilestonesList.remove
      @collOrgTeamsInfoAllList.remove
    end
  end

  # TODO add authentication as a option for go live as Github Rate Limit is 60 hits per hour when unauthenticated by 5000 per hour when authenticated.
  # TODO PRIORITY username and password variables are not using "gets" correctly when used in terminal.  When in terminal after typing in credentials github api returns a bad credentials alert.  But when you type the credentials in directly in the code there is no issues.
  def ghAuthenticate (username, password)
    # puts "Enter GitHub Username:"
    # username = ""
    # puts "Enter GitHub Password:"
    # password = ""
    # Octokit.auto_paginate = true
    @ghClient = Octokit::Client.new(:login => username.to_s, :password => password.to_s, :per_page =>100)
  end

  def getIssues
    # TODO get list_issues working with options hash: Specifically need Open and Closed issued to be captured
    # Gets Open Issues List - Returns Sawyer::Resource
    issueResultsOpen = @ghClient.list_issues(@repository, {
                                                            :state => :open
                                                        })
    ghLastReponseOpen = @ghClient.last_response

    # Parses String body from last response/Closed Issues List into Proper Array in JSON format
    issueResultsOpenRaw = JSON.parse(@ghClient.last_response.body)

    while ghLastReponseOpen.rels.include?(:next) do
      ghLastReponseOpen = ghLastReponseOpen.rels[:next].get
      issueResultsOpenRaw.concat(JSON.parse(ghLastReponseOpen.body))
    end




    # Gets Closed Issues List - Returns Sawyer::Resource
    issueResultsClosed = @ghClient.list_issues(@repository.to_s, {
                                                                   :state => :closed
                                                               })

    ghLastReponseClosed = @ghClient.last_response

    # # Parses String body from last response/Closed Issues List into Proper Array in JSON format
    issueResultsClosedRaw = JSON.parse(@ghClient.last_response.body)

    while ghLastReponseClosed.rels.include?(:next) do
      ghLastReponseClosed = ghLastReponseClosed.rels[:next].get
      issueResultsClosedRaw.concat(JSON.parse(ghLastReponseClosed.body))
    end


    # Open Issues
    if issueResultsOpenRaw.empty? == false
      issueResultsOpenRaw.each do |x|
        x["organization"] = @organization
        x["repo"] = @repository
        x["downloaded_at"] = Time.now
        if x["comments"] > 0
          openIssueComments = self.getIssueComments(x["number"])
          x["issue_comments"] = openIssueComments
          # puts "Processed Comments for Open issue number: #{x["number"]}"
        end
        xDatesFixed = self.convertIssueDatesForMongo(x)
        self.putIntoMongoCollIssues(xDatesFixed)
        self.getIssueEvents(x["number"])
        # puts "Processed Open issue number: #{x["number"]}"

        # if @ghClient.rate_limit.remaining < 100
        # end
      end
    end

    # Closed Issues
    if issueResultsClosedRaw.empty? == false
      issueResultsClosedRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
        if y["comments"] > 0
          closedIssueComments = self.getIssueComments(y["number"])
          y["issues_comments"] = closedIssueComments
          # puts "Processed Comments for Closed issue number: #{y["number"]}"
        end
        yDatesFixed = self.convertIssueDatesForMongo(y)
        self.putIntoMongoCollIssues(yDatesFixed)
        self.getIssueEvents(y["number"])
        # puts "Processed Closed issue number: #{y["number"]}"

        # if @ghClient.rate_limit.remaining < 100
        # end
      end
    end

    # Debug Code
    # puts "Got issues, Github raite limit remaining: " + @ghClient.rate_limit.remaining.to_s
  end

  # TODO preform DRY refactor for Mongodb insert
  def putIntoMongoCollIssues(mongoPayload)
    @collIssues.insert(mongoPayload)
    # puts "Issues Added, Count in Mongodb: " + @coll.count.to_s
  end

  def putIntoMongoCollRepoEvents(mongoPayload)
    @collRepoEvents.insert(mongoPayload)
    # puts "Repo Events Added, Count in Mongodb: " + @collRepoEvents.count.to_s
  end

  def putIntoMongoCollOrgMembers(mongoPayload)
    @collOrgMembers.insert(mongoPayload)
    # puts "Org Members Added, Count in Mongodb: " + @collOrgMembers.count.to_s
  end

  def putIntoMongoCollRepoIssuesEvents(mongoPayload)
    @collRepoIssueEvents.insert(mongoPayload)
    # puts "Repo Issue Events Added, Count in Mongodb: " + @collRepoIssueEvents.count.to_s
  end

  def putIntoMongoCollRepoLabelsList(mongoPayload)
    @collRepoLabelsList.insert(mongoPayload)
    # puts "Repo Labels List Added, Count in Mongodb: " + @collRepoIssueEvents.count.to_s
  end

  def putIntoMongoCollRepoMilestonesList(mongoPayload)
    @collRepoMilestonesList.insert(mongoPayload)
    # puts "Repo Labels List Added, Count in Mongodb: " + @collRepoIssueEvents.count.to_s
  end

  def putIntoMongoCollOrgTeamsInfoAllList(mongoPayload)
    @collOrgTeamsInfoAllList.insert(mongoPayload)
    # puts "Org Tema Repos List Added, Count in Mongodb: " + @collRepoIssueEvents.count.to_s
  end


  # find records in Mongodb that have a comments field value of 1 or higher
  # returns only the number field
  # TODO  ***rebuild in option to not have to call MongoDB and add option to pull issues to get comments from directly from getIssues method
  def getIssueComments(issueNumber)
    # issuesWithComments = @coll.find({"comments" => {"$gt" => 0}},
    # 								{:fields => {"_id" => 0, "number" => 1}}
    # 								).to_a

    issueComments = @ghClient.issue_comments(@repository.to_s, issueNumber.to_s)
    issueCommentsRaw = JSON.parse(@ghClient.last_response.body)

    ghLastReponse = @ghClient.last_response

    while ghLastReponse.rels.include?(:next) do
      ghLastReponse = ghLastReponse.rels[:next].get
      issueCommentsRaw.concat(JSON.parse(ghLastReponse.body))
    end

    issueCommentsRaw.each do |x|
      x["organizaion"] = @organization
      x["repo"] = @repository
      x["downloaded_at"] = Time.now
      x["issue_number"] = issueNumber
      self.convertIssueCommentDatesInMongo(x)
    end
    return issueCommentsRaw
    # @coll.update(
    # 			{ "number" => x["number"]},
    # 			{ "$push" => {"comments_Text" => self.convertIssueCommentDatesInMongo(commentDetails)}}
    # 			)
  end

  # TODO Setup so it will get all repo events since the last time a request was made
  def getRepositoryEvents
    respositoryEvents = @ghClient.repository_events(@repository.to_s)
    respositoryEventsRaw = JSON.parse(@ghClient.last_response.body)

    ghLastReponse = @ghClient.last_response

    while ghLastReponse.rels.include?(:next) do
      ghLastReponse = ghLastReponse.rels[:next].get
      respositoryEventsRaw.concat(JSON.parse(ghLastReponse.body))
    end

    # Debug Code
    # puts "Got Repository Events, GitHub rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if respositoryEventsRaw.empty? == false
      respositoryEventsRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
        yDatesFixed = self.convertRepoEventsDates(y)
        self.putIntoMongoCollRepoEvents(yDatesFixed)
      end
    end
  end

  # TODO Setup so will get issues events since the last time they were downloaded
  # TODO Consider adding Issue Events directly into the Issue Object in Mongo
  def getIssueEvents (issueNumber)

    # issueNumbers = @coll.aggregate([
    # 								{ "$project" => {number: 1}},
    # 								{ "$group" => {_id: {number: "$number"}}},
    # 								{ "$sort" => {"_id.number" => 1}}
    # 								])
    issueEvents = @ghClient.issue_events(@repository, issueNumber)
    issueEventsRaw = JSON.parse(@ghClient.last_response.body)

    ghLastReponse = @ghClient.last_response

    while ghLastReponse.rels.include?(:next) do
      ghLastReponse = ghLastReponse.rels[:next].get
      issueEventsRaw.concat(JSON.parse(ghLastReponse.body))
    end

    if issueEventsRaw.empty? == false
      # Adds Repo and Issue number information into the hash of each event so multiple Repos can be stored in the same DB.
      # This was done becauase Issue Events do not have Issue number and Repo information.
      issueEventsRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["issue_number"] = issueNumber
        y["downloaded_at"] = Time.now
        yCorrectedDates = self.convertIssueEventsDates(y)
        self.putIntoMongoCollRepoIssuesEvents(yCorrectedDates)
      end
    end

    # Debug Code
    # puts "Got Repository Issue Events, GitHub rate limit remaining: " + @ghClient.rate_limit.remaining.to_s
  end

  # TODO This still needs work to function correctly.  Need to add new collection in db and a way to handle variable for the specific org to get data from
  def getOrgMemberList
    orgMemberList = @ghClient.org_members(@organization.to_s)
    orgMemberListRaw = JSON.parse(@ghClient.last_response.body)

    # Debug Code
    # puts "Got Organization member list, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if orgMemberListRaw.empty? == false
      orgMemberListRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
      end
      orgMemberListRaw = self.putIntoMongoCollOrgMembers(orgMemberListRaw)
      return orgMemberListRaw
    end
  end

  def getOrgTeamsInfoAllList
    orgTeamsList = @ghClient.organization_teams(@organization.to_s)
    orgTeamsListRaw = JSON.parse(@ghClient.last_response.body)

    # Debug Code
    # puts " Got Organization Teams list, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if orgTeamsListRaw.empty? == false
      orgTeamsListRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
        y["team_info"] = self.getOrgTeamInfo(y["id"])
        y["team_members"] = self.getOrgTeamMembers(y["id"])
        y["team_repos"] = self.getOrgTeamRepos(y["id"])
      end
      orgTeamsListRaw = self.putIntoMongoCollOrgTeamsInfoAllList(orgTeamsListRaw)
      return orgTeamsListRaw
    end
  end

  def getOrgTeamInfo(teamId)
    orgTeamInfo = @ghClient.team(teamId)
    orgTeamsInfoRaw = JSON.parse(@ghClient.last_response.body)

    #Debug Code
    # puts "Got Team info for Team: #{teamId}, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if orgTeamsInfoRaw.empty? == false
      orgTeamsInfoRaw["organization"] = @organization
      orgTeamsInfoRaw["repo"] = @repository
      orgTeamsInfoRaw["downloaded_at"] = Time.now
    end
    return orgTeamsInfoRaw
  end

  def getOrgTeamMembers(teamId)
    orgTeamMembers = @ghClient.team_members(teamId)
    orgTeamMembersRaw = JSON.parse(@ghClient.last_response.body)

    # Debug Code
    # puts "Got members list of team: #{teamId}, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if orgTeamMembersRaw.empty? == false
      orgTeamMembersRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
      end
    end
    return orgTeamMembersRaw
  end

  def getOrgTeamRepos(teamId)
    orgTeamRepos = @ghClient.team_repositories(teamId)
    orgTeamReposRaw = JSON.parse(@ghClient.last_response.body)
    # Debug Code
    # puts "Got list of repos for team: #{teamId}, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if orgTeamReposRaw.empty? == false
      orgTeamReposRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now

      end
      orgTeamReposRaw = self.convertTeamReposDates(orgTeamReposRaw)
      return orgTeamReposRaw
    end

  end

  def convertIssueCommentDatesInMongo(issueComments)
    issueComments["created_at"] = Time.strptime(issueComments["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    issueComments["updated_at"] = Time.strptime(issueComments["updated_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    return issueComments
  end

  def convertIssueDatesForMongo(issues)
    issues["created_at"] = Time.strptime(issues["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    issues["updated_at"] = Time.strptime(issues["updated_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    if issues["closed_at"] != nil
      issues["closed_at"] = Time.strptime(issues["closed_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    end
    return issues
  end

  def convertRepoEventsDates(repoEvents)
    repoEvents["created_at"] = Time.strptime(repoEvents["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    return repoEvents
  end

  def convertIssueEventsDates(issueEvents)
    issueEvents["created_at"] = Time.strptime(issueEvents["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    return issueEvents
  end

  def convertMilestoneDates(milestone)
    milestone["created_at"] = Time.strptime(milestone["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    milestone["updated_at"] = Time.strptime(milestone["updated_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    if milestone["due_on"]!= nil
      milestone["due_on"] = Time.strptime(milestone["updated_at"], '%Y-%m-%dT%H:%M:%S%z').utc
    end
    return milestone
  end

  def convertTeamReposDates(teamRepos)
    teamRepos.each do |x|
      if x["created_at"] != nil
        x["created_at"] = Time.strptime(x["created_at"], '%Y-%m-%dT%H:%M:%S%z').utc
      end
      if x["updated_at"]!= nil
        x["updated_at"] = Time.strptime(x["updated_at"], '%Y-%m-%dT%H:%M:%S%z').utc
      end
      if x["pushed_at"] != nil
        x["pushed_at"] = Time.strptime(x["pushed_at"], '%Y-%m-%dT%H:%M:%S%z').utc
      end
    end
    return teamRepos
  end

  def getMilestonesListforRepo
    # TODO build call to github to get list of milestones in a specific issue queue.
    # This will be used as part of the web app to select a milestone and return specific details filtered for that specific milestone.
    # Second option for cases were no Github.com access is avaliable will be to query mongodb to get a list of milestones from mongodb data.
    # This will be good for future needs when historical tracking is used to track changes in milestones or when milestone names are
    # changed or even deleted.

    repoOpenMilestoneList = @ghClient.list_milestones(@repository, :state => :open)
    repoOpenMilestoneListRaw = JSON.parse(@ghClient.last_response.body)

    ghLastReponseOpen = @ghClient.last_response

    while ghLastReponseOpen.rels.include?(:next) do
      ghLastReponseOpen = ghLastReponseOpen.rels[:next].get
      repoOpenMilestoneListRaw.concat(JSON.parse(ghLastReponseOpen.body))
    end


    repoClosedMilestoneList = @ghClient.list_milestones(@repository, :state => :closed)
    repoClosedMilestoneListRaw = JSON.parse(@ghClient.last_response.body)

    ghLastReponseClosed = @ghClient.last_response

    while ghLastReponseClosed.rels.include?(:next) do
      ghLastReponseClosed = ghLastReponseClosed.rels[:next].get
      repoClosedMilestoneListRaw.concat(JSON.parse(ghLastReponseClosed.body))
    end

    # Debug Code
    # puts "Got Open and Closed Milestones list, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    if repoOpenMilestoneListRaw.empty? == false
      repoOpenMilestoneListRaw.each do |x|
        x["organization"] = @organization
        x["repo"] = @repository
        x["downloaded_at"] = Time.now
        xDatesFixed = self.convertMilestoneDates(x)
        self.putIntoMongoCollRepoMilestonesList(xDatesFixed)
      end
    end
    if repoClosedMilestoneListRaw.empty? == false
      repoClosedMilestoneListRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
        yDatesFixed = self.convertMilestoneDates(y)
        self.putIntoMongoCollRepoMilestonesList(yDatesFixed)
      end
    end

    # Debug Code but will eventually become output for web app
    if repoOpenMilestoneListRaw.empty? == true and repoClosedMilestoneListRaw.empty? == true
      puts "No Open or Closed Milestones"
    end
  end

  # Gets list of all Repos
  def getRepoLabelsList
    repoLabelsList = @ghClient.labels(@repository)
    repoLabelsListRaw = JSON.parse(@ghClient.last_response.body)

    # Debug Code
    # puts "Got Repo Labels list, Github rate limit remaining: " + @ghClient.rate_limit.remaining.to_s

    ghLastReponse = @ghClient.last_response

    while ghLastReponse.rels.include?(:next) do
      ghLastReponse = ghLastReponse.rels[:next].get
      repoLabelsListRaw.concat(JSON.parse(ghLastReponse.body))
    end

    if repoLabelsListRaw.empty? == false
      repoLabelsListRaw.each do |y|
        y["organization"] = @organization
        y["repo"] = @repository
        y["downloaded_at"] = Time.now
      end
      repoLabelsListRaw = self.putIntoMongoCollRepoLabelsList(repoLabelsListRaw)
    end
    return repoLabelsListRaw
  end
end

start = IssueDownload.new("wet-boew/wet-boew-wpss", :mongoClearRecords => true)
# start = IssueDownload.new("stephenOTT/test1", :mongoClearRecords => true)
# start = IssueDownload.new("wet-boew/wet-boew-drupal", :mongoClearRecords => true)
# start = IssueDownload.new("StephenOTT/Test1", true)
# start = IssueDownload.new("wet-boew/wet-boew-drupal")

start.ghAuthenticate("USERNAME", "PASSWORD")
start.getIssues
# start.getRepositoryEvents
# start.getOrgMemberList
# start.getOrgTeamsInfoAllList
# start.getRepoLabelsList
# start.getMilestonesListforRepo