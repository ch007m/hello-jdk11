# hello-gateway


```bash
# Create project
oc new-project jdk11

# Relax security to allow to use user 1001
oc adm policy add-scc-to-group anyuid system:authenticated

# Grant View role to the service account default 
oc adm policy add-role-to-user view system:serviceaccount:jdk11:default

# Build push docker image
docker login -u `oc whoami` -p `oc whoami -t` 172.30.1.1:5000
docker build -t cmoulliard/jdk11 .
TAG_ID=$(docker images -q cmoulliard/jdk11)
docker tag $TAG_ID 172.30.1.1:5000/jdk11/my-jdk11
docker push 172.30.1.1:5000/jdk11/my-jdk11


# Use innerloop to install the component
oc apply -f component.yml

# Edit DC to use my-jdk11 and add a new command for supervisord
env:
  - name: JAVA_APP_DIR
    value: /deployment
  - name: JAVA_DEBUG
    value: 'false'
  - name: JAVA_DEBUG_PORT
    value: '5005'
  - name: JAVA_APP_JAR
    value: app.jar
  image: my-jdk11:latest
...
initContainers:
  - env:
      - name: CMDS
        value: >-
          run-jdk11:/opt/spring-boot/launch-springboot.sh;run-java:/usr/local/s2i/run;run-node:/usr/libexec/s2i/run;compile-java:/usr/local/s2i/assemble;build:/deployments/buildapp  
...
  from:
    kind: ImageStreamTag
    name: 'my-jdk11:latest'
    namespace: jdk11

# Push the jar and start JDK11
./push_start.sh
time="2018-12-06T09:29:36Z" level=debug msg="wait program exit" program=run-jdk11
2018-12-06 09:29:40.644  INFO 116 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'configurationPropertiesRebinderAutoConfiguration' of type [org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration$$EnhancerBySpringCGLIB$$a956fbee] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.0.RELEASE)
2018-12-06 09:29:41.195  INFO 116 --- [           main] c.g.t.h.HelloGatewayApplication          : The following profiles are active: kubernetes
2018-12-06 09:29:42.922  INFO 116 --- [           main] o.s.cloud.context.scope.GenericScope     : BeanFactory id=b42d34b2-d28b-3d40-a354-8471dc7e4cd7
2018-12-06 09:29:42.998  INFO 116 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration' of type [org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration$$EnhancerBySpringCGLIB$$a956fbee] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2018-12-06 09:29:43.145  WARN 116 --- [           main] reactor.netty.tcp.TcpResources           : [http] resources will use the default LoopResources: DefaultLoopResources {prefix=reactor-http, daemon=true, selectCount=4, workerCount=4}
2018-12-06 09:29:43.149  WARN 116 --- [           main] reactor.netty.tcp.TcpResources           : [http] resources will use the default ConnectionProvider: PooledConnectionProvider {name=http, poolFactory=reactor.netty.resources.ConnectionProvider$$Lambda$301/0x00000008403fcc40@6548bb7d}
2018-12-06 09:29:44.813  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [After]
2018-12-06 09:29:44.813  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Before]
2018-12-06 09:29:44.813  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Between]
2018-12-06 09:29:44.813  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Cookie]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Header]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Host]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Method]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Path]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Query]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [ReadBodyPredicateFactory]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [RemoteAddr]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [Weight]
2018-12-06 09:29:44.814  INFO 116 --- [           main] o.s.c.g.r.RouteDefinitionRouteLocator    : Loaded RoutePredicateFactory [CloudFoundryRouteService]
2018-12-06 09:29:45.435  INFO 116 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2018-12-06 09:29:46.439  INFO 116 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
2018-12-06 09:29:46.452  INFO 116 --- [           main] c.g.t.h.HelloGatewayApplication          : Started HelloGatewayApplication in 9.792 seconds (JVM running for 10.703)

# Create a route

# Query the endpoint
http http://hello-gateway-jdk11.192.168.99.50.nip.io/services
HTTP/1.1 200 OK
Cache-control: private
Content-Length: 17
Content-Type: application/json;charset=UTF-8
Set-Cookie: 053b048eccb26e4976f3164cced01aaf=da243252b6e7a99fe85906bddfa35f13; path=/; HttpOnly

[
    "hello-gateway"
]

```
