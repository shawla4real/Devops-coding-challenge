const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());

// Route for the root URL
app.get('/', (req, res) => {
  res.send('Welcome to the Express Backend!');
});

// Example API endpoint
app.get('/api/message', (req, res) => {
  res.json({ message: 'Hello from the Express backend!' });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
