Answer these three questions. Maximum 400 words total.

Question A — The Immediate Response
What should the AI reply right now at 3am? Write the actual message. 
Explain in 2-3 lines why you chose this wording.

Question B — The System Design
What should the platform do beyond sending a message? Walk through the full 
system response: what gets triggered, who gets notified, what gets logged, 
what happens if no human responds within 30 minutes.

Question C — The Learning
This is the third time in two months a guest has complained about hot water 
at Villa B1. What should the system do with this pattern? What would you 
build to prevent this complaint from happening a fourth time?

----------------Answer----------------

Answer A — The Immediate Response

Hi, I’m really sorry you’re dealing with this at 3am, especially with guests arriving in the morning. I’ve marked this as urgent and alerted the on-call operations team immediately.

Someone will contact you shortly with an update and we’ll work on resolving the hot water issue as fast as possible. I’ve also flagged your refund request for review by the property manager once the situation is assessed.

Thank you for reporting this, and again, I’m sorry for the inconvenience.

"I chose this wording because the guest is angry and stressed, so the reply first acknowledges the problem instead of sounding robotic. It avoids arguing about the refund at 3am but still confirms that the request has been formally logged and escalated."

Answer B - The System Design
 
The platform should do much more than just send a WhatsApp reply.

First, the AI should classify this as:

-->Critical maintenance issue
-->High guest frustration
->Possible compensation/refund request

Then the system should automatically:

-->Create a high-priority incident ticket
-->Notify the on-call maintenance person by WhatsApp + SMS + phone call
-->Notify the operations manager in Slack/email
->Attach the guest profile, reservation details, villa number, and previous complaint history
-->Start a 30-minute escalation timer

Everything should be logged:

-->Original guest message
-->AI-generated response
-->Confidence score
-->Escalation timestamps
-->Human actions taken
Final resolution

If no human responds within 30 minutes:

Escalate to a backup manager
Trigger another call/SMS alert
Send the guest an update saying the issue is still being actively handled
Offer temporary compensation options automatically (late checkout, breakfast credit, partial refund suggestion, etc).

The important thing is that the guest should never feel ignored after reporting a serious issue.

Answer C — The Learning

If this is the third hot water complaint in two months at Villa B1, the system should stop treating it like an isolated incident.

I’d build a pattern-detection layer that tracks repeated operational problems by villa, category, and frequency. After multiple complaints, the system should automatically:

Flag Villa B1 as “high-risk”
Notify maintenance leadership
Recommend preventive inspection before the next check-in
Add a warning in the internal dashboard

For Long term, I would build a predictive maintenance workflow using historical complaint data. If Villa B1 repeatedly receives hot water complaints, the system should automatically flag the property, increase issue priority, and schedule inspection tasks before future reservations.

The goal is not just responding faster. It’s preventing the same operational mistake from happening again.
