# -*- coding:utf-8 -*-
import urllib
import urllib2
import re
url='http://www.esrl.noaa.gov/psd/data/climateindices/list/'
request=urllib2.Request(url)
response = urllib2.urlopen(request)
content=response.read()
pattern=re.findall(r'/psd/data/correlation/\S*\.data',content)
for string in pattern:
	NewUrl='http://www.esrl.noaa.gov/'+string
	NewRequest=urllib2.Request(NewUrl)
	NewResponse=urllib2.urlopen(NewRequest)
	NewContent=NewResponse.read()
	name=string[22:-5]
	f=open(name,'w')
	f.write(NewContent)
	f.close()
	print NewUrl
