

# Rake Routes

 Prefix Verb   URI Pattern                                            Controller#Action
                   systems GET    /systems(.:format)                                     systems#index
                           POST   /systems(.:format)                                     systems#create
                new_system GET    /systems/new(.:format)                                 systems#new
               edit_system GET    /systems/:id/edit(.:format)                            systems#edit
                    system GET    /systems/:id(.:format)                                 systems#show
                           PATCH  /systems/:id(.:format)                                 systems#update
                           PUT    /systems/:id(.:format)                                 systems#update
                           DELETE /systems/:id(.:format)                                 systems#destroy
        api_project_issues GET    /api/projects/:project_id/issues(.:format)             api/issues#index
                           POST   /api/projects/:project_id/issues(.:format)             api/issues#create
     new_api_project_issue GET    /api/projects/:project_id/issues/new(.:format)         api/issues#new
    edit_api_project_issue GET    /api/projects/:project_id/issues/:id/edit(.:format)    api/issues#edit
         api_project_issue GET    /api/projects/:project_id/issues/:id(.:format)         api/issues#show
                           PATCH  /api/projects/:project_id/issues/:id(.:format)         api/issues#update
                           PUT    /api/projects/:project_id/issues/:id(.:format)         api/issues#update
                           DELETE /api/projects/:project_id/issues/:id(.:format)         api/issues#destroy
              api_projects GET    /api/projects(.:format)                                api/projects#index
                           POST   /api/projects(.:format)                                api/projects#create
           new_api_project GET    /api/projects/new(.:format)                            api/projects#new
          edit_api_project GET    /api/projects/:id/edit(.:format)                       api/projects#edit
               api_project GET    /api/projects/:id(.:format)                            api/projects#show
                           PATCH  /api/projects/:id(.:format)                            api/projects#update
                           PUT    /api/projects/:id(.:format)                            api/projects#update
                           DELETE /api/projects/:id(.:format)                            api/projects#destroy
       api_server_services GET    /api/servers/:server_id/services(.:format)             api/services#index
                           POST   /api/servers/:server_id/services(.:format)             api/services#create
    new_api_server_service GET    /api/servers/:server_id/services/new(.:format)         api/services#new
   edit_api_server_service GET    /api/servers/:server_id/services/:id/edit(.:format)    api/services#edit
        api_server_service GET    /api/servers/:server_id/services/:id(.:format)         api/services#show
                           PATCH  /api/servers/:server_id/services/:id(.:format)         api/services#update
                           PUT    /api/servers/:server_id/services/:id(.:format)         api/services#update
                           DELETE /api/servers/:server_id/services/:id(.:format)         api/services#destroy
    api_server_connections GET    /api/servers/:server_id/connections(.:format)          api/connections#index
                           POST   /api/servers/:server_id/connections(.:format)          api/connections#create
 new_api_server_connection GET    /api/servers/:server_id/connections/new(.:format)      api/connections#new
edit_api_server_connection GET    /api/servers/:server_id/connections/:id/edit(.:format) api/connections#edit
     api_server_connection GET    /api/servers/:server_id/connections/:id(.:format)      api/connections#show
                           PATCH  /api/servers/:server_id/connections/:id(.:format)      api/connections#update
                           PUT    /api/servers/:server_id/connections/:id(.:format)      api/connections#update
                           DELETE /api/servers/:server_id/connections/:id(.:format)      api/connections#destroy
           api_server_pids GET    /api/servers/:server_id/pids(.:format)                 api/pids#index
                           POST   /api/servers/:server_id/pids(.:format)                 api/pids#create
        new_api_server_pid GET    /api/servers/:server_id/pids/new(.:format)             api/pids#new
       edit_api_server_pid GET    /api/servers/:server_id/pids/:id/edit(.:format)        api/pids#edit
            api_server_pid GET    /api/servers/:server_id/pids/:id(.:format)             api/pids#show
                           PATCH  /api/servers/:server_id/pids/:id(.:format)             api/pids#update
                           PUT    /api/servers/:server_id/pids/:id(.:format)             api/pids#update
                           DELETE /api/servers/:server_id/pids/:id(.:format)             api/pids#destroy
               api_servers GET    /api/servers(.:format)                                 api/servers#index
                           POST   /api/servers(.:format)                                 api/servers#create
            new_api_server GET    /api/servers/new(.:format)                             api/servers#new
           edit_api_server GET    /api/servers/:id/edit(.:format)                        api/servers#edit
                api_server GET    /api/servers/:id(.:format)                             api/servers#show
                           PATCH  /api/servers/:id(.:format)                             api/servers#update
                           PUT    /api/servers/:id(.:format)                             api/servers#update
                           DELETE /api/servers/:id(.:format)                             api/servers#destroy
             progress_main GET    /progress/main(.:format)                               progress#main
           progress_detail GET    /progress/detail(.:format)                             progress#detail
           progress_graphs GET    /progress/graphs(.:format)                             progress#graphs
       progress_statistics GET    /progress/statistics(.:format)                         progress#statistics
               files_index GET    /files/index(.:format)                                 files#index
            files_download GET    /files/download(.:format)                              files#download
              files_upload GET    /files/upload(.:format)                                files#upload
              public_index GET    /public/index(.:format)                                public#index
               public_show GET    /public/show(.:format)                                 public#show
        project_issuelists GET    /projects/:project_id/issuelists(.:format)             issuelists#index
                           POST   /projects/:project_id/issuelists(.:format)             issuelists#create
     new_project_issuelist GET    /projects/:project_id/issuelists/new(.:format)         issuelists#new
    edit_project_issuelist GET    /projects/:project_id/issuelists/:id/edit(.:format)    issuelists#edit
         project_issuelist GET    /projects/:project_id/issuelists/:id(.:format)         issuelists#show
                           PATCH  /projects/:project_id/issuelists/:id(.:format)         issuelists#update
                           PUT    /projects/:project_id/issuelists/:id(.:format)         issuelists#update
                           DELETE /projects/:project_id/issuelists/:id(.:format)         issuelists#destroy
         project_tasklists GET    /projects/:project_id/tasklists(.:format)              tasklists#index
                           POST   /projects/:project_id/tasklists(.:format)              tasklists#create
      new_project_tasklist GET    /projects/:project_id/tasklists/new(.:format)          tasklists#new
     edit_project_tasklist GET    /projects/:project_id/tasklists/:id/edit(.:format)     tasklists#edit
          project_tasklist GET    /projects/:project_id/tasklists/:id(.:format)          tasklists#show
                           PATCH  /projects/:project_id/tasklists/:id(.:format)          tasklists#update
                           PUT    /projects/:project_id/tasklists/:id(.:format)          tasklists#update
                           DELETE /projects/:project_id/tasklists/:id(.:format)          tasklists#destroy
                  projects GET    /projects(.:format)                                    projects#index
                           POST   /projects(.:format)                                    projects#create
               new_project GET    /projects/new(.:format)                                projects#new
              edit_project GET    /projects/:id/edit(.:format)                           projects#edit
                   project GET    /projects/:id(.:format)                                projects#show
                           PATCH  /projects/:id(.:format)                                projects#update
                           PUT    /projects/:id(.:format)                                projects#update
                           DELETE /projects/:id(.:format)                                projects#destroy
             notifications GET    /notifications(.:format)                               notifications#index
                           POST   /notifications(.:format)                               notifications#create
          new_notification GET    /notifications/new(.:format)                           notifications#new
         edit_notification GET    /notifications/:id/edit(.:format)                      notifications#edit
              notification GET    /notifications/:id(.:format)                           notifications#show
                           PATCH  /notifications/:id(.:format)                           notifications#update
                           PUT    /notifications/:id(.:format)                           notifications#update
                           DELETE /notifications/:id(.:format)                           notifications#destroy
                  networks GET    /networks(.:format)                                    networks#index
                           POST   /networks(.:format)                                    networks#create
               new_network GET    /networks/new(.:format)                                networks#new
              edit_network GET    /networks/:id/edit(.:format)                           networks#edit
                   network GET    /networks/:id(.:format)                                networks#show
                           PATCH  /networks/:id(.:format)                                networks#update
                           PUT    /networks/:id(.:format)                                networks#update
                           DELETE /networks/:id(.:format)                                networks#destroy
             network_boxes GET    /network_boxes(.:format)                               network_boxes#index
                           POST   /network_boxes(.:format)                               network_boxes#create
           new_network_box GET    /network_boxes/new(.:format)                           network_boxes#new
          edit_network_box GET    /network_boxes/:id/edit(.:format)                      network_boxes#edit
               network_box GET    /network_boxes/:id(.:format)                           network_boxes#show
                           PATCH  /network_boxes/:id(.:format)                           network_boxes#update
                           PUT    /network_boxes/:id(.:format)                           network_boxes#update
                           DELETE /network_boxes/:id(.:format)                           network_boxes#destroy
               memberships GET    /memberships(.:format)                                 memberships#index
                           POST   /memberships(.:format)                                 memberships#create
            new_membership GET    /memberships/new(.:format)                             memberships#new
           edit_membership GET    /memberships/:id/edit(.:format)                        memberships#edit
                membership GET    /memberships/:id(.:format)                             memberships#show
                           PATCH  /memberships/:id(.:format)                             memberships#update
                           PUT    /memberships/:id(.:format)                             memberships#update
                           DELETE /memberships/:id(.:format)                             memberships#destroy
                  logfiles GET    /logfiles(.:format)                                    logfiles#index
                           POST   /logfiles(.:format)                                    logfiles#create
               new_logfile GET    /logfiles/new(.:format)                                logfiles#new
              edit_logfile GET    /logfiles/:id/edit(.:format)                           logfiles#edit
                   logfile GET    /logfiles/:id(.:format)                                logfiles#show
                           PATCH  /logfiles/:id(.:format)                                logfiles#update
                           PUT    /logfiles/:id(.:format)                                logfiles#update
                           DELETE /logfiles/:id(.:format)                                logfiles#destroy
                logentries GET    /logentries(.:format)                                  logentries#index
                           POST   /logentries(.:format)                                  logentries#create
              new_logentry GET    /logentries/new(.:format)                              logentries#new
             edit_logentry GET    /logentries/:id/edit(.:format)                         logentries#edit
                  logentry GET    /logentries/:id(.:format)                              logentries#show
                           PATCH  /logentries/:id(.:format)                              logentries#update
                           PUT    /logentries/:id(.:format)                              logentries#update
                           DELETE /logentries/:id(.:format)                              logentries#destroy
                 hardwares GET    /hardwares(.:format)                                   hardwares#index
                           POST   /hardwares(.:format)                                   hardwares#create
              new_hardware GET    /hardwares/new(.:format)                               hardwares#new
             edit_hardware GET    /hardwares/:id/edit(.:format)                          hardwares#edit
                  hardware GET    /hardwares/:id(.:format)                               hardwares#show
                           PATCH  /hardwares/:id(.:format)                               hardwares#update
                           PUT    /hardwares/:id(.:format)                               hardwares#update
                           DELETE /hardwares/:id(.:format)                               hardwares#destroy
                   githubs GET    /githubs(.:format)                                     githubs#index
                           POST   /githubs(.:format)                                     githubs#create
                new_github GET    /githubs/new(.:format)                                 githubs#new
               edit_github GET    /githubs/:id/edit(.:format)                            githubs#edit
                    github GET    /githubs/:id(.:format)                                 githubs#show
                           PATCH  /githubs/:id(.:format)                                 githubs#update
                           PUT    /githubs/:id(.:format)                                 githubs#update
                           DELETE /githubs/:id(.:format)                                 githubs#destroy
                     gists GET    /gists(.:format)                                       gists#index
                           POST   /gists(.:format)                                       gists#create
                  new_gist GET    /gists/new(.:format)                                   gists#new
                 edit_gist GET    /gists/:id/edit(.:format)                              gists#edit
                      gist GET    /gists/:id(.:format)                                   gists#show
                           PATCH  /gists/:id(.:format)                                   gists#update
                           PUT    /gists/:id(.:format)                                   gists#update
                           DELETE /gists/:id(.:format)                                   gists#destroy
                    groups GET    /groups(.:format)                                      groups#index
                           POST   /groups(.:format)                                      groups#create
                 new_group GET    /groups/new(.:format)                                  groups#new
                edit_group GET    /groups/:id/edit(.:format)                             groups#edit
                     group GET    /groups/:id(.:format)                                  groups#show
                           PATCH  /groups/:id(.:format)                                  groups#update
                           PUT    /groups/:id(.:format)                                  groups#update
                           DELETE /groups/:id(.:format)                                  groups#destroy
               domainnames GET    /domainnames(.:format)                                 domainnames#index
                           POST   /domainnames(.:format)                                 domainnames#create
            new_domainname GET    /domainnames/new(.:format)                             domainnames#new
           edit_domainname GET    /domainnames/:id/edit(.:format)                        domainnames#edit
                domainname GET    /domainnames/:id(.:format)                             domainnames#show
                           PATCH  /domainnames/:id(.:format)                             domainnames#update
                           PUT    /domainnames/:id(.:format)                             domainnames#update
                           DELETE /domainnames/:id(.:format)                             domainnames#destroy
                           GET    /networks(.:format)                                    networks#index
                           POST   /networks(.:format)                                    networks#create
                           GET    /networks/new(.:format)                                networks#new
                           GET    /networks/:id/edit(.:format)                           networks#edit
                           GET    /networks/:id(.:format)                                networks#show
                           PATCH  /networks/:id(.:format)                                networks#update
                           PUT    /networks/:id(.:format)                                networks#update
                           DELETE /networks/:id(.:format)                                networks#destroy
                  clusters GET    /clusters(.:format)                                    clusters#index
                           POST   /clusters(.:format)                                    clusters#create
               new_cluster GET    /clusters/new(.:format)                                clusters#new
              edit_cluster GET    /clusters/:id/edit(.:format)                           clusters#edit
                   cluster GET    /clusters/:id(.:format)                                clusters#show
                           PATCH  /clusters/:id(.:format)                                clusters#update
                           PUT    /clusters/:id(.:format)                                clusters#update
                           DELETE /clusters/:id(.:format)                                clusters#destroy
                  services GET    /services(.:format)                                    services#index
                           POST   /services(.:format)                                    services#create
               new_service GET    /services/new(.:format)                                services#new
              edit_service GET    /services/:id/edit(.:format)                           services#edit
                   service GET    /services/:id(.:format)                                services#show
                           PATCH  /services/:id(.:format)                                services#update
                           PUT    /services/:id(.:format)                                services#update
                           DELETE /services/:id(.:format)                                services#destroy
           infrastructures GET    /infrastructures(.:format)                             infrastructures#index
                           POST   /infrastructures(.:format)                             infrastructures#create
        new_infrastructure GET    /infrastructures/new(.:format)                         infrastructures#new
       edit_infrastructure GET    /infrastructures/:id/edit(.:format)                    infrastructures#edit
            infrastructure GET    /infrastructures/:id(.:format)                         infrastructures#show
                           PATCH  /infrastructures/:id(.:format)                         infrastructures#update
                           PUT    /infrastructures/:id(.:format)                         infrastructures#update
                           DELETE /infrastructures/:id(.:format)                         infrastructures#destroy
             organizations GET    /organizations(.:format)                               organizations#index
                           POST   /organizations(.:format)                               organizations#create
          new_organization GET    /organizations/new(.:format)                           organizations#new
         edit_organization GET    /organizations/:id/edit(.:format)                      organizations#edit
              organization GET    /organizations/:id(.:format)                           organizations#show
                           PATCH  /organizations/:id(.:format)                           organizations#update
                           PUT    /organizations/:id(.:format)                           organizations#update
                           DELETE /organizations/:id(.:format)                           organizations#destroy
                    labels GET    /labels(.:format)                                      labels#index
                           POST   /labels(.:format)                                      labels#create
                 new_label GET    /labels/new(.:format)                                  labels#new
                edit_label GET    /labels/:id/edit(.:format)                             labels#edit
                     label GET    /labels/:id(.:format)                                  labels#show
                           PATCH  /labels/:id(.:format)                                  labels#update
                           PUT    /labels/:id(.:format)                                  labels#update
                           DELETE /labels/:id(.:format)                                  labels#destroy
                milestones GET    /milestones(.:format)                                  milestones#index
                           POST   /milestones(.:format)                                  milestones#create
             new_milestone GET    /milestones/new(.:format)                              milestones#new
            edit_milestone GET    /milestones/:id/edit(.:format)                         milestones#edit
                 milestone GET    /milestones/:id(.:format)                              milestones#show
                           PATCH  /milestones/:id(.:format)                              milestones#update
                           PUT    /milestones/:id(.:format)                              milestones#update
                           DELETE /milestones/:id(.:format)                              milestones#destroy
                     todos GET    /todos(.:format)                                       todos#index
                           POST   /todos(.:format)                                       todos#create
                  new_todo GET    /todos/new(.:format)                                   todos#new
                 edit_todo GET    /todos/:id/edit(.:format)                              todos#edit
                      todo GET    /todos/:id(.:format)                                   todos#show
                           PATCH  /todos/:id(.:format)                                   todos#update
                           PUT    /todos/:id(.:format)                                   todos#update
                           DELETE /todos/:id(.:format)                                   todos#destroy
            tasklist_tasks GET    /tasklists/:tasklist_id/tasks(.:format)                tasks#index
                           POST   /tasklists/:tasklist_id/tasks(.:format)                tasks#create
         new_tasklist_task GET    /tasklists/:tasklist_id/tasks/new(.:format)            tasks#new
        edit_tasklist_task GET    /tasklists/:tasklist_id/tasks/:id/edit(.:format)       tasks#edit
             tasklist_task GET    /tasklists/:tasklist_id/tasks/:id(.:format)            tasks#show
                           PATCH  /tasklists/:tasklist_id/tasks/:id(.:format)            tasks#update
                           PUT    /tasklists/:tasklist_id/tasks/:id(.:format)            tasks#update
                           DELETE /tasklists/:tasklist_id/tasks/:id(.:format)            tasks#destroy
                 tasklists GET    /tasklists(.:format)                                   tasklists#index
                           POST   /tasklists(.:format)                                   tasklists#create
              new_tasklist GET    /tasklists/new(.:format)                               tasklists#new
             edit_tasklist GET    /tasklists/:id/edit(.:format)                          tasklists#edit
                  tasklist GET    /tasklists/:id(.:format)                               tasklists#show
                           PATCH  /tasklists/:id(.:format)                               tasklists#update
                           PUT    /tasklists/:id(.:format)                               tasklists#update
                           DELETE /tasklists/:id(.:format)                               tasklists#destroy
          issuelist_issues GET    /issuelists/:issuelist_id/issues(.:format)             issues#index
                           POST   /issuelists/:issuelist_id/issues(.:format)             issues#create
       new_issuelist_issue GET    /issuelists/:issuelist_id/issues/new(.:format)         issues#new
      edit_issuelist_issue GET    /issuelists/:issuelist_id/issues/:id/edit(.:format)    issues#edit
           issuelist_issue GET    /issuelists/:issuelist_id/issues/:id(.:format)         issues#show
                           PATCH  /issuelists/:issuelist_id/issues/:id(.:format)         issues#update
                           PUT    /issuelists/:issuelist_id/issues/:id(.:format)         issues#update
                           DELETE /issuelists/:issuelist_id/issues/:id(.:format)         issues#destroy
                issuelists GET    /issuelists(.:format)                                  issuelists#index
                           POST   /issuelists(.:format)                                  issuelists#create
             new_issuelist GET    /issuelists/new(.:format)                              issuelists#new
            edit_issuelist GET    /issuelists/:id/edit(.:format)                         issuelists#edit
                 issuelist GET    /issuelists/:id(.:format)                              issuelists#show
                           PATCH  /issuelists/:id(.:format)                              issuelists#update
                           PUT    /issuelists/:id(.:format)                              issuelists#update
                           DELETE /issuelists/:id(.:format)                              issuelists#destroy
                       ips GET    /ips(.:format)                                         ips#index
                           POST   /ips(.:format)                                         ips#create
                    new_ip GET    /ips/new(.:format)                                     ips#new
                   edit_ip GET    /ips/:id/edit(.:format)                                ips#edit
                        ip GET    /ips/:id(.:format)                                     ips#show
                           PATCH  /ips/:id(.:format)                                     ips#update
                           PUT    /ips/:id(.:format)                                     ips#update
                           DELETE /ips/:id(.:format)                                     ips#destroy
                home_slice GET    /home/slice(.:format)                                  home#slice
                           GET    /ips(.:format)                                         ips#index
                           POST   /ips(.:format)                                         ips#create
                           GET    /ips/new(.:format)                                     ips#new
                           GET    /ips/:id/edit(.:format)                                ips#edit
                           GET    /ips/:id(.:format)                                     ips#show
                           PATCH  /ips/:id(.:format)                                     ips#update
                           PUT    /ips/:id(.:format)                                     ips#update
                           DELETE /ips/:id(.:format)                                     ips#destroy
               reputations GET    /reputations(.:format)                                 reputations#index
                           POST   /reputations(.:format)                                 reputations#create
            new_reputation GET    /reputations/new(.:format)                             reputations#new
           edit_reputation GET    /reputations/:id/edit(.:format)                        reputations#edit
                reputation GET    /reputations/:id(.:format)                             reputations#show
                           PATCH  /reputations/:id(.:format)                             reputations#update
                           PUT    /reputations/:id(.:format)                             reputations#update
                           DELETE /reputations/:id(.:format)                             reputations#destroy
                           GET    /ips(.:format)                                         ips#index
                           POST   /ips(.:format)                                         ips#create
                           GET    /ips/new(.:format)                                     ips#new
                           GET    /ips/:id/edit(.:format)                                ips#edit
                           GET    /ips/:id(.:format)                                     ips#show
                           PATCH  /ips/:id(.:format)                                     ips#update
                           PUT    /ips/:id(.:format)                                     ips#update
                           DELETE /ips/:id(.:format)                                     ips#destroy
                           GET    /organizations(.:format)                               organizations#index
                           POST   /organizations(.:format)                               organizations#create
                           GET    /organizations/new(.:format)                           organizations#new
                           GET    /organizations/:id/edit(.:format)                      organizations#edit
                           GET    /organizations/:id(.:format)                           organizations#show
                           PATCH  /organizations/:id(.:format)                           organizations#update
                           PUT    /organizations/:id(.:format)                           organizations#update
                           DELETE /organizations/:id(.:format)                           organizations#destroy
                     nodes GET    /nodes(.:format)                                       nodes#index
                           POST   /nodes(.:format)                                       nodes#create
                  new_node GET    /nodes/new(.:format)                                   nodes#new
                 edit_node GET    /nodes/:id/edit(.:format)                              nodes#edit
                      node GET    /nodes/:id(.:format)                                   nodes#show
                           PATCH  /nodes/:id(.:format)                                   nodes#update
                           PUT    /nodes/:id(.:format)                                   nodes#update
                           DELETE /nodes/:id(.:format)                                   nodes#destroy
                   servers GET    /servers(.:format)                                     servers#index
                           POST   /servers(.:format)                                     servers#create
                new_server GET    /servers/new(.:format)                                 servers#new
               edit_server GET    /servers/:id/edit(.:format)                            servers#edit
                    server GET    /servers/:id(.:format)                                 servers#show
                           PATCH  /servers/:id(.:format)                                 servers#update
                           PUT    /servers/:id(.:format)                                 servers#update
                           DELETE /servers/:id(.:format)                                 servers#destroy
           dashboard_index GET    /dashboard/index(.:format)                             dashboard#index
        dashboard_controls GET    /dashboard/controls(.:format)                          dashboard#controls
        dashboard_analysis GET    /dashboard/analysis(.:format)                          dashboard#analysis
          new_user_session GET    /users/sign_in(.:format)                               devise/sessions#new
              user_session POST   /users/sign_in(.:format)                               devise/sessions#create
      destroy_user_session DELETE /users/sign_out(.:format)                              devise/sessions#destroy
             user_password POST   /users/password(.:format)                              devise/passwords#create
         new_user_password GET    /users/password/new(.:format)                          devise/passwords#new
        edit_user_password GET    /users/password/edit(.:format)                         devise/passwords#edit
                           PATCH  /users/password(.:format)                              devise/passwords#update
                           PUT    /users/password(.:format)                              devise/passwords#update
  cancel_user_registration GET    /users/cancel(.:format)                                devise/registrations#cancel
         user_registration POST   /users(.:format)                                       devise/registrations#create
     new_user_registration GET    /users/sign_up(.:format)                               devise/registrations#new
    edit_user_registration GET    /users/edit(.:format)                                  devise/registrations#edit
                           PATCH  /users(.:format)                                       devise/registrations#update
                           PUT    /users(.:format)                                       devise/registrations#update
                           DELETE /users(.:format)                                       devise/registrations#destroy
           clusterjobs_new GET    /clusterjobs/new(.:format)                             clusterjobs#new
         clusterjobs_index GET    /clusterjobs/index(.:format)                           clusterjobs#index
                main_index GET    /main/index(.:format)                                  main#index
                      root GET    /                                                      main#index
                           GET    /systems(.:format)                                     systems#index
                           POST   /systems(.:format)                                     systems#create
                           GET    /systems/new(.:format)                                 systems#new
                           GET    /systems/:id/edit(.:format)                            systems#edit
                           GET    /systems/:id(.:format)                                 systems#show
                           PATCH  /systems/:id(.:format)                                 systems#update
                           PUT    /systems/:id(.:format)                                 systems#update
                           DELETE /systems/:id(.:format)                                 systems#destroy
                           GET    /progress/main(.:format)                               progress#main
                           GET    /progress/detail(.:format)                             progress#detail
                           GET    /progress/graphs(.:format)                             progress#graphs
                           GET    /progress/statistics(.:format)                         progress#statistics
                           GET    /files/index(.:format)                                 files#index
                           GET    /files/download(.:format)                              files#download
                           GET    /files/upload(.:format)                                files#upload
                           GET    /public/index(.:format)                                public#index
                           GET    /public/show(.:format)                                 public#show
                           GET    /notifications(.:format)                               notifications#index
                           POST   /notifications(.:format)                               notifications#create
                           GET    /notifications/new(.:format)                           notifications#new
                           GET    /notifications/:id/edit(.:format)                      notifications#edit
                           GET    /notifications/:id(.:format)                           notifications#show
                           PATCH  /notifications/:id(.:format)                           notifications#update
                           PUT    /notifications/:id(.:format)                           notifications#update
                           DELETE /notifications/:id(.:format)                           notifications#destroy
                           GET    /networks(.:format)                                    networks#index
                           POST   /networks(.:format)                                    networks#create
                           GET    /networks/new(.:format)                                networks#new
                           GET    /networks/:id/edit(.:format)                           networks#edit
                           GET    /networks/:id(.:format)                                networks#show
                           PATCH  /networks/:id(.:format)                                networks#update
                           PUT    /networks/:id(.:format)                                networks#update
                           DELETE /networks/:id(.:format)                                networks#destroy
                           GET    /network_boxes(.:format)                               network_boxes#index
                           POST   /network_boxes(.:format)                               network_boxes#create
                           GET    /network_boxes/new(.:format)                           network_boxes#new
                           GET    /network_boxes/:id/edit(.:format)                      network_boxes#edit
                           GET    /network_boxes/:id(.:format)                           network_boxes#show
                           PATCH  /network_boxes/:id(.:format)                           network_boxes#update
                           PUT    /network_boxes/:id(.:format)                           network_boxes#update
                           DELETE /network_boxes/:id(.:format)                           network_boxes#destroy
                           GET    /memberships(.:format)                                 memberships#index
                           POST   /memberships(.:format)                                 memberships#create
                           GET    /memberships/new(.:format)                             memberships#new
                           GET    /memberships/:id/edit(.:format)                        memberships#edit
                           GET    /memberships/:id(.:format)                             memberships#show
                           PATCH  /memberships/:id(.:format)                             memberships#update
                           PUT    /memberships/:id(.:format)                             memberships#update
                           DELETE /memberships/:id(.:format)                             memberships#destroy
                           GET    /logfiles(.:format)                                    logfiles#index
                           POST   /logfiles(.:format)                                    logfiles#create
                           GET    /logfiles/new(.:format)                                logfiles#new
                           GET    /logfiles/:id/edit(.:format)                           logfiles#edit
                           GET    /logfiles/:id(.:format)                                logfiles#show
                           PATCH  /logfiles/:id(.:format)                                logfiles#update
                           PUT    /logfiles/:id(.:format)                                logfiles#update
                           DELETE /logfiles/:id(.:format)                                logfiles#destroy
                           GET    /logentries(.:format)                                  logentries#index
                           POST   /logentries(.:format)                                  logentries#create
                           GET    /logentries/new(.:format)                              logentries#new
                           GET    /logentries/:id/edit(.:format)                         logentries#edit
                           GET    /logentries/:id(.:format)                              logentries#show
                           PATCH  /logentries/:id(.:format)                              logentries#update
                           PUT    /logentries/:id(.:format)                              logentries#update
                           DELETE /logentries/:id(.:format)                              logentries#destroy
                           GET    /hardwares(.:format)                                   hardwares#index
                           POST   /hardwares(.:format)                                   hardwares#create
                           GET    /hardwares/new(.:format)                               hardwares#new
                           GET    /hardwares/:id/edit(.:format)                          hardwares#edit
                           GET    /hardwares/:id(.:format)                               hardwares#show
                           PATCH  /hardwares/:id(.:format)                               hardwares#update
                           PUT    /hardwares/:id(.:format)                               hardwares#update
                           DELETE /hardwares/:id(.:format)                               hardwares#destroy
                           GET    /githubs(.:format)                                     githubs#index
                           POST   /githubs(.:format)                                     githubs#create
                           GET    /githubs/new(.:format)                                 githubs#new
                           GET    /githubs/:id/edit(.:format)                            githubs#edit
                           GET    /githubs/:id(.:format)                                 githubs#show
                           PATCH  /githubs/:id(.:format)                                 githubs#update
                           PUT    /githubs/:id(.:format)                                 githubs#update
                           DELETE /githubs/:id(.:format)                                 githubs#destroy
                           GET    /gists(.:format)                                       gists#index
                           POST   /gists(.:format)                                       gists#create
                           GET    /gists/new(.:format)                                   gists#new
                           GET    /gists/:id/edit(.:format)                              gists#edit
                           GET    /gists/:id(.:format)                                   gists#show
                           PATCH  /gists/:id(.:format)                                   gists#update
                           PUT    /gists/:id(.:format)                                   gists#update
                           DELETE /gists/:id(.:format)                                   gists#destroy
                           GET    /groups(.:format)                                      groups#index
                           POST   /groups(.:format)                                      groups#create
                           GET    /groups/new(.:format)                                  groups#new
                           GET    /groups/:id/edit(.:format)                             groups#edit
                           GET    /groups/:id(.:format)                                  groups#show
                           PATCH  /groups/:id(.:format)                                  groups#update
                           PUT    /groups/:id(.:format)                                  groups#update
                           DELETE /groups/:id(.:format)                                  groups#destroy
                           GET    /domainnames(.:format)                                 domainnames#index
                           POST   /domainnames(.:format)                                 domainnames#create
                           GET    /domainnames/new(.:format)                             domainnames#new
                           GET    /domainnames/:id/edit(.:format)                        domainnames#edit
                           GET    /domainnames/:id(.:format)                             domainnames#show
                           PATCH  /domainnames/:id(.:format)                             domainnames#update
                           PUT    /domainnames/:id(.:format)                             domainnames#update
                           DELETE /domainnames/:id(.:format)                             domainnames#destroy
                           GET    /networks(.:format)                                    networks#index
                           POST   /networks(.:format)                                    networks#create
                           GET    /networks/new(.:format)                                networks#new
                           GET    /networks/:id/edit(.:format)                           networks#edit
                           GET    /networks/:id(.:format)                                networks#show
                           PATCH  /networks/:id(.:format)                                networks#update
                           PUT    /networks/:id(.:format)                                networks#update
                           DELETE /networks/:id(.:format)                                networks#destroy
                           GET    /clusters(.:format)                                    clusters#index
                           POST   /clusters(.:format)                                    clusters#create
                           GET    /clusters/new(.:format)                                clusters#new
                           GET    /clusters/:id/edit(.:format)                           clusters#edit
                           GET    /clusters/:id(.:format)                                clusters#show
                           PATCH  /clusters/:id(.:format)                                clusters#update
                           PUT    /clusters/:id(.:format)                                clusters#update
                           DELETE /clusters/:id(.:format)                                clusters#destroy
                           GET    /services(.:format)                                    services#index
                           POST   /services(.:format)                                    services#create
                           GET    /services/new(.:format)                                services#new
                           GET    /services/:id/edit(.:format)                           services#edit
                           GET    /services/:id(.:format)                                services#show
                           PATCH  /services/:id(.:format)                                services#update
                           PUT    /services/:id(.:format)                                services#update
                           DELETE /services/:id(.:format)                                services#destroy
                           GET    /infrastructures(.:format)                             infrastructures#index
                           POST   /infrastructures(.:format)                             infrastructures#create
                           GET    /infrastructures/new(.:format)                         infrastructures#new
                           GET    /infrastructures/:id/edit(.:format)                    infrastructures#edit
                           GET    /infrastructures/:id(.:format)                         infrastructures#show
                           PATCH  /infrastructures/:id(.:format)                         infrastructures#update
                           PUT    /infrastructures/:id(.:format)                         infrastructures#update
                           DELETE /infrastructures/:id(.:format)                         infrastructures#destroy
                           GET    /organizations(.:format)                               organizations#index
                           POST   /organizations(.:format)                               organizations#create
                           GET    /organizations/new(.:format)                           organizations#new
                           GET    /organizations/:id/edit(.:format)                      organizations#edit
                           GET    /organizations/:id(.:format)                           organizations#show
                           PATCH  /organizations/:id(.:format)                           organizations#update
                           PUT    /organizations/:id(.:format)                           organizations#update
                           DELETE /organizations/:id(.:format)                           organizations#destroy
                           GET    /labels(.:format)                                      labels#index
                           POST   /labels(.:format)                                      labels#create
                           GET    /labels/new(.:format)                                  labels#new
                           GET    /labels/:id/edit(.:format)                             labels#edit
                           GET    /labels/:id(.:format)                                  labels#show
                           PATCH  /labels/:id(.:format)                                  labels#update
                           PUT    /labels/:id(.:format)                                  labels#update
                           DELETE /labels/:id(.:format)                                  labels#destroy
                           GET    /milestones(.:format)                                  milestones#index
                           POST   /milestones(.:format)                                  milestones#create
                           GET    /milestones/new(.:format)                              milestones#new
                           GET    /milestones/:id/edit(.:format)                         milestones#edit
                           GET    /milestones/:id(.:format)                              milestones#show
                           PATCH  /milestones/:id(.:format)                              milestones#update
                           PUT    /milestones/:id(.:format)                              milestones#update
                           DELETE /milestones/:id(.:format)                              milestones#destroy
                           GET    /todos(.:format)                                       todos#index
                           POST   /todos(.:format)                                       todos#create
                           GET    /todos/new(.:format)                                   todos#new
                           GET    /todos/:id/edit(.:format)                              todos#edit
                           GET    /todos/:id(.:format)                                   todos#show
                           PATCH  /todos/:id(.:format)                                   todos#update
                           PUT    /todos/:id(.:format)                                   todos#update
                           DELETE /todos/:id(.:format)                                   todos#destroy
                     tasks GET    /tasks(.:format)                                       tasks#index
                           POST   /tasks(.:format)                                       tasks#create
                  new_task GET    /tasks/new(.:format)                                   tasks#new
                 edit_task GET    /tasks/:id/edit(.:format)                              tasks#edit
                      task GET    /tasks/:id(.:format)                                   tasks#show
                           PATCH  /tasks/:id(.:format)                                   tasks#update
                           PUT    /tasks/:id(.:format)                                   tasks#update
                           DELETE /tasks/:id(.:format)                                   tasks#destroy
                           GET    /tasklists(.:format)                                   tasklists#index
                           POST   /tasklists(.:format)                                   tasklists#create
                           GET    /tasklists/new(.:format)                               tasklists#new
                           GET    /tasklists/:id/edit(.:format)                          tasklists#edit
                           GET    /tasklists/:id(.:format)                               tasklists#show
                           PATCH  /tasklists/:id(.:format)                               tasklists#update
                           PUT    /tasklists/:id(.:format)                               tasklists#update
                           DELETE /tasklists/:id(.:format)                               tasklists#destroy
                    issues GET    /issues(.:format)                                      issues#index
                           POST   /issues(.:format)                                      issues#create
                 new_issue GET    /issues/new(.:format)                                  issues#new
                edit_issue GET    /issues/:id/edit(.:format)                             issues#edit
                     issue GET    /issues/:id(.:format)                                  issues#show
                           PATCH  /issues/:id(.:format)                                  issues#update
                           PUT    /issues/:id(.:format)                                  issues#update
                           DELETE /issues/:id(.:format)                                  issues#destroy
                           GET    /issuelists(.:format)                                  issuelists#index
                           POST   /issuelists(.:format)                                  issuelists#create
                           GET    /issuelists/new(.:format)                              issuelists#new
                           GET    /issuelists/:id/edit(.:format)                         issuelists#edit
                           GET    /issuelists/:id(.:format)                              issuelists#show
                           PATCH  /issuelists/:id(.:format)                              issuelists#update
                           PUT    /issuelists/:id(.:format)                              issuelists#update
                           DELETE /issuelists/:id(.:format)                              issuelists#destroy
                           GET    /projects(.:format)                                    projects#index
                           POST   /projects(.:format)                                    projects#create
                           GET    /projects/new(.:format)                                projects#new
                           GET    /projects/:id/edit(.:format)                           projects#edit
                           GET    /projects/:id(.:format)                                projects#show
                           PATCH  /projects/:id(.:format)                                projects#update
                           PUT    /projects/:id(.:format)                                projects#update
                           DELETE /projects/:id(.:format)                                projects#destroy
                           GET    /ips(.:format)                                         ips#index
                           POST   /ips(.:format)                                         ips#create
                           GET    /ips/new(.:format)                                     ips#new
                           GET    /ips/:id/edit(.:format)                                ips#edit
                           GET    /ips/:id(.:format)                                     ips#show
                           PATCH  /ips/:id(.:format)                                     ips#update
                           PUT    /ips/:id(.:format)                                     ips#update
                           DELETE /ips/:id(.:format)                                     ips#destroy
                           GET    /home/slice(.:format)                                  home#slice
                      page GET    /pages/*id                                             high_voltage/pages#show
