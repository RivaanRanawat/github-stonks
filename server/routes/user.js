const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken");

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
      fullName,
    });

    const savedUser = await newUser.save();
    res.json(savedUser);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Login Route

userRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ msg: "Please enter all the fields" });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .send({ msg: "User with this email does not exist" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).send({ msg: "Incorrect password." });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = userRouter;
