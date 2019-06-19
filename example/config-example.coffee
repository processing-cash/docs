export Config = {
  debug: true
  url: process.env.PROCESSING_URL or 'httpa://t-api.processing.cash/api/v1'
  key: process.env.PROCESSING_KEY
  secret: process.env.PROCESSING_SECRET
  allowedIPs: []
}
