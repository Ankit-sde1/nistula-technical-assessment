 
-- ENUM TYPES
 

CREATE TYPE message_source AS ENUM (
    'whatsapp',
    'booking_com',
    'airbnb',
    'instagram',
    'direct'
);

CREATE TYPE sender_type AS ENUM (
    'guest',
    'ai',
    'agent',
    'system'
);

CREATE TYPE message_direction AS ENUM (
    'inbound',
    'outbound'
);

CREATE TYPE message_status AS ENUM (
    'received',
    'drafted',
    'edited',
    'sent',
    'failed'
);

CREATE TYPE query_classification AS ENUM (
    'pre_sales_availability',
    'pre_sales_pricing',
    'post_sales_checkin',
    'special_request',
    'complaint',
    'general_enquiry'
);

CREATE TYPE outbound_generation_type AS ENUM (
    'manual',
    'ai_drafted',
    'agent_edited',
    'auto_sent'
);

 
-- GUESTS
-- One guest profile across all communication channels
 

CREATE TABLE guests (
    guest_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(50),

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
 
-- GUEST CHANNEL IDENTITIES
-- Allows one guest to have multiple platform identities
 

CREATE TABLE guest_channels (
    guest_channel_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    guest_id UUID NOT NULL REFERENCES guests(guest_id) ON DELETE CASCADE,

    source message_source NOT NULL,

    -- Example:
    -- WhatsApp phone number
    -- Airbnb guest id
    -- Instagram handle
    external_user_id VARCHAR(255) NOT NULL,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    UNIQUE(source, external_user_id)
);

 
-- PROPERTIES / VILLAS
 

CREATE TABLE properties (
    property_id VARCHAR(100) PRIMARY KEY,

    property_name VARCHAR(255) NOT NULL,
    location TEXT,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

 
-- RESERVATIONS / BOOKINGS
 

CREATE TABLE reservations (
    reservation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    booking_reference VARCHAR(100) UNIQUE NOT NULL,

    guest_id UUID NOT NULL REFERENCES guests(guest_id),
    property_id VARCHAR(100) NOT NULL REFERENCES properties(property_id),

    source message_source NOT NULL,

    check_in_date DATE,
    check_out_date DATE,

    number_of_guests INTEGER,

    reservation_status VARCHAR(50),

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
 
-- CONVERSATIONS
-- One thread linked to guest + optional reservation
 

CREATE TABLE conversations (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    guest_id UUID NOT NULL REFERENCES guests(guest_id),

    reservation_id UUID REFERENCES reservations(reservation_id),

    source message_source NOT NULL,

    subject VARCHAR(255),

    started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_message_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    is_active BOOLEAN DEFAULT TRUE
);

 
-- MESSAGES
-- Unified message table across ALL channels 
CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    conversation_id UUID NOT NULL
        REFERENCES conversations(conversation_id)
        ON DELETE CASCADE,

    guest_id UUID REFERENCES guests(guest_id),

    reservation_id UUID REFERENCES reservations(reservation_id),

    source message_source NOT NULL,

    direction message_direction NOT NULL,

    sender sender_type NOT NULL,

    external_message_id VARCHAR(255),

    message_text TEXT NOT NULL,

    message_status message_status DEFAULT 'received',

    -- AI classification fields (mainly for inbound messages)
    query_type query_classification,
    ai_confidence_score NUMERIC(4,2),

    -- Outbound AI tracking
    generation_type outbound_generation_type,

    ai_drafted BOOLEAN DEFAULT FALSE,
    agent_edited BOOLEAN DEFAULT FALSE,
    auto_sent BOOLEAN DEFAULT FALSE,

    -- Audit fields
    drafted_by_ai_at TIMESTAMP WITH TIME ZONE,
    edited_by_agent_at TIMESTAMP WITH TIME ZONE,
    auto_sent_at TIMESTAMP WITH TIME ZONE,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

 
-- OPTIONAL: MESSAGE EDIT HISTORY
-- Tracks human edits to AI drafts
 

CREATE TABLE message_revisions (
    revision_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    message_id UUID NOT NULL
        REFERENCES messages(message_id)
        ON DELETE CASCADE,

    previous_text TEXT NOT NULL,
    updated_text TEXT NOT NULL,

    edited_by VARCHAR(255),

    edited_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
 
-- INDEXES FOR PERFORMANCE
 

CREATE INDEX idx_messages_conversation
ON messages(conversation_id);

CREATE INDEX idx_messages_guest
ON messages(guest_id);

CREATE INDEX idx_messages_query_type
ON messages(query_type);

CREATE INDEX idx_messages_created_at
ON messages(created_at);

CREATE INDEX idx_conversations_guest
ON conversations(guest_id);

CREATE INDEX idx_reservations_guest
ON reservations(guest_id);