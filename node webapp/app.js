const http = require("http")
const mongoose = require("mongoose")
const currencyModel = require("./models")

mongoose.connect("mongodb://mongo:27017/db", 
{
    useNewUrlParser: true,
    //useFindAndModify: false, 
    useUnifiedTopology: true
}).catch(error => console.error(`Failed to conenct to MongoDB: ${error}`))

http.createServer((req, res) => {

    const currencyModel = new currencyModel({"code": "aaa", "name": "aaaaa"})
    currencyModel.save()

    res.writeHead(200, {"Content-Type": "text/plain"})   
    res.end("app")
}).listen(3000)

console.log("Server running on port 3000")