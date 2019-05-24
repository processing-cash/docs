# Processing.Cash - Cryptocurrency gateway

## API Reference

HTTP endpoint https://t-api.processing.cash/api/v1

## Authorization

Authorization is done via sending two headers:

1. **X-Processing-Key** – The public key, that can be obtained from user's account
2. **X-Processing-Signature** – POST body, signed by the secret key HMAC-SHA512, secret key is also obtained from user's account

See examples below

```php
$paramsArray = ['key' => 'value'];
$requestBody = json_encode($paramsArray);
$signature   = hash_hmac('sha512', $requestBody, $apiSecret);
```

```coffeescript
import crypto from 'crypto'
hmac = crypto.createHmac 'sha256', secret
hmac.update JSON.stringify(requestBody)
signature = hmac.digest 'hex'
```

### Supported currencies

- BTC
- ETH
- LTC
- DASH
- BNB
- LA
- AGRO

### POST - Generate new address

https://t-api.processing.cash/api/v1/addresses/take

This method is used for obtaining deposit address for receiving funds

#### Request json body params

```
{
  currency: String // REQUIRED, Currency symbol from supported currencies list
  foreignId: String // OPTIONAL Any id from your side. We recommend using this parameter to identify customer on your side.
}
```

#### Response

New address

### POST - Withdrawal

https://t-api.processing.cash/api/v1/withdrawal/make

Request funds withdrawal

#### Request json body params

```
{
  currency: String // REQUIRED, Currency symbol from supported currencies list
  foreignId: String // REQUIRED, Any id from your side.
  amount: String // REQUIRED, Amount to send
  address: String // Address to withdraw currency, for example:
}
```

### POST - Webhook notifications

https://your-domain.com/webhook-url

For any transaction, deposit or withdrawal, transaction callback will come to the url that you specified in your merchant dashboard.

#### Example callback data

```
{
  "id": 1,
  "txid": "d1iu9r10ijf2pfkni23uoifnpekfmwdfwef2f2",
  "foreignId": "22",
  "currency": "BTC",
  "currencyFee": "BTC",
  "address": "address-string",
  "tag": "22",
  "amount": "1.01",
  "fee": "0.001",
  "confirmations": "5",
  "type": "deposit",
  "status": "confirmed",
  "error": "Error message if any error occured"
}
```

To provide authentication for the callback, processing API signs the POST your api key and secret:

1. **X-Processing-Key** – Your public key
2. **X-Processing-Signature** – POST body, signed by the your secret key HMAC-SHA512
