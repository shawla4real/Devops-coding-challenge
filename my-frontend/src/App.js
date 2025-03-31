import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Use environment variable for backend URL or default to localhost
  const backendUrl = process.env.REACT_APP_BACKEND_URL || 'http://localhost:5000';

  useEffect(() => {
    const fetchMessage = async () => {
      try {
        const response = await axios.get(`${backendUrl}/api/message`);
        setMessage(response.data.message);
        setLoading(false);
      } catch (err) {
        setError(err.message);
        setLoading(false);
      }
    };

    fetchMessage();
  }, [backendUrl]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div style={{ padding: '20px' }}>
      <h1>React Frontend</h1>
      <p>Message from backend: <strong>{message}</strong></p>
      <p>Backend URL: {backendUrl}</p>
    </div>
  );
}

export default App;