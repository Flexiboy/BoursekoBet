import React, { useEffect, useState } from "react";
import axios from "axios";

const API_URL = "http://localhost:3001"; // back-end local

const SentimentButton = ({ companyId, sentiment, onVote }) => (
  <button
    className="px-3 py-1 m-1 rounded border hover:bg-gray-100"
    onClick={() => onVote(companyId, sentiment)}
  >
    {sentiment}
  </button>
);

const CompanyCard = ({ company, onVote, votes }) => {
  const { bearish = 0, neutral = 0, bullish = 0 } = votes || {};
  const total = bearish + neutral + bullish;
  const percent = (x) => (total ? Math.round((x / total) * 100) : 0);

  return (
    <div className="p-4 m-2 border rounded shadow w-full max-w-md">
      <h2 className="text-xl font-semibold">{company.name} ({company.ticker})</h2>
      <p className="text-sm text-gray-600">Earnings le {company.next_earnings}</p>

      <div className="mt-2">
        <SentimentButton companyId={company.id} sentiment="bearish" onVote={onVote} />
        <SentimentButton companyId={company.id} sentiment="neutral" onVote={onVote} />
        <SentimentButton companyId={company.id} sentiment="bullish" onVote={onVote} />
      </div>

      <div className="mt-2 text-sm text-gray-700">
        🔻 {percent(bearish)}% ⚖️ {percent(neutral)}% 🚀 {percent(bullish)}%
      </div>
    </div>
  );
};

function App() {
  const [companies, setCompanies] = useState([]);
  const [votes, setVotes] = useState({});

  useEffect(() => {
    axios.get(`${API_URL}/companies`).then((res) => setCompanies(res.data));
  }, []);

  const fetchVotes = async (companyId) => {
    const res = await axios.get(`${API_URL}/sentiment/${companyId}`);
    setVotes((v) => ({ ...v, [companyId]: res.data }));
  };

  const handleVote = async (companyId, sentiment) => {
    await axios.post(`${API_URL}/vote`, { company_id: companyId, sentiment });
    fetchVotes(companyId);
  };

  useEffect(() => {
    companies.forEach((c) => fetchVotes(c.id));
  }, [companies]);

  return (
    <div className="flex flex-col items-center p-4">
      <h1 className="text-3xl font-bold mb-4">Earnings Sentiment Tracker</h1>
      {companies.map((c) => (
        <CompanyCard key={c.id} company={c} onVote={handleVote} votes={votes[c.id]} />
      ))}
    </div>
  );
}

export default App;