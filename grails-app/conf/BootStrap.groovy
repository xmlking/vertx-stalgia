import org.vertx.groovy.core.Vertx
import org.vertx.groovy.core.eventbus.EventBus

class BootStrap {

    def vertx = Vertx.newVertx()
    EventBus eb =  vertx.eventBus

    def init = { servletContext ->

        def httpServer = vertx.createHttpServer()
        vertx.createSockJSServer(httpServer).bridge(prefix: '/eventbus', [[:]], [[:]])
        httpServer.listen(8585)

//		long timerID0 = vertx.setPeriodic(2000) { timerID ->
//			eb.send("log", [ip: '127.0.0.1', time: 1371769989, method: 'GET', path: 'index.html', result: '200', size: '1024'])
//		}

        long timerID = vertx.setTimer(10000) { timerID ->
            println "starting log events..........."
            def ranDumb     = new Random();
            //127.0.0.1 - - [07/Mar/2012:23:21:47 +0100] "GET / HTTP/1.0" 200 454 "-" "ApacheBench/2.3"
            //def regex = ~/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).+\[(.+)\] "(\w+) ([^ ]+) .*" (\w+) (\w+)/;
            def regex = ~/^([^ ]*).+\[(.+)\] "(\w+) ([^ ]+) .*" (\w+) ([^ ]*)/

            while (true) {
                servletContext.getResourceAsStream("/WEB-INF/example.log").eachLine { line ->
                    def matcher = regex.matcher(line)
                    if (matcher.find()) {
                        eb.send("log", [ip: matcher.group(1), time: matcher.group(2), method: matcher.group(3), path: matcher.group(4), result: matcher.group(5), size: matcher.group(6)])
                    } else {
                        println "no match: " + line
                    }
                    sleep(ranDumb.nextInt(2000-1000+1)+100)
                    //sleep(ranDumb.nextInt(200-100+1)+100)
                    //sleep(ranDumb.nextInt(20-10+1)+50)
                }
                println "re-starting log events..........."
            }
        }
    }
    def destroy = {
        //vertx.cancelTimer(timerID0)
        vertx.cancelTimer(timerID)
    }
}
