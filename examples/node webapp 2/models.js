import mongoose from "mongoose";
const { Schema, model } = mongoose;

const currencySchema = new Schema({
  code: {
    type: String,
    required: true,
  },
  name: {
    type: Number,
    required: true,
  },
});

const CurrencyModel = model("Currency", currencySchema);

//module.exports = CurrencyModel

export default CurrencyModel;
