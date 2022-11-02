class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  # create a new table
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          album TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  # insert the new songs to songs table
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)

  end

  # get the song ID from the database and save it to the Ruby instance
  self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

end
