import requests
import time

def test_scalabilityB():
	start_time = time.time()
	for i in range(1,10):
		response = requests.get('http://localhost/srvb/user/' + str(i))
	end_time = time.time()
	assert(end_time - start_time) < 60
