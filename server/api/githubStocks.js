const express = require("express");
const stocksRouter = express.Router();
const auth = require("../middleware/auth");
const cheerio = require("cheerio");
const axios = require("axios");

const url = "https://gitstar-ranking.com/repositories";

stocksRouter.get("/api/github-repos", async (req, res) => {
  var objectArray = [];
  let response = await fetchData(url);
  const html = response.data;
  const $ = cheerio.load(html);
  const titleTable = $(".list-group > a");

  titleTable.each(function () {
    let title = $(this).find("span").find(".hidden-xs").text().split("\n")[1];
    let stars = $(this).find(".stargazers_count").text().split("\n")[2];
    let image = $(this).find("img").attr("src");
    console.log(title);
    console.log(image);
    console.log(stars);
    let map = {
      title,
      image,
      stars
    };
    objectArray.push(map);
  });
  res.json(objectArray);
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

module.exports = stocksRouter;
