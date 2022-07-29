import express from "express"
import config from "./config.js"
import Repository from "./repository.js"
import fs from "fs"

const version = "2.2"
const server = express()

const readSecrets = (secretsFile) => {
    try {
        const secretsData = fs.readFileSync(secretsFile, "UTF8")
        return JSON.parse(secretsData)
    }
    catch (err) {        
        console.log(`Failed to load secrets. ${err}`)
    }
}

const secrets = readSecrets(config.secretsFile)
const repository = Repository(secrets.MongoDB.username, secrets.MongoDB.password)

server.listen(config.serverPort, () => {
    console.log(`Server running on port ${config.serverPort}`)   
})

server.get("/", (req, res) => {
    const body = `<html>
        <h1>Hello World <small>(version: ${version})</small></h1>
        <p>A: ${secrets && secrets.A}</p>
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

server.get("/api/currency", async (req, res) => {

    const currencies = await repository.getCurencies()

    return res.json(currencies)
})
