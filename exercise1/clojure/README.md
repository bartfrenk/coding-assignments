# Solution in Clojure

To run the app

	lein ring server-headless


To stress test the app

	ab -n 10000 -c 10 http://127.0.0.1:3000/file1

Results on my MBP

```
Server Software:        Jetty(7.6.13.v20130916)
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /file1
Document Length:        30 bytes

Concurrency Level:      10
Time taken for tests:   4.869 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      3520000 bytes
HTML transferred:       300000 bytes
Requests per second:    2053.92 [#/sec] (mean)
Time per request:       4.869 [ms] (mean)
Time per request:       0.487 [ms] (mean, across all concurrent requests)
Transfer rate:          706.03 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.1      1      17
Processing:     1    3   1.6      3      21
Waiting:        0    3   1.4      2      18
Total:          2    5   2.0      4      25

Percentage of the requests served within a certain time (ms)
  50%      4
  66%      5
  75%      5
  80%      5
  90%      6
  95%      8
  98%     11
  99%     14
 100%     25 (longest request)	
```
