def calculate_confidence(query_type, drafted_reply):

    score = 0.75

    if query_type != "complaint":
        score += 0.15

    if len(drafted_reply) > 40:
        score += 0.05

    if query_type == "complaint":
        score = 0.55

    return round(min(score, 0.99), 2)


def determine_action(score, query_type):

    if query_type == "complaint":
        return "escalate"

    if score > 0.85:
        return "auto_send"

    if score >= 0.60:
        return "agent_review"

    return "escalate"