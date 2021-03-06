#!/usr/bin/env python

import requests

host = "tsdb-test"
port = 4242

# 1451581200
start_time = "2016/01/01-00:00:00"
# 1459443600
end_time = "2016/04/01-00:00:00"

metric = "level"
tag = "location=hatyai"

# main
    
query = "http://{}:{}/api/query?start={}&end={}&m=sum:{}".format(
    host, port, start_time, end_time, metric
) + "{" + tag + "}"

print("Testing on " + query)

r = requests.get(query)
result = r.json()

expected = 2184
print("Expected: ", expected)
print("Found:    ", len(result[0]["dps"]))

if len(result[0]["dps"]) != expected :
    exit(1)

exit(0)

