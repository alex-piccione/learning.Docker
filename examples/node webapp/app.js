import { createServer } from "http";
//import { connect } from "mongoose"
import mongoose from "mongoose";
const { connect } = mongoose;
import CurrencyModel from "./models.js";

connect("mongodb://mongo:27017/db", {
  useNewUrlParser: true,
  //useFindAndModify: false,
  useUnifiedTopology: true,
}).catch((error) => console.error(`Failed to connect to MongoDB: ${error}`));

createServer((req, res) => {
  const model = new CurrencyModel({ code: "aaa", name: "aaaaa" });
  model.save();

  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("app");
}).listen(3000);

console.log("Server running on port 3000");
