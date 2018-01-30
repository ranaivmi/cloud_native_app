import time
import requests

def test_scalabilityP():
	start_time = time.time()
	for i in range (1,10):
		response = requests.get("http://localhost/?id=" + str(i) + "&forceplay=true")
	end_time = time.time()
	assert (end_time - start_time) < 1	
