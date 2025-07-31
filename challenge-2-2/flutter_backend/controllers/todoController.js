import Todo from '../models/Todo.js';

export const getTodos = async (req, res) => {
  const todos = await Todo.find();
  res.json(todos);
};

export const createTodo = async (req, res) => {
  console.log('Creating todo:', req.body)
  const { title } = req.body;
  const todo = new Todo({ title });
  await todo.save();
  res.status(201).json(todo);
};

export const toggleTodo = async (req, res) => {
  const todo = await Todo.findById(req.params.id);
  todo.completed = !todo.completed;
  await todo.save();
  res.json(todo);
};

export const deleteTodo = async (req, res) => {
  await Todo.findByIdAndDelete(req.params.id);
  res.json({ message: 'Todo deleted' });
};