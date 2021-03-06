namespace :db do
  desc 'Drop, create, load then seed the development database'
  task reseed: [ 'db:drop:_unsafe', 'db:create', 'db:schema:load', 'db:seed' ] do
    puts 'Reseeding completed.'
  end
end
