 #!/bin/bash

CLIENT_ID="30dfe565-7139-3d5e-aba3-e3de55453ac5"
CLIENT_SECRET="c33d8668-962d-36c5-a78e-3e6983a38b3f"

TOKEN_ENCODED=$(printf "$CLIENT_ID:$CLIENT_SECRET" | base64 -w 0)

echo "CLIENT_ID: $CLIENT_ID"
echo "CLIENT_SECRET: $CLIENT_SECRET"
echo "TOKEN_ENCODED: $TOKEN_ENCODED"

JSON='{ "client_id": "%s", "state": "{}", "redirect_uri": "http://local" }'

DATA=$(printf "$JSON" "$CLIENT_ID")

RESPONSE_CODE=$(curl --header "Content-Type: application/json" \
  -s \
  --request POST \
  --data "$DATA" \
  http://api-dev.algartelecom.com.br/oauth/grant-code)

# echo "The JSON response from Sensedia: $RESPONSE_CODE"
IFS="="
set $RESPONSE_CODE
unset IFS

CODE=${3:0:36}
echo "The CODE is: $CODE"

TOKEN=$(curl --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Authorization: Basic $TOKEN_ENCODED" \
  -s \
  --request POST \
  --data "grant_type=authorization_code&code=$CODE" \
  http://api-dev.algartelecom.com.br/oauth/access-token)

echo "The Response from ALGAR OAth: $TOKEN"

kubectl run microservices-db-ibm-mongodb-dev-client --rm --tty -i --image mongo --command -- mongo microservices-db-ibm-mongodb-dev:27017/admin -u mongo -p passw0rd

{
    "contractId" : "1001",
    "email" : "eu@algarbr.com.br",
    "user" : {
        "password" : "3772f026a57b"
    },
    "quota" : {
        "instances" : 1
    }
	
	