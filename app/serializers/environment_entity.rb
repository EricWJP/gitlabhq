class EnvironmentEntity < Grape::Entity
  include RequestAwareEntity

  expose :id
  expose :name
  expose :state
  expose :external_url
  expose :environment_type
  expose :last_deployment, using: DeploymentEntity
  expose :stop_action?

  expose :metrics_path, if: -> (environment, _) { environment.has_metrics? } do |environment|
    metrics_project_environment_path(environment.project, environment)
  end

  expose :environment_path do |environment|
    project_environment_path(environment.project, environment)
  end

  expose :stop_path do |environment|
    stop_project_environment_path(environment.project, environment)
  end

  expose :terminal_path, if: ->(environment, _) { environment.deployment_service_ready? } do |environment|
    can?(request.current_user, :admin_environment, environment.project) &&
      terminal_project_environment_path(environment.project, environment)
<<<<<<< HEAD
  end

  expose :rollout_status_path, if: ->(environment, _) { environment.deployment_service_ready? } do |environment|
    can?(request.current_user, :read_deploy_board, environment.project) &&
      status_project_environment_path(environment.project, environment, format: :json)
=======
>>>>>>> ce/master
  end

  expose :created_at, :updated_at
end
