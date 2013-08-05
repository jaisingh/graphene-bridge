(function() {
  var description;
  description = {
    "Foo Work": {
      source: "http://localhost:9292/api/1/db/jai?",
      TimeSeries: {
        parent: '#g2-3'
      }
    }
  };


  var g = new Graphene;
  // g.demo();
  g.build(description);


}).call(this);
