import redis from "redis"
import { promisify } from "util"

const client = redis.createClient("redis://redis:6379")

const getAsync = promisify(client.get).bind(client)
const setAsync = promisify(client.set).bind(client)
const incrAsync = promisify(client.incr).bind(client)

export { getAsync, setAsync, incrAsync }
