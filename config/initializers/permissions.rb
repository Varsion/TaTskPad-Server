Rails.application.config.permission_default_actions = %w[view update create unavailable]

Rails.application.config.permission_scopes = [
  {scope: "project", actions: %w[view]},
  {scope: "issue", actions: %w[view update create]},
  {scope: "bucket", actions: %w[view]},
  {scope: "board", actions: %w[view]},
  {scope: "sprint", actions: %w[view]}
]
