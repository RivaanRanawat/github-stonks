const mongoose = require("mongoose");

const stockSchema = mongoose.Schema({
    stockPrice: {
        type: Number,
        default: 0
    },
    name: {
        required: true,
        type: String,
        unique: true,
    },
    image: {
        required: true,
        type: String,
    },
    stars: {
        type: Number,
        default: 0
    }
});

const Stock = mongoose.model("stock", stockSchema);

module.exports = Stock;