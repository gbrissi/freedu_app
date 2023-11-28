import userRoutes from "../routes/userRoutes";
import authRoutes from "../routes/authRoutes";
import postRoutes from "../routes/postRoutes";
import tagRoutes from "../routes/tagRoutes";
import app from "../config/app";

app.use("/tags", tagRoutes);
app.use("/users", userRoutes);
app.use("/auth", authRoutes);
app.use("/posts", postRoutes);
