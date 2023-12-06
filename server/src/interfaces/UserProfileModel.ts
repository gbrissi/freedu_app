import { PictureModel, pictureModelQuery } from "./PictureModel";

export interface UserProfileModel {
  id: number;
  picture?: PictureModel;
  name: string;
  email?: string;
  description?: string;
  createdAt: Date;
  updatedAt: Date;
}

export const userProfileModelQuery = {
  id: true,
  name: true,
  email: true,
  description: true,
  createdAt: true,
  updatedAt: true,
  picture: {
    select: pictureModelQuery,
  },
};

export function convertQueryToUserProfileModel(query: any): UserProfileModel {
  return <UserProfileModel>{
    id: query.id,
    picture: query.picture,
    name: query.name,
    email: query.email,
    description: query.description,
    createdAt: query.createdAt,
    updatedAt: query.updatedAt,
  };
}
