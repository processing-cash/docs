import axios from 'axios'
import _ from 'underscore'
import crypto from 'crypto'
import { Config } from './config'

class Processing
  constructor: ->
    @config = Config

  createSignature: (options) ->
    options = _.omit options, ['__proto__']
    hmac = crypto.createHmac 'sha256', Config.secret
    hmac.update JSON.stringify options
    hmac.digest 'hex'

  takeAddress: (currency) ->
    unless Config.key or Config.secret
      throw new Error 'Not set Processing environment variables PROCESSING_KEY and PROCESSING_SECRET'

    params = {currency}
    try
      response = await axios({
        url: "#{@config.url}/addresses/take"
        method: 'post'
        data: params
        headers:
          'X-Processing-Key': Config.key
          'X-Processing-Signature': @createSignature params

      })
      address = response?.data
    catch e
      if e.data
        console.log e.data
        return e.data
      else
        return {error: 'Unknown error'}
    address

# Initiate singleton
instance = new Processing

export { instance as Processing }
