import { Doctor } from "../../models/doctor.model";
import { PrescriptionsRecord } from "../../models/prescriptions.model";
import { User } from "../../models/user.model";
import catchAsync from "../../utils/catchAsync";

export const addPrescription = catchAsync(async (req, res) => {
  console.log("Adding prescription");

  try {
    const doctor = await Doctor.findById(req.body.doctorId);
    const user = await User.findById(req.body.userId);

    if (!doctor || !user) {
      res.status(404).send("Doctor or user not found");
    }

    //check if the user has a prescription record

    let prescriptionRecord = await PrescriptionsRecord.findOne({
      userId: req.body.userId,
    });

    if (!prescriptionRecord) {
      prescriptionRecord = await PrescriptionsRecord.create({
        userId: req.body.userId,
        records: [],
      });
    }

    const medication = req.body.medications;

    prescriptionRecord.records.push({
      doctorId: req.body.doctorId,
      medications: medication,
      date: new Date(),
    });

    await user.save();
    await prescriptionRecord.save();

    res.status(200).send("Prescription added successfully");
  } catch (error) {
    console.log(error);

    res.status(500).send("Internal server error");
  }
});

export const getPrescriptions = catchAsync(async (req, res) => {
  console.log("Getting prescriptions");

  try {
    const user = await User.findById(req.params.userId);

    if (!user) {
      res.status(404).send("User not found");
    }

    const prescriptionRecord = await PrescriptionsRecord.findOne({
      userId: req.params.userId,
    });

    if (!prescriptionRecord) {
      res.status(404).send("No prescriptions found");
    }

    res.status(200).send(prescriptionRecord);
  } catch (error) {
    console.log(error);

    res.status(500).send("Internal server error");
  }
});
