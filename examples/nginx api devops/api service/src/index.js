import express from "express"
import { readConfiguration } from "./config.js"
import Logger from "./logger.js"
import Repository from "./repository.js"

// read settings from Environment
const configurationFile = process.env.config_file_path
const serverPort = process.env.server_port

console.log("** configurationFile:", configurationFile)
console.log("** serverPort:", serverPort)

const configuration = readConfiguration(configurationFile)

const server = express()

const logger = Logger(configuration.logFile)
const repository = Repository(configuration.MongoDB.connectionString)

server.listen(serverPort, () => {
  console.info(`Server version "${configuration.version}" running on port ${serverPort}. http://localhost:${serverPort}`)
  logger.info(`Server start. Version: ${configuration.version}. Port: ${serverPort}.`)
})

server.get("/", (req, res) => {
  const body = `<html>
        <h1>Hello World <small>(version: ${configuration.version})</small></h1>

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

  const data =       {
    time: new Date().getTime(),
    version: configuration.version,
    status: "OK"
  }

  // suggested: ['Kaz Hawkins', 'Michael Kiwanuka']" + "}"

  if (req.accepts("text/json"))
    res.json(data)    
  else
    res._write(JSON.stringify(data))
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
