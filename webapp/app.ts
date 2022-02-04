import express from "express"

const port = 8005 //  process.env.PORT || 8080

const app = express()

app.get("/", (req, res) => {
    res.send("hello world")
})

app.listen(port, () => {
    console.log("listen on port %s", port)
})

