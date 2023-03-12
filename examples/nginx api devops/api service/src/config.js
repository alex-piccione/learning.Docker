import fs from "fs"

export const readConfiguration = (configurationFilePath) => {
  try {
    const configuration = fs.readFileSync(configurationFilePath, "UTF8")
    return JSON.parse(configuration)
  } catch (err) {
    throw new Error(`Failed to load configuration. File path: "${configurationFilePath}". ${err}`)
  }
}

export default {}
