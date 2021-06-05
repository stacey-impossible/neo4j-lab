require 'neo4j/driver'

class DB
  def initialize()
    @driver = Neo4j::Driver::GraphDatabase.driver(ENV['NEO4J_URI'], Neo4j::Driver::AuthTokens.basic(ENV['NEO4J_USER'], ENV['NEO4J_PASSWORD']))
  end

  def movies_of_director(director)
    @driver.session { |session| session.run('MATCH (movie:MOVIE)=[:DIRECTED]-(:Person {name: $name}) RETURN movie.title', director: director) }
  end

  def colleagues_of_person(person_name)
    @driver.session { |session| session.run('(person:Person {name: $person_name})-[relatedTo]->(m)<-[relatedTo]-(colleague) RETURN colleague.name', person_name: person_name) }
  end
end

def handle_input(input)
  db = DB.new()
  case input
  in ['director', director]
    db.movies_of_director(director)
  in ['colleagues', person_name]
    db.colleagues_of_person(person_name)
  in ['actors_count', movie]
    "Here will be count of actors who took part in #{movie}"
  in ['help']
    """
    Flags for app.rb:
    director <director> -- finds all movies of director
    colleagues <person_name> -- finds all people who worked with person
    actors_count <movie> -- how many actors took part in movie
    help -- puts help
    """
  else
    'Wrong command. Print "ruby app.rb help" for help.'
  end
end

puts handle_input(ARGV)

