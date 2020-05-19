class Space

  attr_reader :name, :description

  @@spaces = []

  def initialize(name, description)
    @name = name
    @description = description
  end

  def self.all
    @@spaces
  end

end