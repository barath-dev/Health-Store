import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

export const db = mongoose.connect(process.env.MONGODB_URL || '');

db.then(() => {
    
    console.log('Connected to MongoDB');
    }
).catch((error) => {
    console.log('Error connecting to MongoDB', error);
});


