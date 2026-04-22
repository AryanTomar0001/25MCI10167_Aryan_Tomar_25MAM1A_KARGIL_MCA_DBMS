# 📊 Online Trading Journal (DBMS Project)

## 🚀 Overview
The **Online Trading Journal** is a database-centric project designed to help traders systematically record, manage, and analyze their trading activities.  

This project focuses on implementing core **DBMS concepts using PostgreSQL**, including relational schema design, normalization, constraints, triggers, and analytical queries.

---

## 🎯 Features
- 📌 Store and manage trading data (Entry, Exit, Quantity, etc.)
- 📊 Automatic Profit & Loss (PnL) calculation using triggers
- 🧠 Strategy-based trade tracking
- 🏷️ Trade tagging system (High Risk, News Trade, etc.)
- 📝 Trade notes for qualitative insights
- 📈 Performance analysis (Win rate, Total PnL, Strategy performance)

---

## 🛠️ Tech Stack
- **Database:** PostgreSQL  
- **Language:** SQL, PL/pgSQL  
- **Tool:** pgAdmin  

---

## 🧱 Database Schema

### Main Entities:
- Users
- Accounts
- Instruments
- Strategies
- Trades
- Tags
- Trade Notes

👉 Full schema and queries are included in the project SQL file. :contentReference[oaicite:0]{index=0}

---

## ⚙️ Key Implementation

### 🔥 Automatic PnL Calculation (Trigger)
```sql
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
```

##  Analytical Queries

### 💰 Total Profit / Loss
```sql
SELECT SUM(pnl) AS total_pnl
FROM trades
WHERE account_id = 1;
```

<img width="363" height="202" alt="image" src="https://github.com/user-attachments/assets/5fca02a0-a645-49c0-a629-aa60986089b2" />

### Win Rate
```sql
SELECT 
    COUNT(*) FILTER (WHERE pnl > 0) * 100.0 / COUNT(*) AS win_rate
FROM trades
WHERE account_id = 1;
```
<img width="424" height="158" alt="image" src="https://github.com/user-attachments/assets/dca5f7f2-14b1-4e2d-93ff-a026b9b536bd" />

### Strategy Performance
```sql
SELECT s.strategy_name,
       COUNT(t.trade_id) AS total_trades,
       SUM(t.pnl) AS total_pnl,
       AVG(t.pnl) AS avg_pnl
FROM trades t
JOIN strategies s ON t.strategy_id = s.strategy_id
GROUP BY s.strategy_name
ORDER BY total_pnl DESC;
```
<img width="927" height="254" alt="image" src="https://github.com/user-attachments/assets/2dc7b974-1754-4501-94fe-0836a48c4c05" />


### Best Trading Day
```sql
SELECT DATE(entry_time) AS trade_date,
       SUM(pnl) AS daily_pnl
FROM trades
GROUP BY trade_date
ORDER BY daily_pnl DESC
LIMIT 1;
```
<img width="350" height="106" alt="image" src="https://github.com/user-attachments/assets/f8bfc3a9-dba6-427c-b8ee-f148f414ef65" />
