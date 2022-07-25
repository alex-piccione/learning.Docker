import express from "express"
import config from "./config.js"

const version = "2"
const server = express()

server.listen(3000, () => {
    console.log(`Server running on port ${config.serverPort}`)   
})

server.get("/", (req, res) => {
    res.send(`Hello World ${version}`)
})

server.get("/api/info", (req, res) => {
    res.json("{time: " + new Date().getTime()
        + ", status: 'OK'"  
        + ", suggested: ['Kaz Hawkins', 'Michael Kiwanuka']" 
        + "}"
        )
})
