require 'sqlite3'

db = SQLite3::Database.open "/home/carles/Biblioteca del calibre/metadata.db"

statement = db.prepare "SELECT distinct books.timestamp, books.title
	FROM Books
	LEFT OUTER JOIN books_tags_link ON books.id=books_tags_link.book
	LEFT OUTER JOIN tags ON books_tags_link.tag=tags.id
	WHERE tags.name NOT in ('jen') OR tags.name is NULL"
rs = statement.execute

years_to_titles = {}

rs.each do |row|
  year = row[0].split('-')[0]
  book = row[1]

  if years_to_titles.key?(year)
    years_to_titles[year].append(book)
  else
    years_to_titles[year] = [book]
  end
end

years_to_titles.each do |year, titles|
  puts "Year: #{year} Count: #{titles.count}"
  titles.sort.each do |title|
    puts "  #{title}"
  end
end
