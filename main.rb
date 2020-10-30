require 'sqlite3'

db = SQLite3::Database.open "/home/carles/Biblioteca del calibre/metadata.db"

statement = db.prepare "SELECT timestamp from Books"
rs = statement.execute

years = {}

rs.each do |row|
  year = row[0][0..3]
  year = row[0].split('-')[0]
  if years.key?(year)
    years[year] += 1
  else
    years[year] = 1
  end
end

print years
