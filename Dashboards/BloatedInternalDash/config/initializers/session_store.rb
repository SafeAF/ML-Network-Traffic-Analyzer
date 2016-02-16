# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_webui_session'

Rails.application.config.session_store :redis_store, key: '_internaldash_session'