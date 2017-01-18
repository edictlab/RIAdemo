require 'dm-migrations'
require 'dm-validations'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default,"sqlite://#{Dir.pwd}/scientists.db") 

class Person 
  include DataMapper::Resource
  property :id,             Serial
  property :first_name,     String
  property :last_name,      String
  property :science,        String
  property :year_of_birth,  Integer
end

DataMapper.finalize

