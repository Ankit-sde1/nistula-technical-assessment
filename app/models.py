from pydantic import BaseModel
from typing import Optional


class IncomingMessage(BaseModel):
    source: str
    guest_name: str
    message: str
    timestamp: str
    booking_ref: Optional[str] = None
    property_id: str


class UnifiedMessage(BaseModel):
    message_id: str
    source: str
    guest_name: str
    message_text: str
    timestamp: str
    booking_ref: Optional[str]
    property_id: str
    query_type: str