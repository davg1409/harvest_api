json.extract! user, :id, :first_name, :last_name, :email, :nickname
json.tags user.tags, partial: 'api/v1/tags/detail', as: :tag if user.tags.present?
json.chart_accounts current_api_v1_user.chart_accounts, partial: '/api/v1/chart_accounts/detail', as: :chart_account if user.chart_accounts.present?