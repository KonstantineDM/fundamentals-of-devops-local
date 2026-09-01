const app = require("./app");
const PORT = process.env.PORT || 3000;

const server = app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});

server.on("error", (error) => {
  console.error("Server error:", error);
});
