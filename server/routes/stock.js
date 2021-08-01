const express = require("express");
const auth = require("../middleware/auth");
const Stock = require("../models/stock");
const stocksRouter = express.Router();

// To get all the stocks data stored in mongodb
stocksRouter.get("/api/stock-data/all", auth,async(req, res) => {
    try {
        const allStocks = await Stock.find({});
        res.json(allStocks);
    } catch(err) {
        res.status(500).json({error: err.message});
    }
});

module.exports = stocksRouter;