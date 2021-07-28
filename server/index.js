const express = require("express");
const mongoose = require("mongoose");


const app = express();

const PORT = process.env.PORT||3001;
app.listen(PORT, () => {
  console.log(`connected at ${PORT}`);
})