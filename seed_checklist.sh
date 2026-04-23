#!/bin/bash
# Run this once to seed your checklist template
# Replace YOUR_TOKEN with your actual JWT token

TOKEN="404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970"


curl -X POST http://localhost:8080/api/checklists \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Network Equipment Installation Checklist",
    "description": "Standard checklist for router, switch and AP installation",
    "targetRole": "ENGINEER",
    "items": [
      {"question": "Is the device physically secured to the mounting point?", "responseType": "BOOLEAN", "isRequired": true},
      {"question": "Is the power supply connected and device powered on?", "responseType": "BOOLEAN", "isRequired": true},
      {"question": "Is the device connected to the network?", "responseType": "BOOLEAN", "isRequired": true},
      {"question": "Has the firmware been updated to the latest version?", "responseType": "BOOLEAN", "isRequired": true},
      {"question": "What is the device IP address?", "responseType": "TEXT", "isRequired": true},
      {"question": "What is the MAC address of the device?", "responseType": "TEXT", "isRequired": true},
      {"question": "Signal strength at installation point (dBm)?", "responseType": "TEXT", "isRequired": false},
      {"question": "Are cable runs labelled and documented?", "responseType": "BOOLEAN", "isRequired": false},
      {"question": "Any additional notes or issues observed?", "responseType": "TEXT", "isRequired": false}
    ]
  }'

echo ""
echo "Template created! Now run the app and the checklist will load."