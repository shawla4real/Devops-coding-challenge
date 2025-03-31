import { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [message, setMessage] = useState('');
  const apiUrl = 'http://backend-alb-1074160532.us-east-1.elb.amazonaws.com';

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
