import {lookup as zipLookup} from 'zipcodes'

class Store
  constructor: ->
    @zipCodes =
      10223: yes
      10224: yes
      10225: yes
      39211: yes
      30106: yes
      30107: yes

  insert: (zip) ->
    return "#{zip} is not a valid zip code" unless zipLookup(zip)
    return "Zip code #{zip} already added." if @zipCodes[zip]?
    @zipCodes[zip] = yes
    return "Zip code #{zip} inserted."

  delete: (zip) ->
    return "Zip code #{zip} does not exist." unless @zipCodes[zip]?
    delete @zipCodes[zip]
    return "Zip code #{zip} deleted."

  has: (zip) -> return @zipCodes[zip]?

  display: ->
    zipCodes = Object.keys(@zipCodes)
    switch zipCodes.length
      when 0 then return 'No zip codes to display'
      when 1 then return zipCodes[0]
      else formatZipCodes(sort(zipCodes))

store = new Store()
export default store

formatZipCodes = (zips) ->
  response = []
  joined = []
  for zip, i in zips
    if parseInt(zip,10)+1 is parseInt(zips[i+1],10)
      joined.push zip
    else if joined.length > 0
      response.push "#{joined[0]}-#{zip}"
      joined = []
    else
      response.push zip
  return response.join(',')

sort = (arr) ->
  arr.sort((a, b) =>
    if a > b
      1
    else
      -1
  )
  arr