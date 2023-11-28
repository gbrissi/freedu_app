import "./passport";
import express from "express";
import passport from "passport";
import path from "path";

const app = express();

// General config
app.use(express.json());

// Passport config
app.use(express.static(path.join(__dirname, "public")));
app.use(passport.initialize())

export default app;
