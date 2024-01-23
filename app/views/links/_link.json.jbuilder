json.extract! link, :id, :user_id, :url, :title, :favicon, :short_code, :expiry_date, :clicks, :validated, :deleted, :created_at, :updated_at
json.url link_url(link, format: :json)
