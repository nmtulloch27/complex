const keys = require('./keys')
const redis = require('redis')

const redisClient = redis.createClient({
    host:keys.redisHost,
    port:keys.redisPort,
    retry_strategy: ()=> 1000
});

const sub = redisClient.duplicate();

function fib (index){
    if (index <2) return 1;
    return fib (index - 1) + fib(index - 2)
}
//subscribe and watch when a new value entered. this is a call back function
sub.on('message',(channel,message)=>{
    //after calculating the value store it in a hash of values
    //message is the index value
    redisClient.hset('values',message,fib(parseInt(message)))
});
sub.subscribe('insert');