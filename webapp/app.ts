import express from "express"
import CurrencyService from "./services/currencies.service"

const port = 8005 //  process.env.PORT || 8080

const app = express()

app.get("/", (req, res) => {
    res.send("hello world")
})

app.get("/currencies", (req, res) => {
    const data = CurrencyService().list()
    res.send(data)
})

app.listen(port, () => {
    console.log("listen on port %s", port)
})

