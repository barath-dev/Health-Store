import mongoose from "mongoose";
import { PrescriptionsRecord } from "./prescriptions.model";

const {Schema, model} = mongoose;


const doctorSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    speciality: {
        type: String,
        required: true
    },
    hospital: {
        type: String,
        required: true
    },
    contactNumber: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    prescriptionsRecordId: {
        type: [PrescriptionsRecord],
        required: true
    }
});


export const Doctor = model('Doctor', doctorSchema);