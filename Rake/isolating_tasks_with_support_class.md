# Isolating Your Task Using a Class

I’ll start with an example because it make easy to understand the concept.

We have an App kind of StackOverflow, our users can make questions, answer them, leave comments and so, and we already have a lot of information in our database. Sunddenly we decided to implement a Badge System in our app.

Now that we developed the Badge System, we only need to recalculate the badges for every user. Now it’s the time to use a rake task.
Bad

# lib/tasks/users/recalculate_badges.rake
namespace :users do
  desc 'Recalculates Badges for All Users'
  task recalculate_badges: :environment do
    User.find_each do |user|

      # Grants teacher badge
      if user.answers.with_votes_count_greater_than(5).count >= 1
        user.grant_badge('teacher')
      end

      ...

      # Grants favorite question badge
      user.questions.find_each do |question|
        if question.followers_count >= 25
          user.grant_badge('favorite question') && break
        end
      end

      # Grants stellar question badge
      user.questions.find_each do |question|
        if question.followers_count >= 100
          user.grant_badge('stellar question') && break
        end
      end

    end
  end
end

This task may seem simple to understand but it has a lot of problems:

    It’s hard to test.
    We have a lot of logic that is not isolated.
    We have duplication.
    This task is very large and almost imposible to read. Imagine that you have 25 badges and one condition per badge. This task would have more than 150 lines.

Good

Now that we pointed all things that’s wrong with this task, let’s fix it. We’ll extract all the logic and move it to a Service Object.

## lib/tasks/users/recalculate_badges.rake

	namespace :users do
  desc 'Recalculates Badges for All Users'
  task recalculate_badges: :environment do
    User.find_each do |user|

      RecalculateBadges.new(user).all

    end
 	 end
	end

## app/services/recalculate_badges.rb

	class RecalculateBadges

  attr_reader :user, :questions, :answers

  def initialize(user)
    @user      = user
    @questions = user.questions
    @answers   = user.answers
  end

  def all
    teacher
    favorite_question
    stellar_question
  end

  def teacher
    ...
    grant_badge('teacher')
  end

  def favorite_question
    question_followers_count_badge(25, 'favorite question')
  end

  def stellar_question
    question_followers_count_badge(100, 'stellar question')
  end

  private

    def grant_badge(badge_name)
      return unless badge_name
      user.grant_badge(badge_name)
    end

    def question_followers_count_badge(followers_count, badge_name)
      ...
      grant(badge_name)
    end

end

Now we extracted all the logic to an specific class you will notice the following benefits:

    Our rake’s logic is easier to read and understand, now every method on our RecalculateBadges class represents a badge and we have the all method which triggers all badge methods.
    We can test every badge logic on isolation and it will be very easy to test.
    We removed duplication.

There are some important concepts I would like to highlight:

    For Service Objects always prefer instance methods over class methods, they are much easier to refactor.
    Notice that our Service Object performs operation over a single user and not the entire collection, this give us more flexibility if we want to re use this class anywhere else on our applicati