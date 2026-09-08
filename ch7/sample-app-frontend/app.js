const express = require("express");

const backendHost = process.env.BACKEND_HOST || "http://sample-app-backend-service";
const app = express();
app.set("view engine", "ejs");

app.get("/", async (req, res) => {
  try {
    const response = await fetch(backendHost);
    const responseBody = await response.json();
    res.render("hello", { name: responseBody.text });
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

module.exports = app;
