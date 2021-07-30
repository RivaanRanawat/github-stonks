const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const userRouter = require("./routes/user");
const app = express();

const PORT = process.env.PORT || 3001;

app.use(express.json());
app.use(cors());
app.use(userRouter);


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
