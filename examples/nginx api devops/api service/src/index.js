import express from "express"
import { readConfiguration } from "./config.js"
import Logger from "./logger.js"
import Repository from "./repository.js"

// read settings from Environment
// set it using `export learning_docker_api_service_config_file_path=/c/secrets/learning_docker_api_service_config.json`
// export learning_docker_api_service_server_port=8005
const configurationFile = process.env.config_file_path
const serverPort = process.env.server_port

console.log("** configurationFile:", configurationFile)
console.log("** serverPort:", serverPort)

const configuration = readConfiguration(configurationFile)

const logger = Logger(configuration.logFile)
const repository = Repository(configuration.MongoDB.connectionString)

const server = express()

// request logger middleware
server.use((req, res, next) => {
  logger.info(`${req.method} ${req.path} ${req.query}`) // [object object]
  next() // calling next middleware function or handler
})

// 
/*const use__ = async (req, res) =>
  await Promise.resolve().catch(err => {
    logger.error(`Unhandled error. ${req}. ${err}.`)
    res.status(500).send("An unhandled error occurred.")
  })*/

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



server.get("/currencies", (req, res, next) => {

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

  logger.info("error 1")

  try {

    repository
      .getCurencies()
      .then(data =>
      { 
        logger.info("ok 2")
        const page = formatData(data)
        res.send(page)
        //res.send(page, { "Content-Type": "text/html" }, 200)
        logger.info("ok 3")
      })
      .catch(error => {
        console.error("error")
        logger.error("error")
        next(error)
        /*sendErrorHtml(error), 500)*/
      })
  }
  catch(err)
  {
    logger.info("error 4")
    next(err)
  }

})

server.get("/api/currency", (req, res) => {
  repository
    .getCurencies()
    .then((data) => res.json(data))
    .catch((error) => res.json(createError(error), 500))
})

// error handler middleware, must be after the endpoints definitions
server.use((err, req, res, next) => {
  logger.info("error middleware")
  if(err) {
    logger.error(`An unhandled error occurred. ${err}.`) 
    res.status(500).send("An unhandled error occurred.")
  }
  else
    next() // calling next middleware function or handler
})


const createError = (error) => {
  return { Message: `${error}` }
}

const createErrorHtml = (error) => `<html>
    <h1>Error</h1>
        <p>${error}</p>
    </html>`

