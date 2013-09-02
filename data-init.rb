DataMapper.auto_migrate!

Person.create(:first_name=>"Albert", 
              :last_name=>"Einstein", 
              :science => "Phisics", 
              :year_of_birth => 1879)

Person.create(:first_name=>"Isaac", 
              :last_name=>"Newton", 
              :science => "Phisics", 
              :year_of_birth => 1642)

Person.create(:first_name=>"Mihajlo", 
              :last_name=>"Pupin", 
              :science => "Phisics", 
              :year_of_birth => 1858)

Person.create(:first_name=>"Ibn", 
              :last_name=>"Sina", 
              :science => "Medicine", 
              :year_of_birth => 980)

Person.create(:first_name=>"Nikola",
              :last_name=>"Tesla", 
              :science => "Electrical Engineering", 
              :year_of_birth => 1856)

Person.create(:first_name=>"Charles", 
              :last_name=>"Babbage", 
              :science => "Computer Science", 
              :year_of_birth => 1791)

Person.create(:first_name=>"Blaise", 
              :last_name=>"Pascal", 
              :science => "Mathematics", 
              :year_of_birth => 1623)

Person.create(:first_name=>"Louis", 
              :last_name=>"Pasteur", 
              :science => "Chemistry", 
              :year_of_birth => 1822)

Person.create(:first_name=>"Marie", 
              :last_name=>"Curie", 
              :science => "Phisics", 
              :year_of_birth => 1867)
