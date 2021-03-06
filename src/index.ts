import express from "express"
import { incrAsync } from "./redis-cli"

const app = express()

app.get("/", async (req, res) => {
  const count = await incrAsync("counter")
  res.send(`Welcome! This page has been visited ${count} times!`)
})

app.listen(8000, () => {
  console.log(`⚡️[server]: Server is running`)
})
