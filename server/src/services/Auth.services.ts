import admin from "firebase-admin";
import * as serviceAccount from "../config/hospital-secret.json";

// const firebaseConfig = {
//   apiKey: "AIzaSyDZ6O6wfyayw7zEQiwdR4pUUBb4y1zUvyE",
//   authDomain: "hospital-e4fc6.firebaseapp.com",
//   projectId: "hospital-e4fc6",
//   storageBucket: "hospital-e4fc6.appspot.com",
//   messagingSenderId: "211126723934",
//   appId: "1:211126723934:web:864545fc0c948913659bcf",
//   measurementId: "G-B8W2HG5G0V",
// };

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

const API_KEY = "73FunU4lfPpqyZ1MXTzsWt0KI5BbVROG";
const API_TOKEN = "pavbhklwjei1nd9zomxg5u3rs428qf76";

export class AuthService {
  static async sendOtp(contactNumber: string) {
    try {
      //create a local otp
      const otp = contactNumber.slice(-4); //last 4 digits of the phone number

      return true;
    } catch (error) {
      console.log(error.code);
      return;
    }
  }

  static async verifyOtp(contactNumber: string, otp: string) {
    try {

      if (otp === contactNumber.slice(-4)) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      console.log(error.code);
      return;
    }
  }
}
