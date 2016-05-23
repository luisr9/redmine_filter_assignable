require_dependency 'Issues/patches/IssueController_patch'

Redmine::Plugin.register :redmine_filter_assignable do
  name 'Redmine Filter Assignable plugin'
  author 'Luis Roa'
  description 'Plugin to filter assignable users based on workflow'
  version '0.0.1'
  url 'https://github.com/luisr9/redmine_filter_assignable'
  author_url 'www.google.com/+LuisRoa'
end
