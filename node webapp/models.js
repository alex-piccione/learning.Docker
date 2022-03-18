const mongoose = require("mongoose")

const currencySchema = new mongoose.Schema({
    code: {
        type: String, 
        required: true
    },
    name: {
        type: Number,
        required: true
    }
})

const CurrencyModel = mongoose.model("Currency", currencySchema)

module.exports = CurrencyModel