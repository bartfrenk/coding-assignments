# Solution in Haskell

To install dependencies

	cabal install servant
	cabal install servant-server
	cabal install wai
	cabal install strict


To build the example

	ghc assignment.hs

To run the example

	./assignment

To stress test the example

	ab -n 10000 -c 10 http://127.0.0.1:8081/count

## Notes

The solution drops requests when multiple access to the count file occur. So
after running the stress test and then curling `curl http://127.0.0.1:8081/count`,
instead of 10001 as count you get a lower number due to the dropped requests.

## Results

On my MBP

```
Server Software:        Warp/3.2.6
Server Hostname:        127.0.0.1
Server Port:            8081

Document Path:          /count
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
