import "dotenv/config";
import app from "../src/config/app";
import "../src/config/routes";

app.get("/", function (req, res) {
  res.send("Hello World");
});

app.listen(process.env.SERVER_PORT, () => {
  console.info(`Server listening through port ${process.env.SERVER_PORT}.`);
});
