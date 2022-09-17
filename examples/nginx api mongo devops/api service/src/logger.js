import fs from "fs"

const Logger = (path) => {
  return {
    log: (message) => {
      console.log(message)
      fs.appendFile(`${path}/log.txt`, message + "\n")
    },
  }
}

export default Logger
