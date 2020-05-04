# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( firebase.js )
Rails.application.config.assets.precompile += %w( realTimesChat.js )
Rails.application.config.assets.precompile += %w( notification.js )
Rails.application.config.assets.precompile += %w( requestFriendBtn.js )
Rails.application.config.assets.precompile += %w( requestGroupBtn.js )
Rails.application.config.assets.precompile += %w( good.js )
Rails.application.config.assets.precompile += %w( browserBack.js )
Rails.application.config.assets.precompile += %w( imageUpload.js )
Rails.application.config.assets.precompile += %w( printImage.js )
Rails.application.config.assets.precompile += %w( nav.js )


