# Assignment

You are going to write a simple webserver that remembers how many times an endpoint is called.

### Step 1
Create a simple webserver that responds to '/' by returning `hello world`. I.e.

```
$ curl http://localhost:5000/

hello world
```

### Step 2
Extend the webserver to respond to '/file1' by returning the contents of a json file `file1`. I.e

```
$ curl http://localhost:5000/file1

{
  "name": "file1",
  "count": 0
}
```

### Step 3
Extend the webserver to remember the number of times '/file1' has been called. The return value of the 
'/file1' should reflect the number of times '/file1' has been called. So when calling '/file1' for the 
30th time we should have:

```
$ curl http://localhost:5000/file1

{
  "name": "file1",
  "count": 30
}
```

