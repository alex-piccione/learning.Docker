//const { MongoClient, ServerApiVersion } = require('mongodb');
import {MongoClient, ServerApiVersion} from 'mongodb'


const Repository = ((username, password) => {

    const uri = `mongodb+srv://${username}:${password}@cluster0.74mtl.mongodb.net/?retryWrites=true&w=majority`
    const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });

    client.connect(err => {
        const collection = client.db("Portfolio").collection("Currency");
        // perform actions on the collection object
        client.close();
      });

    return {
        getCurencies: async () => {
            return [
                {id:"EUR", name: "Euro"},{ id:"ADA", name: "Cardano"},
            ]
        }
    }
})

export default Repository