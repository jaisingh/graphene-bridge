## Graphene - Sinatra - Redis

A simple api to expose storing and retrieval of time series data from redis formatted for consumption by graphene.

### Usage

first setup your redis url :
`
export REDIS_URL="redis://...."
`

**bridge.rb** : Runs the service

**loader.rb** : bulk loads junk data, you can run this while the demo page is loading.

### Starting it up:

ruby bridge.rb

It should start and be accessible at http://localhost:9292.

Sample Dashboard: http://localhost:9292/example/dash-sinatra-redis.html

### API Urls
**GET /api/1/db/:dbname**
Get the time data for this db


**POST /api/1/db/:dbname/:series/:value**
Add a new record to a db
