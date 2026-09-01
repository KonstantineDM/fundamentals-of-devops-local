const express = require("express");

const app = express();

app.get("/", (req, res) => {
  // res.json({ text: 'backend microservice' })
  throw new Error("Error from backend microservice", { cause: "Something went wrong" });
});

module.exports = app;
