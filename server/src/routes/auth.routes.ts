import { Router } from "express";
import { registerUser, verifyOtp } from "../controllers/auth.controller";


const router = Router();


router.route("/register").post(registerUser);

router.route("/register/verify-otp").post(verifyOtp);

router.route("/register/resend-otp").post();


export default router;

