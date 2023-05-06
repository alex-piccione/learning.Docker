import { MongoClient, ServerApiVersion } from "mongodb"

const Repository = (connectionString) => {
  const client = new MongoClient(connectionString, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    serverApi: ServerApiVersion.v1,
  })

  // .connet is not required ???
  /*const connect = () => {
        client.connect(err => {
            if (err) {
                console.log(`MongoDB client connect fails. ${err}`)
                //throw(`Client connect fails. ${err}`)
                setTimeout(connect(), 1000)
            }
            console.log(`MongoDB client connection OK. ${err}`)
          });
    }*/

  //connect()

  return {
    getCurencies: () =>
      new Promise((resolve, reject) => {
        console.log("getCurencies")
        try {
          client
            .db("Portfolio")
            .collection("Currency")
            .find()
            .toArray((err, documents) => {
              if (err) {
                console.log(`Collection command fails. ${err}`)
                reject(`Collection command fails. ${err}`)
              }
              const currencies = parseCurrencies(documents)
              resolve(currencies)
            })
        } catch (error) {
          console.log("error getting currencies")
          reject(`${error}`)
        }
      }),
  }
}

const parseCurrencies = (documents) => documents.map((document) => ({ Code: document._id, Name: document.Name }))

export default Repository
