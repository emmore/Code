# -*- coding:utf-8 -*-
import urllib
import urllib2
import re
url='http://www.esrl.noaa.gov/psd/data/climateindices/list/'
request=urllib2.Request(url)
response = urllib2.urlopen(request)
content=response.read()

pattern=re.findall(r'/psd/data/correlation/.*\.data',content)
print pattern
'''
url2='http://www.esrl.noaa.gov/psd/data/correlation/'
'''
