# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sortlist = SortList.create(
	[
		{number: 1, description: 'Roste (Meiser)'},
		{number: 2, description: 'Treppenbau, ger. Geländer'},
		{number: 3, description: 'Kleinteile, gebog. Geländer'},
		{number: 4, description: 'Laufstege'},
		{number: 5, description: 'Matten Meiser'},
		{number: 6, description: 'Weinbergpfähle'},
		{number: 7, description: 'Geländerstiele'},
		{number: 8, description: 'Petrofac, 85 µm'},
		{number: 9, description: 'Hilti'},
		{number: 10, description: 'Lagerroste'},
		{number: 11, description: 'Leitplanken'},
		{number: 17, description: 'Schlosserware'},
		{number: 18, description: 'Flachstahl'},
		{number: 19, description: 'Tore/Zaunfelder'},
		{number: 20, description: 'Roste (Lohnkunden)'},
		{number: 21, description: 'Baustahlmatten'},
		{number: 22, description: 'Geländer'},
		{number: 23, description: 'sperrige Geländer'},
		{number: 24, description: 'Straßengeländer'},
		{number: 25, description: 'Säulen/Stützen'},
		{number: 26, description: 'Kleinteile'},
		{number: 27, description: 'leichter Stahlbau'},
		{number: 28, description: 'PR-Rahmen'},
		{number: 29, description: 'Balkonrahmen'},
		{number: 30, description: 'Fahrzeugrahmen'},
		{number: 31, description: 'Konstruktion bis 3 m'},
		{number: 32, description: 'Konstruktion über 3 m'},
		{number: 33, description: 'Träger'},
		{number: 34, description: 'Bleche (bis 5 mm)'},
		{number: 35, description: 'Bleche (ab 6 mm)'},
		{number: 36, description: 'mittlerer Stahlbau'},
		{number: 37, description: 'schwerer Stahlbau'},
		{number: 40, description: 'Rahmen SAXON'},
		{number: 41, description: 'Bleche SAXON'},
		{number: 42, description: 'Hubschwellen'},
		{number: 43, description: 'Hartzink'},
		{number: 46, description: 'Kunstschmiedeteile'},
		{number: 53, description: 'Entzinken'}
	]
)

#NextFreeNumber.create([
#		{no: "Meiser", description: 'Kommissionsnummer Meiser', :fifo => 30000},
#		{nno: "Lohnkunden", description: 'Kommissionsnummer Lohnkunden', :fifo => 30000}
#	]
#)
