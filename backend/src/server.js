const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config({path: "./.env"});


const db = require('../config/db.js'); // Imports your database connection

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // Allows your API to read JSON data

// API Endpoint: Get all available products
app.get('/api/products', async (req, res) => {
    try {
        // Query the database for products that are not currently rented
        const [rows] = await db.query('SELECT * FROM Product');
        res.json(rows); // Send the rows back as JSON
    } catch (error) {
        console.error("Error fetching products:", error);
        res.status(500).json({ error: 'Internal Database Error' });
    }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
