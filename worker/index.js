const keys = require("./keys")
const redis = require("redis")

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    // If it looses connection to redis server, it should try to make connection
    // every 1 sec
    retry_strategy: () => 1000
})

const sub = redisClient.duplicate()

fib = (index) => {
    if (index < 2)
        return 1;
    return fib(index - 1) + fib(index - 2);
}

sub.on("message", (channel, message) => {
    // values is the name of the hashmap
    redisClient.hset("values", message, fib(parseInt(message)))
})

// To look for insertion of new value
sub.subscribe("insert")