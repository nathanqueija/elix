import React, { useState } from 'react';
import { Link } from 'react-router-dom';
const SignupRest = ({ history }) => {
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState({
    username: '',
    email: '',
    password: ''
  });
  const [error, setError] = useState(null);

  const signup = async () => {
    setLoading(true);
    try {
      const response = await fetch('http://localhost:4000/users', {
        method: 'POST',
        body: JSON.stringify(data),
        headers: new Headers({
          'Content-Type': 'application/json'
        })
      });

      const json = await response.json();

      handleCompleted(json);
    } catch (e) {
      setError('An error ocurred');
    }

    setLoading(false);
  };

  const handleChange = event => {
    const { name, value } = event.target;
    setData({
      ...data,
      [name]: value
    });
  };

  const isFormValid = () => {
    return (
      data.username.length > 0 &&
      data.email.length > 0 &&
      data.password.length > 0
    );
  };

  const handleCompleted = data => {
    localStorage.setItem('auth-token', data.token);
    history.push('/');
  };

  return (
    <form
      className="signup"
      onSubmit={e => {
        e.preventDefault();
        signup();
      }}
    >
      <h2>Sign Up</h2>
      <h3>
        <Link to="/sign-in">Have an account?</Link>
      </h3>
      {error}
      <fieldset disabled={loading} aria-busy={loading}>
        <label htmlFor="username">Username</label>
        <input
          type="text"
          name="username"
          id="username"
          required
          autoFocus
          value={data.username}
          onChange={handleChange}
        />
        <label htmlFor="email">Email</label>
        <input
          type="email"
          name="email"
          id="email"
          required
          value={data.email}
          onChange={handleChange}
        />
        <label htmlFor="password">Password</label>
        <input
          type="password"
          name="password"
          id="password"
          required
          value={data.password}
          onChange={handleChange}
        />
        <button type="submit" disabled={loading || !isFormValid()}>
          Sign Up
        </button>
      </fieldset>
    </form>
  );
};

export default SignupRest;
