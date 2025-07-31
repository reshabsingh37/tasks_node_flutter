import express from 'express';
import mongoose from 'mongoose';
import { body, validationResult } from 'express-validator';


const app = express();
app.use(express.json());


const mongoURI = 'mongodb+srv://reshabsingh:xlknKt5srxMAFCvc@cluster0.xhjilnp.mongodb.net/task-manager';
try {
  await mongoose.connect(mongoURI);
  console.log('MongoDB connected');
} catch (err) {
  console.error('MongoDB connection error:', err);
}

const taskSchema = new mongoose.Schema({
  title: { type: String, required: true, trim: true },
  description: { type: String, trim: true },
  status: { 
    type: String, 
    required: true, 
    enum: ['pending', 'in-progress', 'completed'],
    default: 'pending'
  },
  createdAt: { type: Date, default: Date.now }
});

const Task = mongoose.model('Task', taskSchema);

app.post('/tasks', [
  body('title').notEmpty().withMessage('Title is required'),
  body('status').isIn(['pending', 'in-progress', 'completed']).withMessage('Invalid status')
], async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { title, description, status } = req.body;
    const task = new Task({
      title,
      description,
      status
    });

    await task.save();
    res.status(201).json(task);
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));