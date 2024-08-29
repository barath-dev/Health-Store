import mongoose from "mongoose";

const {Schema, model} = mongoose;

export const medicationsSchema = new Schema({
    medicineName: {
        type: String,
        required: true
    },
    dosage: {
        type: String,
        required: true
    },
    remarks: {
        type: String,
        required: true
    },
    frequency: {
        type: String,
        required: true
    },
    reason: {
        type: String,
        required: true
    },
});


export const prescriptionSchema = new Schema({
    doctorId: {
        type: Schema.Types.ObjectId,
        ref: 'Doctor',
        required: true
    },
    medications: {
        type: [medicationsSchema],
        required: true
    },
    date: {
        type: Date,
        required: true
    }
});


const prescriptionsSchema = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    records: {
        type: [prescriptionSchema],
        required: true
    }
});

export const PrescriptionsRecord = model('PrescriptionRecord', prescriptionsSchema);