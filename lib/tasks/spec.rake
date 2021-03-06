desc "Runs all specs"
task :spec do
  sh spec_command
end

task :spec_mysql do
  sh "DB=mysql DB_CONNECTION=mysql2://root:password@localhost:3306 #{spec_command}"
end

task :spec_postgresql do
  sh "DB=postgres DB_CONNECTION=postgres://postgres@localhost:5432 #{spec_command}"
end

def spec_command
  transactional_spec_command + "&&" + non_transactional_spec_command
end

def transactional_spec_command
  "bundle exec rspec --tag ~non_transactional --require rspec/instafail --format RSpec::Instafail"
end

def non_transactional_spec_command
  "bundle exec rspec --tag non_transactional --require rspec/instafail --format RSpec::Instafail"
end
