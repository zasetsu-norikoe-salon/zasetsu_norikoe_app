# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :request_path
  before_action :basic_auth_only_production

  # 参考:https://qiita.com/toduq/items/a9fa48926b060b2d8a5b
  # @path.is('users#index')のように書けばコントローラー#アクションで条件分岐可能
  def request_path
    @path = +"#{controller_path}##{action_name}"

    # rubocop:disable Lint/NestedMethodDefinition
    def @path.is(*str)
      str.map { |s| include?(s) }.include?(true)
    end
    # rubocop:enable Lint/NestedMethodDefinition
  end

  private

  def basic_auth_only_production
    return unless Rails.env.production?

    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
