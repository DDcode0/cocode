import axios from 'axios';

const api = axios.create({
    // baseURL: 'http://127.0.0.1:5000/api', // Aquí va la URL del backend
    baseURL: process.env.REACT_APP_API_URL || 'http://127.0.0.1:5000/api',
});

export default api;