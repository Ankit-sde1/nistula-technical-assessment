def classify_query(message: str) -> str:

    text = message.lower()

    if any(word in text for word in ["available", "availability"]):
        return "pre_sales_availability"

    if any(word in text for word in ["rate", "price", "cost"]):
        return "pre_sales_pricing"

    if any(word in text for word in ["check in", "wifi"]):
        return "post_sales_checkin"

    if any(word in text for word in ["airport transfer", "early check"]):
        return "special_request"

    if any(word in text for word in ["not happy", "ac not working"]):
        return "complaint"

    return "general_enquiry"
