# # frozen_string_literal: true

# Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: :all

# frozen_string_literal: true

Rails.application.config.session_store :redis_store,
                                       servers: [
                                         {
                                           url: ENV['REDIS_URL'],
                                           password: ENV['REDIS_PASSWORD'],
                                           ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE },
                                           db: 0,
                                           namespace: 'sessions'
                                         }
                                       ],
                                       expire_after: 90.minutes # Adjust expiration time as needed
