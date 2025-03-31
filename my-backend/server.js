const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

// Enable CORS for React frontend
app.use(cors());

// Sample API endpoint
app.get('/api/message', (req, res) => {
  res.json({ message: 'Hello from Express backend!' });
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});