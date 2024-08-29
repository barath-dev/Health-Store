import mongoose from "mongoose";
import { Doctor } from "./doctor.model";

const {Schema, model} = mongoose;

const hospitalSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    address: {
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
    doctors: {
        type: [Schema.Types.ObjectId],
        ref: 'Doctor'
    },
});

export const Hospital = model('Hospital', hospitalSchema);