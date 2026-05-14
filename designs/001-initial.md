# 001 - Initial Design

### Context

The cycle of refilling ADHD prescriptions is very tedious and has multiple steps. 

The general process is like so:
1. Pick up a prescription
2. Request the next prescription to be sent to the pharmacy, dated in advance for easy refilling
3. Wait until the prescription can be refilled, based on when it was picked up (25d after pickup)
4. Request the pharmacy to fill the prescription
5. Repeat

### Problem Statement

The goal is to create an iOS app with an AWS backend, which provides reminders throughout the process
to avoid missing a prescription.

### Architecture

1. iOS frontend
2. AWS backend
    1. Cognito for auth
    2. API gateway
    3. DynamoDB storage
    4. SNS notifications
