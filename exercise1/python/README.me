# Solution in python

Install requirements

	virtualenv venv
	. ./venv/bin/activate
	pip install -r requirements.txt

Run the program

	python app.py

Run the program with gunicorn

	gunicorn -w 4 -b :5000 app:app 

Run benchmark

	ab -n 10000 -c 10 http://127.0.0.1:5000/file1


## Notes

When running with gunicorn the app is run in multiple processes without 
cooperation. Each spawned child has a copy of the global `data1` variable.
So each child maintains its own count.

When running via `python app.py` there is only 1 process and `data1` variable
does work.

To make the example work also in gunicorn we need interprocess synchronization.
- Read/write to a file
- Use queue to serialize access to writing the file
- But that defies the purpose of spawning children in the first place

## Results

Running with `python app.py` on my MBP

```
erver Software:        Werkzeug/0.11.5
Server Hostname:        127.0.0.1
Server Port:            5000

Document Path:          /file1
Document Length:        40 bytes

Concurrency Level:      10
Time taken for tests:   10.383 seconds
Complete requests:      10000
Failed requests:        9991
   (Connect: 0, Receive: 0, Length: 9991, Exceptions: 0)
Total transferred:      1978894 bytes
HTML transferred:       428894 bytes
Requests per second:    963.07 [#/sec] (mean)
Time per request:       10.383 [ms] (mean)
Time per request:       1.038 [ms] (mean, across all concurrent requests)
Transfer rate:          186.11 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.4      0      24
Processing:     1   10   3.1     10      57
Waiting:        1   10   3.1      9      57
Total:          2   10   3.1     10      57

Percentage of the requests served within a certain time (ms)
  50%     10
  66%     11
  75%     11
  80%     12
  90%     13
  95%     16
  98%     19
  99%     21
 100%     57 (longest request)
```
