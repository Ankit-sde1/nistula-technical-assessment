from fastapi import FastAPI, HTTPException
from uuid import uuid4
from app.models import IncomingMessage, UnifiedMessage
from app.classifier import classify_query
from app.claude_service import generate_reply
from app.confidence import calculate_confidence, determine_action

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Server Running"}


@app.post("/webhook/message")
async def handle_message(payload: IncomingMessage):

    try:

        query_type = classify_query(payload.message)

        unified_message = UnifiedMessage(
            message_id=str(uuid4()),
            source=payload.source,
            guest_name=payload.guest_name,
            message_text=payload.message,
            timestamp=payload.timestamp,
            booking_ref=payload.booking_ref,
            property_id=payload.property_id,
            query_type=query_type
        )

        drafted_reply = await generate_reply(unified_message)

        confidence_score = calculate_confidence(
            query_type,
            drafted_reply
        )

        action = determine_action(
            confidence_score,
            query_type
        )

        return {
            "message_id": unified_message.message_id,
            "query_type": query_type,
            "drafted_reply": drafted_reply,
            "confidence_score": confidence_score,
            "action": action
        }

    except Exception as e:
        import traceback

        print("ERROR OCCURRED:")
        traceback.print_exc()

        raise HTTPException(
            status_code=500,
            detail=repr(e)
        )