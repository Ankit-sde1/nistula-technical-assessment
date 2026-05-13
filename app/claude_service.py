import httpx
from app.config import ANTHROPIC_API_KEY, CLAUDE_MODEL

PROPERTY_CONTEXT = """
Property: Villa B1, Assagao, North Goa
Bedrooms: 3 | Max guests: 6 | Private pool: Yes
Check-in: 2pm | Check-out: 11am
Base rate: INR 18,000 per night (up to 4 guests)
Extra guest: INR 2,000 per night per person
WiFi password: Nistula@2024
Caretaker: Available 8am to 10pm
Chef on call: Yes, pre-booking required
Availability April 20-24: Available
Cancellation: Free up to 7 days before check-in
"""


async def generate_reply(unified_message):

    prompt = f"""
You are a hospitality support assistant.

Guest Name:
{unified_message.guest_name}

Guest Message:
{unified_message.message_text}

Query Type:
{unified_message.query_type}

Property Context:
{PROPERTY_CONTEXT}

Write a professional and friendly reply.
"""

    headers = {
        "x-api-key": ANTHROPIC_API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json"
    }

    body = {
        "model": CLAUDE_MODEL,
        "max_tokens": 300,
        "messages": [
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": prompt
                    }
                ]
            }
        ]
    }

    try:

        async with httpx.AsyncClient(timeout=30.0) as client:

            response = await client.post(
                "https://api.anthropic.com/v1/messages",
                headers=headers,
                json=body
            )

            print("STATUS CODE:", response.status_code)
            print("RESPONSE TEXT:", response.text)

            response.raise_for_status()

            data = response.json()

            return data["content"][0]["text"]

    except httpx.HTTPStatusError as e:

        if e.response.status_code == 429:
            return (
                f"Hi {unified_message.guest_name}, "
                "thank you for your message. "
                "Our team is reviewing your request and will get back to you shortly."
            )

        return f"Claude API Error: {response.text}"

    except Exception as e:
        return f"Unexpected Error: {str(e)}"