const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    email: {
        required: true,
        type: String,
        unique: true,
        trim: true
    },
    fullName: {
        required: true,
        type: String,
        trim: true
    },
    password: {
        required: true,
        type: String,
        minLength: 6,
    },
    budget: {
        type: Number,
        default: 5000
    }
});

const User = mongoose.model("user", userSchema);

module.exports = User;