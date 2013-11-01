4)
a)Se guardan en: Gemfile.lock.
b)Se utiliza la version: Octokit 2.5.0.
c)Modificacion del ejercicio en Gemfile.lock:
GEM
  remote: https://rubygems.org/
  specs:
    addressable (2.3.5)
    faraday (0.8.8)
      multipart-post (~> 1.2.0)
    multipart-post (1.2.0)
    octokit (2.4.0)
      sawyer (~> 0.5.1)
    sawyer (0.5.1)
      addressable (~> 2.3.5)
      faraday (~> 0.8, < 0.10)

PLATFORMS
  ruby

DEPENDENCIES
  octokit

d)gem search -l octokit

*** LOCAL GEMS ***

octokit (2.5.0, 2.4.0)

e)

5)curl -v http://clima.info.unlp.edu.ar/last?lang=es
* About to connect() to clima.info.unlp.edu.ar port 80 (#0)
*   Trying 163.10.20.17...
* Connected to clima.info.unlp.edu.ar (163.10.20.17) port 80 (#0)
> GET /last?lang=es HTTP/1.1
> User-Agent: curl/7.29.0
> Host: clima.info.unlp.edu.ar
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.1.19
< Date: Fri, 25 Oct 2013 16:57:58 GMT
< Content-Type: text/html;charset=utf-8
< Content-Length: 126
< Connection: keep-alive
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< Access-Control-Allow-Origin: *
< 
* Connection #0 to host clima.info.unlp.edu.ar left intact
{"captured_at":"2013-10-25T16:50:00Z","temperature":14,"humidity":61,"dew":7,"bar":1022,"wind_speed":8,"wind_direction":"ESE"}

6)

API Key: 68b8a5834f7dfdb26455f26bd0a6c3b2
Secret: is b1e33a479ede96dae0066da4817a6658

7)
curl -v http://echo.httpkit.com/
* About to connect() to echo.httpkit.com port 80 (#0)
*   Trying 50.112.251.120...
* Connected to echo.httpkit.com (50.112.251.120) port 80 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: echo.httpkit.com
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.1.19
< Date: Fri, 25 Oct 2013 19:12:03 GMT
< Content-Type: application/json; charset=utf-8
< Content-Length: 359
< Connection: keep-alive
< X-Powered-By: http://httpkit.com
< Vary: Accept-Encoding
< 
{
  "method": "GET",
  "uri": "/",
  "path": {
    "name": "/",
    "query": "",
    "params": {}
  },
  "headers": {
    "x-forwarded-for": "181.166.9.44",
    "host": "echo.httpkit.com",
    "user-agent": "curl/7.29.0",
    "accept": "*/*"
  },
  "body": null,
  "ip": "127.0.0.1",
  "powered-by": "http://httpkit.com",
  "docs": "http://httpkit.com/echo"
* Connection #0 to host echo.httpkit.com left intact
}


curl --data "nombre=Facu&apellido=Osti" http://echo.httpkit.com/
{
  "method": "POST",
  "uri": "/",
  "path": {
    "name": "/",
    "query": "",
    "params": {}
  },
  "headers": {
    "x-forwarded-for": "181.166.9.44",
    "host": "echo.httpkit.com",
    "user-agent": "curl/7.29.0",
    "accept": "*/*",
    "content-length": "25",
    "content-type": "application/x-www-form-urlencoded"
  },
  "body": "nombre=Facu&apellido=Osti",
  "ip": "127.0.0.1",
  "powered-by": "http://httpkit.com",
  "docs": "http://httpkit.com/echo"
}
