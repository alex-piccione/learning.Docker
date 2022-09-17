import express from "express"
import config from "./config.js"
import Logger from "./logger.js"
import Repository from "./repository.js"
import fs from "fs"

const version = "2.2"
const server = express()

const readSecrets = (secretsFile) => {
  try {
    const secretsData = fs.readFileSync(secretsFile, "UTF8")
    return JSON.parse(secretsData)
  } catch (err) {
    console.log(`Failed to load secrets. ${err}`)
    logger.log(`Failed to load secrets. ${err}`)
    throw new Error(`Failed to load secrets. ${err}`)
  }
}

const logger = Logger(config.logFile)
const secrets = readSecrets(config.secretsFile)
const repository = Repository(secrets.MongoDB.connectionString)

server.listen(config.serverPort, () => {
  console.log(`Server running on port ${config.serverPort}`)
})

server.get("/", (req, res) => {
  const body = `<html>
        <h1>Hello World <small>(version: ${version})</small></h1>
        <p>A: ${secrets && secrets.Test}</p>

        <h3>Pages</h3>
        <menu>            
            <ul>
                <li><a href="/currencies">Currencies</a></li>
            </ul>
        </menu>

        <h3>API</h3>
        <menu>
            <ul>
                <li>GET /api/currency : List of all currencies</li>
            </ul>
        </menu>
    </html>`

  res.send(body)
})

server.get("/api/info", (req, res) => {
  res.json(
    "{time: " + new Date().getTime() + ", status: 'OK'" + ", suggested: ['Kaz Hawkins', 'Michael Kiwanuka']" + "}"
  )
})

server.get("/currencies", (req, res) => {
  const formatData = (currencies) => `<html>    
        <h1>Currencies</h1>
        <div><a href="/">Home</a></div>
        <hr>
        <table>                     
            <tr>            
                <th>Code</th>
                <th>Name</th>
            </tr>
            ${currencies
              .map(
                (currency) => `<tr>
                <td>${currency.Code}</td>
                <td>${currency.Name}</td>
            </tr>`
              )
              .join("")}   
        </table>
    </html>`

  repository
    .getCurencies()
    .then((data) => res.send(formatData(data), { "Content-Type": "text/html" }, 200))
    .catch((error) => createErrorHtml(error), 500)
})

server.get("/api/currency", (req, res) => {
  repository
    .getCurencies()
    .then((data) => res.json(data))
    .catch((error) => res.json(createError(error), 500))
})

const createError = (error) => {
  return { Message: `${error}` }
}

const createErrorHtml = (error) => `<html>
    <h1>Error</h1>
        <p>${error}</p>
    </html>`
