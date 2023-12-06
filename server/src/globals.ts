import { JwtReduced } from "./models/JwtToken";

export {};

declare global {
  namespace Express {
    interface User extends JwtReduced {}
  }
}
