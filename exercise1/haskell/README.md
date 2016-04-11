# Solution in Haskell

To install dependencies

    cabal install servant
    cabal install servant-server
    cabal install wai
    cabal install strict
    cabal install stm

To build the example

   ghc assignment.hs

To run the example

    ./assignment

To stress test the example

    ab -n 10000 -c 10 http://127.0.0.1:8081/file
    ab -n 10000 -c 10 http://127.0.0.1:8081/counter

## Notes

The solution at /file drops requests when multiple access to the count file occur. So
after running the stress test and then curling `curl http://127.0.0.1:8081/file`,
instead of 10001 as count you get a lower number due to the dropped requests.

## Results

On my MBP (for the /file endpoint).

```
Server Software:        Warp/3.2.6
Server Hostname:        127.0.0.1
Server Port:            8081

Document Path:          /file
Document Length:        37 bytes

Concurrency Level:      10
Time taken for tests:   4.370 seconds
Complete requests:      10000
Failed requests:        9951
   (Connect: 0, Receive: 0, Length: 9951, Exceptions: 0)
Non-2xx responses:      63
Total transferred:      1460581 bytes
HTML transferred:       378817 bytes
Requests per second:    2288.35 [#/sec] (mean)
Time per request:       4.370 [ms] (mean)
Time per request:       0.437 [ms] (mean, across all concurrent requests)
Transfer rate:          326.40 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.4      0       9
Processing:     1    4   3.7      3      28
Waiting:        0    4   3.4      2      27
Total:          1    4   3.7      3      28

Percentage of the requests served within a certain time (ms)
  50%      3
  66%      3
  75%      4
  80%      5
  90%      8
  95%     11
  98%     20
  99%     21
 100%     28 (longest request)
```

Results on my DELL 5450 i5 for the /counter endpoint.

```
Server Software:        Warp/3.2.6
Server Hostname:        localhost
Server Port:            8081

Document Path:          /counter
Document Length:        31 bytes

Concurrency Level:      10
Time taken for tests:   0.394 seconds
Complete requests:      10000
Failed requests:        9990
   (Connect: 0, Receive: 0, Length: 9990, Exceptions: 0)
Total transferred:      1418890 bytes
HTML transferred:       338890 bytes
Requests per second:    25355.29 [#/sec] (mean)
Time per request:       0.394 [ms] (mean)
Time per request:       0.039 [ms] (mean, across all concurrent requests)
Transfer rate:          3513.32 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     0    0   0.1      0       2
Waiting:        0    0   0.1      0       1
Total:          0    0   0.1      0       3

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      0
  95%      1
  98%      1
  99%      1
 100%      3 (longest request)
```

Results on my DELL 5450 i5 for the /file endpoint.

```
Server Software:        Warp/3.2.6
Server Hostname:        localhost
Server Port:            8081

Document Path:          /file
Document Length:        37 bytes

Concurrency Level:      10
Time taken for tests:   1.350 seconds
Complete requests:      10000
Failed requests:        9978
   (Connect: 0, Receive: 0, Length: 9978, Exceptions: 0)
Non-2xx responses:      15
Total transferred:      1460128 bytes
HTML transferred:       379708 bytes
Requests per second:    7405.28 [#/sec] (mean)
Time per request:       1.350 [ms] (mean)
Time per request:       0.135 [ms] (mean, across all concurrent requests)
Transfer rate:          1055.92 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     1    1   0.3      1       5
Waiting:        0    1   0.3      1       5
Total:          1    1   0.3      1       6

Percentage of the requests served within a certain time (ms)
  50%      1
  66%      1
  75%      1
  80%      1
  90%      2
  95%      2
  98%      2
  99%      2
 100%      6 (longest request)
```
