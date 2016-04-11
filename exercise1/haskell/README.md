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
Server Hostname:        127.0.0.1
Server Port:            8081

Document Path:          /counter
Document Length:        35 bytes

Concurrency Level:      10
Time taken for tests:   0.376 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      1430000 bytes
HTML transferred:       350000 bytes
Requests per second:    26575.25 [#/sec] (mean)
Time per request:       0.376 [ms] (mean)
Time per request:       0.038 [ms] (mean, across all concurrent requests)
Transfer rate:          3711.19 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     0    0   0.1      0       1
Waiting:        0    0   0.1      0       1
Total:          0    0   0.1      0       1

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      0
  95%      0
  98%      1
  99%      1
 100%      1 (longest request)
```

Results on my DELL 5450 i5 for the /file endpoint.

```
Server Software:        Warp/3.2.6
Server Hostname:        127.0.0.1
Server Port:            8081

Document Path:          /file
Document Length:        38 bytes

Concurrency Level:      10
Time taken for tests:   1.376 seconds
Complete requests:      10000
Failed requests:        27
   (Connect: 0, Receive: 0, Length: 27, Exceptions: 0)
Non-2xx responses:      27
Total transferred:      1460270 bytes
HTML transferred:       379514 bytes
Requests per second:    7270.00 [#/sec] (mean)
Time per request:       1.376 [ms] (mean)
Time per request:       0.138 [ms] (mean, across all concurrent requests)
Transfer rate:          1036.73 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     0    1   0.3      1       3
Waiting:        0    1   0.2      1       3
Total:          0    1   0.3      1       3

Percentage of the requests served within a certain time (ms)
  50%      1
  66%      1
  75%      2
  80%      2
  90%      2
  95%      2
  98%      2
  99%      2
 100%      3 (longest request)
```
