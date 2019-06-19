import { Processing } from './processing'

getNewAddress = ->
  address = await Processing.takeAddress('BTC')

  console.log 'New address', address

getNewAddress()
