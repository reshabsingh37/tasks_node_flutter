import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './config/db.js';
import todoRoutes from './routes/todoRoutes.js';

dotenv.config();

const app = express();
connectDB();

app.use(cors());
app.use(express.json());

app.use('/api/todos', todoRoutes);

app.listen( 5000, () => {
  console.log(`Server running on port ${process.env.PORT || 5000}`);
});
