import fs from "fs"
import path from "path"

const Logger = (logFile) => {

  // If file does not exists,  create it and change permission, otherwise it results read-only.
  if(!fs.existsSync(logFile))
    fs.mkdirSync(path.dirname(logFile), {recursive: true})

  fs.appendFile(logFile, "", {recursive: true}, (err) => {
    if (err)
      throw new Error(`Failed to create file "${logFile}". ${err}.`)
    console.log("Log file created.")
  });

  // ... and set read, write permission to all users
  fs.chmod(logFile, 0o666, (err) => {
    if (err) throw err;
  });

  const writeLog = (message, level) => {

    //if (!fs.accessSync(logFile, fs.constants.W_OK))
    //  console.log("cannot write the log file")  // false result

    // https://nodejs.org/api/fs.html#fs_file_system_flags
    fs.appendFile(logFile, `${new Date().toISOString()} ${level} ${message}\n`, {mode: fs.constants.O_APPEND}, (err) => {
      if(err)
        console.error(`Failed to write log to "${logFile}". ${err}.`)  
      return;      
    })
  }

  return {    
    log: (message) => writeLog(message, "INFO"),
    info: (message) => writeLog(message, "INFO"),
    warn: (message) => writeLog(message, "WARNING"),
    error: (message) => writeLog(message, "ERROR")
  }
}

export default Logger
