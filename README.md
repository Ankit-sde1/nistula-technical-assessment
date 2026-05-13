# Nistula Technical Assessment

AI-powered guest messaging webhook system for hospitality operations.

This project simulates a backend platform that receives guest messages, classifies intent, generates AI-powered draft replies, assigns confidence scores, and supports escalation workflows for urgent guest issues.

---

# Project Overview

The system is designed to support hospitality operations by handling guest communication through a centralized webhook service.

Main capabilities:
- Receive guest messages
- Detect guest intent
- Generate AI-powered draft responses
- Assign confidence scores
- Escalate urgent operational issues
- Maintain unified guest conversation history

Example guest requests:
- Maintenance complaints
- Refund requests
- Booking questions
- Check-in/check-out support
- Emergency operational issues

---

# Tech Stack

| Layer | Technology |
|---|---|
| Backend Framework | FastAPI |
| Language | Python |
| Database | PostgreSQL |
| ORM | SQLAlchemy |
| Validation | Pydantic |
| AI Provider | Claude API |
| API Testing | Swagger |
| Version Control | Git + GitHub |

---

# Features

- AI-generated guest responses
- Intent classification
- Confidence scoring
- Escalation handling
- Unified conversation architecture
- Multi-channel support ready
- Structured logging
- Human review flow for low-confidence responses

---

# Folder Structure

```txt
nistula-technical-assessment/
│
├── README.md
├── schema.sql
├── thinking.md
├── requirements.txt
├── .env.example
├── .gitignore
│
├── app
│   ├── main.py
│   ├── models.py/
│   ├── claude_services.py/
│   ├── config.py/
│   ├── classifier.py/

# 🚀 Setup Instructions

## 1. Clone the Repository

```bash
git clone https://github.com/yourusername/nistula-technical-assessment.git
cd nistula-technical-assessment
```

---

## 2. Create Virtual Environment

### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

### Mac/Linux

```bash
python3 -m venv venv
source venv/bin/activate
```

---

## 3. Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 4. Configure Environment Variables

Create a `.env` file using `.env.example`

Example:

```env
ANTHROPIC_API_KEY=your_api_key_here
DATABASE_URL=your_database_url_here
```

---

## 5. Run the Server

```bash
uvicorn app.main:app --reload
```

---

## 6. Open Swagger Docs

```txt
http://127.0.0.1:8000/docs
```

---

# 📊 Confidence Scoring Logic

The system assigns a confidence score based on:
- Keyword matching
- Intent clarity
- AI response certainty
- Message ambiguity

### High Confidence (0.85 – 1.00)
Clear intent detected.

Example:
- "Need refund"
- "No hot water"

### Medium Confidence (0.60 – 0.84)
Partially unclear request.

Example:
- "Room has some issues"

### Low Confidence (< 0.60)
Ambiguous message.

Example:
- "Need help urgently"

Low-confidence messages should be reviewed by a human agent.

