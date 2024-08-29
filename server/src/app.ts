import express from "express";
import http from "http";
import dotenv from "dotenv";

import cors from "cors";
import cookieParser from "cookie-parser";
import ApiError from "./utils/ApiError";

import AuthRoutes from "./routes/auth.routes";

const db = require("./config/db");
const app = express();
const bodyParser = require("body-parser");
const session = require("express-session");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.json({ limit: "16kb" }));
app.use(express.urlencoded({ extended: true, limit: "16kb" }));
app.use(express.static("public"));
app.use(cookieParser(process.env.SESSION_SECRET));

dotenv.config();

app.use("/auth", AuthRoutes);

// app.use(
//   session({
//     secret: process.env.SESSION_SECRET,
//     resave: false,
//     saveUninitialized: false,
//     cookie: { secure: false, maxAge: 30 * 60 * 1000 },
//   })
// );

app.get("/test", async (req, res) => {
  res.send("Hello World");
});

app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT"],
  })
);

app.all("*", (req, res, next) => {
    //log the route and the method
    console.log(req.method, req.url);
  next(ApiError.notFound("Route not found"));
});

http.createServer(app).listen(process.env.HTTP_PORT || 80, () => {
  console.log(`Server is running on port ${process.env.HTTP_PORT || 80}`);
});

