require_dependency 'issues/patches/issue_controller_patch'

Redmine::Plugin.register :redmine_filter_assignable do
  name 'Redmine Filter Assignable plugin'
  author 'Luis Roa'
  description 'Plugin to filter assignable users based on workflow'
  version '0.0.1'
  url 'https://github.com/luisr9/redmine_filter_assignable'
  author_url 'www.google.com/+LuisRoa'

  settings partial: 'settings/redmine_filter_assignable_settings',
           default: {
             'filtera_users' => 'true',
             'filtera_autor' => 'true',
             'filtera_groups' => 'true'
           }
end
