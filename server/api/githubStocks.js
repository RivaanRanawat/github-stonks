const express = require("express");
const githubStocksRouter = express.Router();
const auth = require("../middleware/auth");
const cheerio = require("cheerio");
const axios = require("axios");
const Stock = require("../models/stock");

const url = "https://gitstar-ranking.com/repositories";

// Crawling the website and storing the stocks data to mongodb.
// Didnt add auth middleware so that accessible to everyone in need
githubStocksRouter.get("/api/github-repos", async (req, res) => {
  try {
    let response = await fetchData(url);
    const html = response.data;
    const $ = cheerio.load(html);
    const titleTable = $(".list-group > a");

    titleTable.each(async function () {
      let title = $(this).find("span").find(".hidden-xs").text().split("\n")[1];
      let stars = $(this).find(".stargazers_count").text().split("\n")[2];
      let image = $(this).find("img").attr("src");
      console.log(title);
      console.log(image);
      console.log(stars);
      let stock = new Stock({
        name: title,
        image,
        stars,
      });
      await stock.save();
    });
    res.json({});
  } catch (err) {
    res.status(500).json(err);
  }
});

async function fetchData(url) {
  console.log("Crawling data...");
  // making http call to url
  let response = await axios(url).catch((err) => console.log(err));

  if (response.status !== 200) {
    console.log("Error occurred while fetching data");
    return;
  }
  return response;
}

module.exports = githubStocksRouter;
