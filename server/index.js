const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const app = express();
const userRouter = require("./routes/user"); // router to perform user login/signup operations
const githubStocksRouter = require("./api/githubStocks"); // router to crawl web and get data
const stocksRouter = require("./routes/stock"); // router to perform stock operations

const PORT = process.env.PORT || 3001;

app.use(express.json());
app.use(cors());
app.use(userRouter);
app.use(githubStocksRouter);
app.use(stocksRouter);


app.listen(PORT, () => {
  console.log(`connected at ${PORT}`);
});

mongoose.connect(
  "mongodb+srv://rivaan:rivaan123@cluster0.k1pdp.mongodb.net/myFirstDatabase?retryWrites=true&w=majority",
  { useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true },
  () => {
    console.log("mongoose connected");
  }
);
