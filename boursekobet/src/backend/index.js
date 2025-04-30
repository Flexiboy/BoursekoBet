const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();
const port = 3001;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// PostgreSQL config (ajuste les identifiants si besoin)
const pool = new Pool({
  user: 'julienmp',
  host: 'localhost',
  database: 'boursekobet',
  password: '',
  port: 5432,
});

pool.query("SELECT * FROM pg_tables WHERE tablename = 'companies'")
  .then(res => console.log('📋 Tables companies trouvées :', res.rows))
  .catch(err => console.error('❌ Erreur pg_tables:', err));


// GET /companies
app.get('/companies', async (req, res) => {
  const result = await pool.query('SELECT * FROM companies ORDER BY next_earnings');
  res.json(result.rows);
});

// POST /vote
app.post('/vote', async (req, res) => {
  const { company_id, sentiment } = req.body;
  if (!['bearish', 'neutral', 'bullish'].includes(sentiment)) {
    return res.status(400).json({ error: 'Invalid sentiment' });
  }
  await pool.query('INSERT INTO votes (company_id, sentiment) VALUES ($1, $2)', [company_id, sentiment]);
  res.status(201).json({ message: 'Vote registered' });
});

// GET /sentiment/:company_id
app.get('/sentiment/:company_id', async (req, res) => {
  const { company_id } = req.params;
  const result = await pool.query(
    `SELECT sentiment, COUNT(*) FROM votes WHERE company_id = $1 GROUP BY sentiment`,
    [company_id]
  );
  const counts = { bearish: 0, neutral: 0, bullish: 0 };
  result.rows.forEach((r) => (counts[r.sentiment] = parseInt(r.count)));
  res.json(counts);
});

app.listen(port, () => {
  console.log(`API running at http://localhost:${port}`);
});