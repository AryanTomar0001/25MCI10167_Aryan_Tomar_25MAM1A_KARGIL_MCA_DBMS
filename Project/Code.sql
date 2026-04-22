-- USERS TABLE

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users (name, email, password_hash) VALUES
('Aryan Tomar', 'aryan@example.com', 'hashed_password_1'),
('Rahul Sharma', 'rahul@example.com', 'hashed_password_2');

select * from users;

-- ACCOUNTS (One user → many accounts)

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    broker_name VARCHAR(100),
    account_type VARCHAR(50), -- demo / live
    balance NUMERIC(12,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accounts (user_id, broker_name, account_type, balance) VALUES
(1, 'Exness', 'live', 50000),
(1, 'Binance', 'demo', 20000),
(2, 'Zerodha', 'live', 75000);


select * from accounts;

-- INSTRUMENTS (Stock, Forex, Crypto)

CREATE TABLE instruments (
    instrument_id SERIAL PRIMARY KEY,
    symbol VARCHAR(20) NOT NULL,  -- e.g., BTCUSD, NIFTY
    name VARCHAR(100),
    market VARCHAR(50) -- forex, crypto, stocks
);


INSERT INTO instruments (symbol, name, market) VALUES
('BTCUSD', 'Bitcoin', 'crypto'),
('ETHUSD', 'Ethereum', 'crypto'),
('NIFTY50', 'Nifty Index', 'stocks'),
('XAUUSD', 'Gold', 'forex');

select * from instruments;



-- STRATEGIES (User-defined)


CREATE TABLE strategies (
    strategy_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    strategy_name VARCHAR(100) NOT NULL,
    description TEXT
);


INSERT INTO strategies (user_id, strategy_name, description) VALUES
(1, 'Scalping', 'Quick trades within minutes'),
(1, 'Breakout', 'Trade on breakout levels'),
(1, 'Swing Trading', 'Hold trades for days'),
(2, 'Intraday', 'Same day trading');

select * from strategies;


-- TRADES TABLE (Core)

CREATE OR REPLACE FUNCTION calculate_pnl()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.exit_price IS NOT NULL THEN
        IF NEW.trade_type = 'BUY' THEN
            NEW.pnl := (NEW.exit_price - NEW.entry_price) * NEW.quantity;
        ELSE
            NEW.pnl := (NEW.entry_price - NEW.exit_price) * NEW.quantity;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calculate_pnl
BEFORE INSERT OR UPDATE ON trades
FOR EACH ROW
EXECUTE FUNCTION calculate_pnl();


CREATE TABLE trades (
    trade_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE,
    instrument_id INT REFERENCES instruments(instrument_id),
    strategy_id INT REFERENCES strategies(strategy_id),

    trade_type VARCHAR(10) CHECK (trade_type IN ('BUY', 'SELL')),
    
    entry_price NUMERIC(10,2) NOT NULL,
    exit_price NUMERIC(10,2),
    quantity NUMERIC(10,2) NOT NULL,

    entry_time TIMESTAMP NOT NULL,
    exit_time TIMESTAMP,

    stop_loss NUMERIC(10,2),
    take_profit NUMERIC(10,2),

    pnl NUMERIC(12,2), -- calculated later

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO trades 
(account_id, instrument_id, strategy_id, trade_type, entry_price, exit_price, quantity, entry_time, exit_time, stop_loss, take_profit)
VALUES
-- Profitable BUY (BTC)
(1, 1, 1, 'BUY', 60000, 61000, 0.5, '2026-04-01 10:00', '2026-04-01 11:00', 59500, 62000),

-- Loss SELL (ETH)
(1, 2, 2, 'SELL', 3000, 3100, 1, '2026-04-02 12:00', '2026-04-02 14:00', 3150, 2800),

-- Profit SELL (Gold)
(1, 4, 2, 'SELL', 2000, 1950, 2, '2026-04-03 09:00', '2026-04-03 10:30', 2020, 1900),

-- Loss BUY (NIFTY)
(3, 3, 4, 'BUY', 18000, 17800, 10, '2026-04-04 11:00', '2026-04-04 13:00', 17750, 18500),

-- Profit BUY (ETH)
(2, 2, 3, 'BUY', 2800, 2950, 1.5, '2026-04-05 10:00', '2026-04-05 16:00', 2700, 3000);


select *from trades;

-- TAGS (For labeling trades)

CREATE TABLE tags (
    tag_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    tag_name VARCHAR(50)
);


INSERT INTO tags (user_id, tag_name) VALUES
(1, 'High Risk'),
(1, 'News Trade'),
(1, 'Revenge Trade'),
(2, 'Safe Trade');

select *from tags;

-- Many-to-many (Trade ↔ Tags)
CREATE TABLE trade_tags (
    trade_id INT REFERENCES trades(trade_id) ON DELETE CASCADE,
    tag_id INT REFERENCES tags(tag_id) ON DELETE CASCADE,
    PRIMARY KEY (trade_id, tag_id)
);


INSERT INTO trade_tags (trade_id, tag_id) VALUES
(1, 1), -- High Risk
(1, 2), -- News Trade
(2, 3), -- Revenge Trade
(3, 1),
(4, 4),
(5, 2);

select *from trade_tags;


-- TRADE NOTES

CREATE TABLE trade_notes (
    note_id SERIAL PRIMARY KEY,
    trade_id INT REFERENCES trades(trade_id) ON DELETE CASCADE,
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO trade_notes (trade_id, note) VALUES
(1, 'Perfect breakout, followed plan'),
(2, 'Entered emotionally, bad trade'),
(3, 'Gold reacted well at resistance'),
(4, 'Market was sideways, mistake entry'),
(5, 'Good swing trade setup');

select *from trade_notes;


---Total Profit/Loss
SELECT SUM(pnl) AS total_pnl
FROM trades
WHERE account_id = 1;

-- Win Rate
SELECT 
    COUNT(*) FILTER (WHERE pnl > 0) * 100.0 / COUNT(*) AS win_rate
FROM trades
WHERE account_id = 1;


-- Strategy Performance

SELECT s.strategy_name,
       COUNT(t.trade_id) AS total_trades,
       SUM(t.pnl) AS total_pnl,
       AVG(t.pnl) AS avg_pnl
FROM trades t
JOIN strategies s ON t.strategy_id = s.strategy_id
GROUP BY s.strategy_name


--Best Trading Day

SELECT DATE(entry_time) AS trade_date,
       SUM(pnl) AS daily_pnl
FROM trades
GROUP BY trade_date
ORDER BY daily_pnl DESC
LIMIT 1;
ORDER BY total_pnl DESC;
