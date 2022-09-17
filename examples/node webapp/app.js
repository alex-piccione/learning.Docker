import { createServer } from "http"
import fs from "fs"
//import { connect } from "mongoose"
import mongoose from "mongoose"
const { connect } = mongoose
import CurrencyModel from "./models.js"

const version = "1.3"
const configFile = "/var/secrets/secrets.json" // ""./secrets.json"

const readConfiguration = (success, failure) => {
  try {
    const content = fs.readFileSync(configFile)
    console.log("Successfully read secrets")
    return success(JSON.parse(content))
  } catch (err) {
    console.log("Failed to read secrets")
    return failure(`${err}`)
  }

  // async
  /*fs.readFile("./secrets.json", function (err, content) {
    if (err) {
      console.log("Failed to read secrets")
      a = `error: ${err}`
    } else {
      console.log("Successfully read secrets")
      const data = JSON.parse(content)
      a = data.a
    }
  })*/
}

const config = readConfiguration(
  config => config,
  error => ({ error: error })
)

// Object.hasOwn is available from Node 16.9
if (Object.prototype.hasOwnProperty(config, "error"))
  console.log(`Failed to read configuration. ${config.error}`)

connect(config.connectionString /*"mongodb://mongo:27017/db"*/, {
  useNewUrlParser: true,
  //useFindAndModify: false,
  useUnifiedTopology: true,
}).catch(error => console.error(`Failed to connect to MongoDB: ${error}`))

createServer((req, res) => {
  //const model = new CurrencyModel({ code: "aaa", name: "aaaaa" });
  //model.save();

  res.writeHead(200, { "Content-Type": "text/plain" })

  if (req.url === "/") {
    res.end(`App is running, Version: ${version} Base URL. A=${config.a}`)
  } else res.end(`App is running, Version: ${version}`)
}).listen(3000)

console.log("Server running on port 3000")
