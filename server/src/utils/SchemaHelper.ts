import mongoose from "mongoose";

const getCurrentUTCTime = () => new Date().toISOString();

export const contactNumberSchema = new mongoose.Schema(
  {
    countryCode: {
      type: String,
      trim: true,
      default: "+91",
    },

    number: {
      type: String,
      trim: true,
      default: "",
      unique: true,
      match: [
        /^\+?(\d{1,4})?[\s(-]?\(?(\d{3})\)?[-\s]?(\d{3})[-\s]?(\d{4})$/,
        "Please provide a valid phoneNumber",
      ],
    },
  },
  { _id: false }
);

export const commonStringConstraints = {
  type: String,
  trim: true,
  default: "",
};

export const commonNumberConstraints = {
  type: Number,
  default: 0,
};

export const commonDateConstraints = {
  type: Date,
  default: getCurrentUTCTime(),
};

export const commonStringConstraintsRequired = {
  type: String,
  trim: true,
  default: "",
  required: true,
};

export const commonRequiredStringConstraintsRequired = {
  type: String,
  trim: true,
  default: "",
  required: true,
};

export const commonNumberConstraintsRequired = {
  type: Number,
  default: 0,
};

export const commonDOBConstraints = {
  type: String,
  required: true,
  match: [/^\d{4}-\d{2}-\d{2}$/, "Please provide a valid date of birth"],
};

export const graphPlots = {
  type: Object,
  default: {},
  match: [
    /^(\{date: "\d{4}-\d{2}-\d{2}", value: \d{1,}\})$/,
    "Please provide a valid graph plot",
  ],
};

export const commentSchema = new mongoose.Schema({
  comment: commonStringConstraints,
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Users",
    required: true,
  },
  //time of the comment including date
  time: commonDateConstraints,
});

export const graphSchema = new mongoose.Schema(
  {
    title: commonStringConstraints,
    data: [graphPlots],
  },
  { _id: false }
);

export const education = new mongoose.Schema(
  {
    university: commonStringConstraints,
    degree: commonStringConstraints,
    fieldOfStudy: commonStringConstraints,
    startDate: commonDateConstraints,
    endDate: commonDateConstraints,
  },
  { _id: false }
);

export const experience = new mongoose.Schema(
  {
    title: {
      type: String,
      trim: true,
      default: "",
      enum: ["Clinical", "Surgical"],
    },
    company: commonStringConstraints,
    position: commonStringConstraints,
    startDate: commonDateConstraints,
    endDate: commonDateConstraints,
  },
  { _id: false }
);

export const userObjectIDArray = {
  type: [mongoose.Schema.Types.ObjectId],
  ref: "Users",
  default: [],
};
