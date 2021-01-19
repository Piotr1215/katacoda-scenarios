Image can be changed using the set image command
`kubectl --record=true set image deployment examplehttpapp docker-http-server=katacoda/docker-http-server:v2`{{execute}}

`kubectl rollout status deployment examplehttpapp`{{execute}}
