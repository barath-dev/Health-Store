import mongoose from "mongoose";
import { contactNumberSchema } from "../utils/SchemaHelper";


const {Schema, model} = mongoose;

const userSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    contactNumber: {
        type: contactNumberSchema,
        required: true
    },
    dob: {
        type: Date,
        required: true,
    },
    address: {
        type: String,
        required: true
    },
    prescriptionRecordId: {
        type: Schema.Types.ObjectId,
        ref: 'PrescriptionRecord'
    }   
});


export const User = model('User', userSchema);