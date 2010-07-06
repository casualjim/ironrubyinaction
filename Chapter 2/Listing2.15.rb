require 'Listing2.14' 

dir = Dir.open('.')
files = dir.reject { |entry| entry.slice(0, 1) == '.' || entry.slice(entry.length() - 4, entry.length()) != '.txt' }
lists = files.collect do |file| 
	CsvRecord.build_from(file) 
	eval(File.basename(file, '.txt').capitalize).populate
end

list = lists[0]
puts list[0].to_s
puts list[1].inspect

list.each do |person|
	result = person.name      
	if person.age < 18
		result << " is under 18"
	else
		result << " is over 18"
	end
	lbs = person.weight * 2.2  
	result << " and weighs #{lbs.floor} lbs"
	p result
end

places = lists[1]
puts places[0]

places.each do |place|
	puts "#{place.name} is #{place.description}"
end

# Generates the following output:
#
# <People: name=Smith, John age=35 weight=175 height=5'10>
# <People: name=Ford, Anne age=49 weight=142 height=5'4>
# "Smith, John is over 18 and weighs 385 lbs"
# "Ford, Anne is over 18 and weighs 312 lbs"
# "Taylor, Burt is over 18 and weighs 380 lbs"
# "Zubrin, Candace is over 18 and weighs 292 lbs"
# <Places: name=Antwerp description=home>
# Antwerp is home
# Moscow is too cold
# Milan is hosting this event
