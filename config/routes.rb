Bestofama::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  instance_eval(File.read(Rails.root.join("config/routes/public.rb")))
  instance_eval(File.read(Rails.root.join("config/routes/reroute.rb")))
end
#== Route Map
# Generated on 25 May 2013 21:24
#
#           admin_admins GET    /admin/admins(.:format)                         admin/admins#index
#                        POST   /admin/admins(.:format)                         admin/admins#create
#        new_admin_admin GET    /admin/admins/new(.:format)                     admin/admins#new
#       edit_admin_admin GET    /admin/admins/:id/edit(.:format)                admin/admins#edit
#            admin_admin GET    /admin/admins/:id(.:format)                     admin/admins#show
#                        PATCH  /admin/admins/:id(.:format)                     admin/admins#update
#                        PUT    /admin/admins/:id(.:format)                     admin/admins#update
#                        DELETE /admin/admins/:id(.:format)                     admin/admins#destroy
#     admin_ama_comments GET    /admin/amas/:ama_id/comments(.:format)          admin/comments#index
#                        POST   /admin/amas/:ama_id/comments(.:format)          admin/comments#create
#  new_admin_ama_comment GET    /admin/amas/:ama_id/comments/new(.:format)      admin/comments#new
# edit_admin_ama_comment GET    /admin/amas/:ama_id/comments/:id/edit(.:format) admin/comments#edit
#      admin_ama_comment GET    /admin/amas/:ama_id/comments/:id(.:format)      admin/comments#show
#                        PATCH  /admin/amas/:ama_id/comments/:id(.:format)      admin/comments#update
#                        PUT    /admin/amas/:ama_id/comments/:id(.:format)      admin/comments#update
#                        DELETE /admin/amas/:ama_id/comments/:id(.:format)      admin/comments#destroy
#        admin_ama_users GET    /admin/amas/:ama_id/users(.:format)             admin/amas_users#index
#                        POST   /admin/amas/:ama_id/users(.:format)             admin/amas_users#create
#     new_admin_ama_user GET    /admin/amas/:ama_id/users/new(.:format)         admin/amas_users#new
#    edit_admin_ama_user GET    /admin/amas/:ama_id/users/:id/edit(.:format)    admin/amas_users#edit
#         admin_ama_user GET    /admin/amas/:ama_id/users/:id(.:format)         admin/amas_users#show
#                        PATCH  /admin/amas/:ama_id/users/:id(.:format)         admin/amas_users#update
#                        PUT    /admin/amas/:ama_id/users/:id(.:format)         admin/amas_users#update
#                        DELETE /admin/amas/:ama_id/users/:id(.:format)         admin/amas_users#destroy
#       clean_admin_amas GET    /admin/amas/:id/clean(.:format)                 admin/amas#clean
#             admin_amas GET    /admin/amas(.:format)                           admin/amas#index
#                        POST   /admin/amas(.:format)                           admin/amas#create
#          new_admin_ama GET    /admin/amas/new(.:format)                       admin/amas#new
#         edit_admin_ama GET    /admin/amas/:id/edit(.:format)                  admin/amas#edit
#              admin_ama GET    /admin/amas/:id(.:format)                       admin/amas#show
#                        PATCH  /admin/amas/:id(.:format)                       admin/amas#update
#                        PUT    /admin/amas/:id(.:format)                       admin/amas#update
#                        DELETE /admin/amas/:id(.:format)                       admin/amas#destroy
#            admin_users GET    /admin/users(.:format)                          admin/users#index
#                        POST   /admin/users(.:format)                          admin/users#create
#         new_admin_user GET    /admin/users/new(.:format)                      admin/users#new
#        edit_admin_user GET    /admin/users/:id/edit(.:format)                 admin/users#edit
#             admin_user GET    /admin/users/:id(.:format)                      admin/users#show
#                        PATCH  /admin/users/:id(.:format)                      admin/users#update
#                        PUT    /admin/users/:id(.:format)                      admin/users#update
#                        DELETE /admin/users/:id(.:format)                      admin/users#destroy
#          admin_trashes GET    /admin/trashes(.:format)                        admin/trashes#index
#                        POST   /admin/trashes(.:format)                        admin/trashes#create
#        new_admin_trash GET    /admin/trashes/new(.:format)                    admin/trashes#new
#       edit_admin_trash GET    /admin/trashes/:id/edit(.:format)               admin/trashes#edit
#            admin_trash GET    /admin/trashes/:id(.:format)                    admin/trashes#show
#                        PATCH  /admin/trashes/:id(.:format)                    admin/trashes#update
#                        PUT    /admin/trashes/:id(.:format)                    admin/trashes#update
#                        DELETE /admin/trashes/:id(.:format)                    admin/trashes#destroy
#             admin_meta GET    /admin/meta(.:format)                           admin/meta#index
#                        POST   /admin/meta(.:format)                           admin/meta#create
#        new_admin_metum GET    /admin/meta/new(.:format)                       admin/meta#new
#       edit_admin_metum GET    /admin/meta/:id/edit(.:format)                  admin/meta#edit
#            admin_metum GET    /admin/meta/:id(.:format)                       admin/meta#show
#                        PATCH  /admin/meta/:id(.:format)                       admin/meta#update
#                        PUT    /admin/meta/:id(.:format)                       admin/meta#update
#                        DELETE /admin/meta/:id(.:format)                       admin/meta#destroy
#        admin_upcomings GET    /admin/upcomings(.:format)                      admin/upcomings#index
#                        POST   /admin/upcomings(.:format)                      admin/upcomings#create
#     new_admin_upcoming GET    /admin/upcomings/new(.:format)                  admin/upcomings#new
#    edit_admin_upcoming GET    /admin/upcomings/:id/edit(.:format)             admin/upcomings#edit
#         admin_upcoming GET    /admin/upcomings/:id(.:format)                  admin/upcomings#show
#                        PATCH  /admin/upcomings/:id(.:format)                  admin/upcomings#update
#                        PUT    /admin/upcomings/:id(.:format)                  admin/upcomings#update
#                        DELETE /admin/upcomings/:id(.:format)                  admin/upcomings#destroy
#       admin_link_icons GET    /admin/link_icons(.:format)                     admin/entities_links_icons#index
#                        POST   /admin/link_icons(.:format)                     admin/entities_links_icons#create
#    new_admin_link_icon GET    /admin/link_icons/new(.:format)                 admin/entities_links_icons#new
#   edit_admin_link_icon GET    /admin/link_icons/:id/edit(.:format)            admin/entities_links_icons#edit
#        admin_link_icon GET    /admin/link_icons/:id(.:format)                 admin/entities_links_icons#show
#                        PATCH  /admin/link_icons/:id(.:format)                 admin/entities_links_icons#update
#                        PUT    /admin/link_icons/:id(.:format)                 admin/entities_links_icons#update
#                        DELETE /admin/link_icons/:id(.:format)                 admin/entities_links_icons#destroy
#  revert_admin_versions POST   /admin/versions/:id/revert(.:format)            admin/versions#revert
#         admin_versions GET    /admin/versions(.:format)                       admin/versions#index
#                        POST   /admin/versions(.:format)                       admin/versions#create
#      new_admin_version GET    /admin/versions/new(.:format)                   admin/versions#new
#     edit_admin_version GET    /admin/versions/:id/edit(.:format)              admin/versions#edit
#          admin_version GET    /admin/versions/:id(.:format)                   admin/versions#show
#                        PATCH  /admin/versions/:id(.:format)                   admin/versions#update
#                        PUT    /admin/versions/:id(.:format)                   admin/versions#update
#                        DELETE /admin/versions/:id(.:format)                   admin/versions#destroy
#                   amas GET    /amas(.:format)                                 amas#index
#                        POST   /amas(.:format)                                 amas#create
#                new_ama GET    /amas/submit(.:format)                          amas#new
#               edit_ama GET    /amas/:id/edit(.:format)                        amas#edit
#                    ama GET    /amas/:id(.:format)                             amas#show
#                        PATCH  /amas/:id(.:format)                             amas#update
#                        PUT    /amas/:id(.:format)                             amas#update
#                        DELETE /amas/:id(.:format)                             amas#destroy
#                   tags GET    /tags(.:format)                                 tags#index
#                        POST   /tags(.:format)                                 tags#create
#                new_tag GET    /tags/new(.:format)                             tags#new
#               edit_tag GET    /tags/:id/edit(.:format)                        tags#edit
#                    tag GET    /tags/:id(.:format)                             tags#show
#                        PATCH  /tags/:id(.:format)                             tags#update
#                        PUT    /tags/:id(.:format)                             tags#update
#                        DELETE /tags/:id(.:format)                             tags#destroy
#                  users GET    /users(.:format)                                users#index
#                        POST   /users(.:format)                                users#create
#               new_user GET    /users/new(.:format)                            users#new
#              edit_user GET    /users/:id/edit(.:format)                       users#edit
#                   user GET    /users/:id(.:format)                            users#show
#                        PATCH  /users/:id(.:format)                            users#update
#                        PUT    /users/:id(.:format)                            users#update
#                        DELETE /users/:id(.:format)                            users#destroy
#                    ops GET    /ops(.:format)                                  ops#index
#                        POST   /ops(.:format)                                  ops#create
#                 new_op GET    /ops/new(.:format)                              ops#new
#                edit_op GET    /ops/:id/edit(.:format)                         ops#edit
#                     op GET    /ops/:id(.:format)                              ops#show
#                        PATCH  /ops/:id(.:format)                              ops#update
#                        PUT    /ops/:id(.:format)                              ops#update
#                        DELETE /ops/:id(.:format)                              ops#destroy
#                        GET    /r/:subreddit(.:format)                         redirect(301, http://www.reddit.com/r/%{subreddit})
#                        GET    /sitemap_index.xml.gz(.:format)                 redirect(301, http://s3.bestofama.com/sitemaps/sitemap_index.xml.gz)
#                   root GET    /                                               index#show
#                   page GET    /*id                                            high_voltage/pages#show
