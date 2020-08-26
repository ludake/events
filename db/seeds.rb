# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

t=Time.now
Category.create({ :name => "Conferences", :updated_at => t, :created_at=>t})
Category.create({ :name => "Parties", :updated_at => t, :created_at=>t})
Category.create({ :name => "Concerts", :updated_at=>t, :created_at=>t})
Category.create({ :name => "Readings", :updated_at=>t, :created_at=>t})
Category.create({ :name => "Movies", :updated_at=>t, :created_at=>t})

