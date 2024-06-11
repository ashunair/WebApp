import React, { useState } from 'react';

function App() {
  const [value1, setValue1] = useState('');
  const [value2, setValue2] = useState('');
  const [message, setMessage] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch('http://34.45.109.165:5000/submit', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ value1, value2 }),
      });

      const contentType = response.headers.get("content-type");
      if (contentType && contentType.indexOf("application/json") !== -1) {
        const data = await response.json();
        setMessage(data.message);
      } else {
        const text = await response.text();
        console.error("Unexpected response format:", text);
        setMessage("Unexpected response format");
      }
    } catch (error) {
      console.error("Error during fetch:", error);
      setMessage("Error during fetch");
    }
  };

  return (
    <div>
      <h1>Submit Data</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Value 1"
          value={value1}
          onChange={(e) => setValue1(e.target.value)}
        />
        <input
          type="text"
          placeholder="Value 2"
          value={value2}
          onChange={(e) => setValue2(e.target.value)}
        />
        <button type="submit">Submit</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
}

export default App;
