import { User } from "../models/user.model";
import { AuthService } from "../services/Auth.services";
import ApiError from "../utils/ApiError";
import catchAsync from "../utils/catchAsync";

const jwt = require("jsonwebtoken");

export const registerUser = catchAsync(async (req, res) => {
  console.log("Registering user");

  try {
    const { countryCode, number } = req.body.contactNumber;

    if (!countryCode || !number) {
      ApiError.badRequest("Fill complete details!!");
    }

    const phoneNumWithCountryCode = `${countryCode}${number}`;

    const otpSent = await AuthService.sendOtp(phoneNumWithCountryCode);

    if (otpSent) {
      res.send("OTP sent successfully").status(200);
    } else {
      res.send("Failed to send OTP").status(500);
    }
  } catch (error) {
    console.log(error);
    res.status(500).send("Internal server error");
  }
});

export const verifyOtp = catchAsync(async (req, res) => {
  console.log("Verifying OTP");

  try {
    const { countryCode, number } = req.body.contactNumber;
    const otp = req.body.otp;

    if (!countryCode || !number || !otp) {
      ApiError.badRequest("Fill complete details!!");
    }

    const phoneNumWithCountryCode = `${countryCode}${number}`;

    const otpVerified = await AuthService.verifyOtp(
      phoneNumWithCountryCode,
      otp
    );

    if (otpVerified) {

      const user = await User.create({
        name: req.body.name,
        contactNumber: {
          countryCode,
          number,
        },
        dob: req.body.dob,
        address: req.body.address,
      });

      const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN,
      });

      res.send({ token }).status(200);
    } else {
      res.status(401).send("OTP verification failed");
    }
  } catch (error) {
    console.log(error);
    res.status(500).send("Internal server error");
  }
});
