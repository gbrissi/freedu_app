import { GetSignedUrlConfig } from "@google-cloud/storage";
import bucket from "../config/bucket";
import { ExternalPicture } from "../interfaces/ExternalPicture";
import { StoredPicture } from "../interfaces/StoredPicture";

export default class CloudStorageManager {
  private static _getUniqueFilename(filename: string): string {
    return `${filename}_${Date.now()}`;
  }

  private static _getFileUrl(filename: string): Promise<string> {
    const fileRef = bucket.file(filename);

    const config: GetSignedUrlConfig = <GetSignedUrlConfig>{
      action: "read",
      expires: "2100-01-01",
    };

    return new Promise((resolve, reject) => {
      fileRef.getSignedUrl(config, function (_err, url) {
        if (_err) return reject(_err);
        else if (!url) return reject("Url not found");
        else resolve(url);
      });
    });
  }

  private static _saveInBucket({
    filename,
    binaries,
  }: {
    filename: string;
    binaries: Buffer;
  }): Promise<string> {
    return new Promise((resolve, reject) => {
      bucket
        .file(filename)
        .save(Buffer.from(binaries))
        .then(() => this._getFileUrl(filename))
        .then((url: string) => resolve(url))
        .catch((_err) => reject(_err));
    });
  }

  static async createPic(picture: ExternalPicture): Promise<StoredPicture> {
    const uniqueFilename: string = this._getUniqueFilename(picture.name);

    const pictureUrl: string = await this._saveInBucket({
      filename: uniqueFilename,
      binaries: picture.bytes,
    });

    return <StoredPicture>{
      name: uniqueFilename,
      fileType: picture.fileType,
      url: pictureUrl,
    };
  }
}
