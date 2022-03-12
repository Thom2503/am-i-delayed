# am-i-delayed
This is a script to check if I'm going to be delayed. In the morning and in the evening (going to work and leaving work). It is looking via the API for disruptions and if there are disruptions and these are on the line Rotterdam CS - Delft Station then it will send a mail with the disruption.

# The API
I'm using the free API from the NS (Nederlandse Spoorwegen). Specifically the ["Reisinformatie API"](https://apiportal.ns.nl/docs/services/reisinformatie-api/operations/getArrivals)\
The data is in JSON and there are some examples in different programming languages like: objective-c, python and ruby (which I'm using).
