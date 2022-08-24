# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
Brewery.create(name: "Crooked Stave", city:"Denver", state:"CO", ba_member: false, annual_production: 60000, founded: 2010)
Brewery.create(name: "Deschutes Brewery", city:"Bend", state:"OR", ba_member: true, annual_production: 250000, founded: 1988)
Brewery.create(name: "Stone Brewing", city:"Escondido", state:"CA", ba_member: true, annual_production: 325000, founded: 1996)
