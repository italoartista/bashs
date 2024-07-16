#!/bin/bash

# Verifica se o diretório do projeto foi passado como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <diretório-do-projeto>"
  exit 1
fi

PROJECT_DIR=$1

# Navega até o diretório do projeto
cd $PROJECT_DIR

# Instala Tailwind CSS e Shadcn
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
npm install @shadcn/blocks

# Cria a estrutura de diretórios
mkdir -p components hooks pages/crypto styles

# Cria o arquivo tailwind.config.js
cat > tailwind.config.js <<EOL
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Cria o arquivo postcss.config.js
cat > postcss.config.js <<EOL
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOL

# Cria o arquivo styles/globals.css
cat > styles/globals.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Atualiza o arquivo pages/_app.js para importar o CSS global
cat > pages/_app.js <<EOL
import 'tailwindcss/tailwind.css';
import '../styles/globals.css';

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}

export default MyApp;
EOL

# Cria o componente CryptoChart.js
cat > components/CryptoChart.js <<EOL
import { Line } from '@shadcn/blocks';

const CryptoChart = ({ data }) => {
  return (
    <div className="chart-container mt-4">
      {data.length > 0 ? (
        <Line
          data={{
            datasets: [{
              data: data,
              label: \`Price\`,
              borderColor: '#3e95cd',
              fill: false,
            }]
          }}
          options={{
            responsive: true,
            scales: {
              x: {
                type: 'time',
                time: {
                  unit: 'day'
                }
              },
              y: {
                beginAtZero: false
              }
            }
          }}
        />
      ) : (
        <p>Loading chart...</p>
      )}
    </div>
  );
};

export default CryptoChart;
EOL

# Cria o hook useFetchCryptos.js
cat > hooks/useFetchCryptos.js <<EOL
import { useState, useEffect } from 'react';

const useFetchCryptos = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('https://api.binance.com/api/v3/ticker/24hr');
        const result = await response.json();
        setData(result);
        setLoading(false);
      } catch (err) {
        setError(err);
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
};

export default useFetchCryptos;
EOL

# Cria o hook useFetchCryptoDetails.js
cat > hooks/useFetchCryptoDetails.js <<EOL
import { useState, useEffect } from 'react';

const useFetchCryptoDetails = (symbol) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(\`https://api.binance.com/api/v3/ticker/24hr?symbol=\${symbol}\`);
        const result = await response.json();
        setData(result);
        setLoading(false);
      } catch (err) {
        setError(err);
        setLoading(false);
      }
    };

    if (symbol) {
      fetchData();
    }
  }, [symbol]);

  return { data, loading, error };
};

export default useFetchCryptoDetails;
EOL

# Cria o hook useFetchCryptoHistory.js
cat > hooks/useFetchCryptoHistory.js <<EOL
import { useState, useEffect } from 'react';

const useFetchCryptoHistory = (symbol, interval = '1d', limit = 30) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(\`https://api.binance.com/api/v3/klines?symbol=\${symbol}&interval=\${interval}&limit=\${limit}\`);
        const result = await response.json();
        const formattedData = result.map(item => ({
          x: new Date(item[0]).toLocaleDateString(),
          y: parseFloat(item[4]), // Close price
        }));
        setData(formattedData);
        setLoading(false);
      } catch (err) {
        setError(err);
        setLoading(false);
      }
    };

    if (symbol) {
      fetchData();
    }
  }, [symbol, interval, limit]);

  return { data, loading, error };
};

export default useFetchCryptoHistory;
EOL

# Cria a página inicial index.js
cat > pages/index.js <<EOL
import Link from 'next/link';
import useFetchCryptos from '../hooks/useFetchCryptos';

const Home = () => {
  const { data: cryptos, loading, error } = useFetchCryptos();

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-4">Crypto Dashboard</h1>
      <ul className="space-y-2">
        {cryptos.map((crypto) => (
          <li key={crypto.symbol} className="p-4 border rounded-lg bg-gray-800 hover:bg-gray-700">
            <Link href={\`/crypto/\${crypto.symbol}\`}>
              <a className="text-blue-400">{crypto.symbol} - {crypto.lastPrice}</a>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Home;
EOL

# Cria a página de detalhes [id].js
cat > pages/crypto/[id].js <<EOL
import { useRouter } from 'next/router';
import useFetchCryptoDetails from '../../hooks/useFetchCryptoDetails';
import useFetchCryptoHistory from '../../hooks/useFetchCryptoHistory';
import CryptoChart from '../../components/CryptoChart';

const CryptoDetail = () => {
  const router = useRouter();
  const { id } = router.query;
  const { data: crypto, loading: cryptoLoading, error: cryptoError } = useFetchCryptoDetails(id);
  const { data: history, loading: historyLoading, error: historyError } = useFetchCryptoHistory(id);

  if (cryptoLoading || historyLoading) return <div>Loading...</div>;
  if (cryptoError) return <div>Error: {cryptoError.message}</div>;
  if (historyError) return <div>Error: {historyError.message}</div>;

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-4">{crypto.symbol} Details</h1>
      <p>Price: {crypto.lastPrice}</p>
      <p>24h Change: {crypto.priceChangePercent}%</p>
      <p>High Price: {crypto.highPrice}</p>
      <p>Low Price: {crypto.lowPrice}</p>
      <CryptoChart data={history} />
    </div>
  );
};

export default CryptoDetail;
EOL

echo "Todos os componentes, hooks e páginas foram criados com sucesso no projeto Next.js existente!"
