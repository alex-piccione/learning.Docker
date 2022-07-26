import express from "express"
import config from "../config.js"
import fs from "fs"

const version = "2.1"
const server = express()

const readSecrets = () => {
    try {
        const secretsData = fs.readFileSync("secrets.json", "UTF8")
        return JSON.parse(secretsData)
    }
    catch (err) {        
        console.log(`Failed to load secrets. ${err}`)
    }
}

const secrets = readSecrets()

server.listen(3000, () => {
    console.log(`Server running on port ${config.serverPort}`)   
})

server.get("/", (req, res) => {
    const body = `<html>
        <h1>Hello World <small>(version: ${version})</small></h1>
        <p>A: ${secrets.A}</p>
    </html>`;
    //res.send(body, { "Content-Type": "text/plain" }, 200)
    res.send(body)
})

server.get("/api/info", (req, res) => {
    res.json("{time: " + new Date().getTime()
        + ", status: 'OK'"  
        + ", suggested: ['Kaz Hawkins', 'Michael Kiwanuka']" 
        + "}"
        )
})
