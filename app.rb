require 'neo4j-ruby-driver'

class DB
  def initialize()
    @driver = Neo4j::Driver::GraphDatabase.driver(ENV['uri'], Neo4j::Driver::AuthTokens.basic(ENV['user'], ENV['password']))
  end
end

def handle_input(input)
  case input
  in ['director', director]
    "Here will be films of director #{director}"
  in ['collegues', person]
    "Here will be all people who worked with #{person}"
  in ['actors_count', film]
    "Here will be count of actors who took part in #{film}"
  in ['help']
    """
    Flags for app.rb:
    director <director> -- finds all films of director
    collegues <person> -- finds all people who worked with person
    actors_count -- how many actors took part in film
    help -- puts help
    """
  else
    'Wrong command. Print "ruby app.rb help" for help.'
  end
end

puts handle_input(ARGV)

