const express = require("express");
const auth = require("../middleware/auth");
const Stock = require("../models/stock");
const User = require("../models/user");
const stocksRouter = express.Router();

// To get all the stocks data stored in mongodb
stocksRouter.get("/api/stock-data/all", auth, async (req, res) => {
  try {
    const allStocks = await Stock.find({});
    res.json(allStocks);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

stocksRouter.post("/api/buy-stock", auth, async (req, res) => {
  try {
    let { name, noOfSharesBought } = req.body;
    noOfSharesBought = parseInt(noOfSharesBought);
    if (!name || !noOfSharesBought)
      return res.status(400).json({ msg: "Please enter all the fields!" });
    const stock = await Stock.findOne({ name });
    if (!stock)
      return res
        .status(400)
        .json({ msg: "Buying Failed! Please try again later!" });
    let user = await User.findById(req.user);
    if (user.budget < noOfSharesBought * stock.stockPrice)
      return res.status(400).json({ msg: "You don't have enough money" });
    if (noOfSharesBought > stock.sharesAvailable)
      return res.status(400).json({
        msg: "The number of shares you are trying to buy are more than number of shares left.",
      });
    stock.sharesAvailable -= noOfSharesBought;
    stock.stockPrice = (
      stock.stars / 10000 +
      (1000 - stock.sharesAvailable) * 0.05
    ).toFixed(2);

    user.stocksOwned.push({
      name,
      noOfSharesBought,
      timeBought: Date.now(),
    });
    user.budget -= noOfSharesBought * stock.stockPrice;
    await stock.save();
    await user.save();
    console.log(user);
    res.json(stock);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

stocksRouter.get("/api/get-my-stocks", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json(user.stocksOwned);
});

module.exports = stocksRouter;
