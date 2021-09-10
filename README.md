### Overview
Simple skeleton showing running arm64 version of aws-lambda-rie.
### Build and Deploy
In primary terminal, run:
``` sh
docker build -t myfunction:latest .
docker run -p 9000:8080 myfunction:latest
```
### Testing
In a second terminal, run:
``` sh
curl -i -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```
If everything went well you will get back a 'Hello World' message
