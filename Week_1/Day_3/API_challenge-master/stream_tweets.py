#!/usr/bin/env python
# coding: utf-8

# In[1]:


import twitter
import requests as re
import os
import json


# **Task:** Load the values of access tokens and keys from environmental variables to python variables

# In[2]:


consumer_key = os.environ['TwitterConsumerKey']
consumer_secret = os.environ['TwitterSecretConsumerKey']
access_token = os.environ['TwitterAccessToken']
access_token_secret = os.environ['TwitterSecretAccessToken']


# In[3]:


api = twitter.Api(consumer_key=consumer_key,
                  consumer_secret=consumer_secret,
                  access_token_key=access_token,
                  access_token_secret=access_token_secret)


# In[4]:


# Checking the type of api object
print(type(api))


# In[5]:


## FOLLOWING FUNCTION WILL COLLECT REAL-TIME TWEETS IN OUR COMPUTER

# data returned will be for any tweet mentioning strings in the list FILTER
#FILTER = ['#datascience']

# Languages to filter tweets by is a list. This will be joined by Twitter
# to return data mentioning tweets only in the english language.
#LANGUAGES = ['en']
#SaveLocation = 'C:/Users/Nik/Coding/Compass/Week1/API_challenge-master/TestLocation/output.txt'


def main(FILTER, LANGUAGES, SaveLocation):
    with open(SaveLocation, 'a') as f:
        # api.GetStreamFilter will return a generator that yields one status
        # message (i.e., Tweet) at a time as a JSON dictionary.
        for line in api.GetStreamFilter(track=FILTER, languages=LANGUAGES):
            f.write(json.dumps(line))
            f.write('\n')

#GetStreamFilter is a twitter Python method, not a Twitter API method. The "track" filter goes through the message contents.
          


# In[8]:


#print("usage: main(['#datascience', 'computers', 'math'], ['en','fr'], filepath)")

main([':)',':('],['en'],'C:/Users/Nik/Coding/Compass/Week1/API_challenge-master/TestLocation/output3.txt')


# **Task:** Edit function `main` so it can store tweets anywhere (location specified as parameter). The FILTER and LANGUAGES should be parameters as well. Test it with different values and languages.

# **Task:** Create File `stream_tweets.py` that can be executed from the Terminal

# **Task:** Start storing tweets with either happy smiley (`:)`) or sad smiley (`:(`). We will use this dataset during the NLP section.

# In[ ]:




