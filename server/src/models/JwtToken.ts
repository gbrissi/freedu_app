import type { User } from "@prisma/client";
import jwt from "jsonwebtoken";

export interface JwtToken {
  accessToken: string;
  refreshToken: string;
}

interface JwtReduced {
  id: number;
  username: string;
}

function _reduceUser(user: User): JwtReduced {
  return <JwtReduced>{
    id: user.id,
    username: user.username,
  };
}

function _signJwt(unassignedData: JwtReduced, expiresIn: string): string {
  console.log("expiresIn: ", expiresIn);
  return jwt.sign(unassignedData, process.env.JWT_SECRET_KEY!, {
    expiresIn: expiresIn,
  });
}

export function createJwtToken(user: User): JwtToken {
  const unassignedData = _reduceUser(user);
  const accessToken: string = _signJwt(unassignedData, "15m");
  const refreshToken: string = _signJwt(unassignedData, "30d");

  console.log("Token que estou dando issue: ", accessToken);
  return <JwtToken>{
    accessToken,
    refreshToken,
  };
}
