import { Storage } from "@google-cloud/storage";
import path from "path";

const storage = new Storage({
  keyFilename: path.join(__dirname, "../../cloud_storage_credentials.json"),
  projectId: "freedu-technical-project",
});

const bucket = storage.bucket("freedu-app");

export default bucket;
