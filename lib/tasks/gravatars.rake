desc "Import avatars from a user's gravatar url"
task :import_avatars => :environment do
	puts "importing avatars from gravatars"
	User.get_gravatars
	puts "Avatar updated"
end