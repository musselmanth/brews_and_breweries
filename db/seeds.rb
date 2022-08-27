# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
crooked_stave = Brewery.create(name: "Crooked Stave", city:"Denver", state:"CO", ba_member: false, annual_production: 60000, founded: 2010)
deschutes = Brewery.create(name: "Deschutes Brewery", city:"Bend", state:"OR", ba_member: true, annual_production: 250000, founded: 1988)
stone = Brewery.create(name: "Stone Brewing", city:"Escondido", state:"CA", ba_member: true, annual_production: 325000, founded: 1996)


stone.beers.create(name: "Delicious IPA", abv: 7.7, ibu: 75, style:"Session IPA", in_production: true)
bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: true)
deschutes.beers.create(name: "Obsidian Stout", abv: 6.4, ibu: 55, style:"American Stout", in_production: false)
odell.beers.create(name: "Drumroll", abv: 5.3, ibu: 42, style:"Pale Ale", in_production: true)
crooked_stave.beers.create(name: "Sour Rosé", abv: 4.5, ibu: 0, style:"Wild Ale", in_production: true)
bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", in_production: true)
crooked_stave.beers.create(name: "Colorado Wild Sage", abv: 7.2, ibu: 0, style:"Farmhouse Ale", in_production: true)
bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: false)
deschutes.beers.create(name: "Fresh Squeezed", abv: 6.4, ibu: 60, style:"IPA", in_production: true)
odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", in_production: true)
stone.beers.create(name: "Buenaveza Sale & Lime Lager", abv: 4.7, ibu: 13, style:"Mexican Lager", in_production: true)
