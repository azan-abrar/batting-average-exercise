# Create admin for the Batting Average Exercise
User.find_or_create_by(email: 'admin@battingaverage.com') do |user|
  user.role = User.roles[:admin]
  user.password = 'Adm!n123@'
end
