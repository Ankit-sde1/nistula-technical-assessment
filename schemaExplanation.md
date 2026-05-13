# Design Decisions

## 1. Separate Tables for Core Entities
I created separate tables for Guests, Properties, Bookings, and Messages to keep the database normalized and avoid duplicate data. This improves maintainability and makes future updates easier.

---

## 2. Unified Message Storage
All guest messages from different platforms (WhatsApp, Airbnb, Booking.com, Instagram, Direct) are stored in a single `messages` table using a common schema. This makes the backend channel-agnostic and easier to scale.

---

## 3. UUID for Message IDs
I used UUIDs for `message_id` because messages may arrive simultaneously from multiple channels. UUIDs ensure globally unique identifiers without collision risk.

---

## 4. Foreign Key Relationships
Bookings, guests, properties, and messages are connected using foreign keys to maintain relational integrity and ensure consistent data linking.

---

## 5. Confidence Score & Action Tracking
The database stores:
- AI drafted replies
- confidence scores
- operational actions (`auto_send`, `agent_review`, `escalate`)

This helps support AI auditing, workflow tracking, and future analytics.

---

## 6. Indexed Frequently Queried Fields
Indexes were added on:
- `query_type`
- `source`
- `property_id`

to improve filtering and query performance for operational dashboards and reporting.

---

# Hardest Design Decision
The hardest design decision was designing the messages table to support both operational workflows and AI processing requirements simultaneously.

The challenge was balancing flexibility with structure. Messages needed to support multiple external platforms, AI-generated replies, confidence scores, escalation workflows, and booking relationships while still remaining normalized and scalable.

I solved this by keeping the message schema unified and channel-agnostic while linking it to bookings, guests, and properties through foreign keys. This makes the system easier to extend in the future for analytics, conversation history, or additional AI features without redesigning the database.

 

 
