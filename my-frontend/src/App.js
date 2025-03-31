import { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [message, setMessage] = useState('');
  const apiUrl = process.env.REACT_APP_API_URL;
 
  useEffect(() => {
    fetch(`${apiUrl}/api/message`)
      .then((res) => res.json())
      .then((data) => setMessage(data.message))
      .catch((err) => console.error('Error fetching API:', err));
  }, [apiUrl]);

  return (
    <div className="App">
      <h1>{message || 'Loading...'}</h1>
    </div>
  );
}

export default App;
