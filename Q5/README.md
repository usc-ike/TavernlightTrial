## NOTE:

There appears to be a bug in OTClient in src/client/effect.cpp where the spell animations will not align corrently as can be seen on the forum thread below:
https://otland.net/threads/issue-on-the-animation-of-eternal-winter.281595/

Therefore, I took a look at mehahs otc and copied over the code that fixes the issue. 

The rest of the files belong in the server side with the main lua file belonging in data/spells/scripts/attack and the xml file belonging in data/spells directory.