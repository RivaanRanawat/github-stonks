const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const userRouter = express.Router();

// Sign up Route

userRouter.post("/api/signup", async (req, res) => {
  try {
    const { email, password, fullName, confirmPassword } = req.body;
    if (!email || !password || !fullName || !confirmPassword) {
      return res.status(400).json({ msg: "Please enter all the fields" });
    }
    if (password.length < 6) {
      return res
        .status(400)
        .json({ msg: "Password should be atleast 6 characters" });
    }
    if (confirmPassword !== password) {
      return res.status(400).json({ msg: "Both the passwords dont match" });
    }
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with the same email already exists" });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    const newUser = new User({
      email,
      password: hashedPassword,
      fullName
    });

    const savedUser = await newUser.save();
    res.json(savedUser);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = userRouter;
