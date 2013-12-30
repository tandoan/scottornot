# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..34
	Picture.create ({url: "/#{i}.jpg"})
end


Vote.create({scott: true, picture_id: 34})
Vote.create({scott: true, picture_id: 34})
Vote.create({scott: true, picture_id: 34})
Vote.create({scott: false, picture_id: 34})