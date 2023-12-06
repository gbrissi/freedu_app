export interface PictureModel {
  id: number;
  name: string;
  fileType: string;
  small?: string;
  thumbnail?: string;
  original?: string;
  createdAt: Date;
  updatedAt: Date;
}

export const pictureModelQuery = {
  id: true,
  name: true,
  filetype: true,
  small: true,
  thumbnail: true,
  original: true,
  createdAt: true,
  updatedAt: true,
};
