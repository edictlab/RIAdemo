require 'dm-migrations'
require 'dm-validations'

class Person 
  include DataMapper::Resource
  property :id,             Serial
  property :first_name,     String
  property :last_name,      String
  property :science,        String
  property :year_of_birth,  Integer
end



DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default,"sqlite:./test.db") 
DataMapper.finalize

