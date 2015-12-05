class WelcomeController < ApplicationController
  # GET /trainings
  # GET /trainings.json
  def index
    require "sparql/client"
    client = SPARQL::Client.new("http://ja.dbpedia.org/sparql")
    results = client.query("
      SELECT DISTINCT ?label ?comment 
      WHERE {
      ?s dcterms:subject  <http://ja.dbpedia.org/resource/Category:トレーニング法>; 
      rdfs:label ?label .
      ?s rdfs:comment ?comment .
             }
       ")
    @item = results 
  end

end
