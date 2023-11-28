import passport from "passport";

const isLoggedIn = passport.authenticate("jwt", { session: false });
export default isLoggedIn;
