class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    sql = <<-SQL
    SELECT restaurants.* FROM restaurants
    -- JOIN restaurants ON restaurants.owner_id = owners.id
    WHERE restaurants.owner_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end

end
