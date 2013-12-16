<%--
  Created by IntelliJ IDEA.
  User: schintha
  Date: 12/16/13
  Time: 10:47 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js" ></script>
    <script src="//cdn.sockjs.org/sockjs-0.3.4.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/vertx/2.0.0/vertxbus.min.js"></script>
</head>
<style>
.box {
    background-color: #F0F0F0;
    border: 5px solid blue;
    width: 400px;
    height: 300px;
}

.innerbox {
    overflow: auto;
    border: 5px solid blue;
    border-left: 0px;
    border-right: 0px;
}

body {
    background-color: #F0F0F0;
}
</style>

<body>

<div id="send" class="box" style="position:absolute;left:0px;top:0px">

    <form onsubmit="return false;">
        Address:<input type="text" id="sendAddress" value="someaddress"/><br>
        Message:<input type="text" id="sendMessage" value="Hello, World!"/>
        <input type="button" id="sendButton" value="Send message"/>
    </form>

    <br>
    Sent messages:<br>

    <div id="sent" class="innerbox" style="width: 400px; height: 205px;">
    </div>
</div>

<div id="subscribe" class="box" style="position:absolute;left:450px;top:0px">

    <form onsubmit="return false;">
        Address:<input type="text" id="subscribeAddress" value="someaddress"/>
        <input type="button" id="subscribeButton" value="Subscribe"/>
    </form>

    <br>
    Subscriptions:<br>

    <div id="subscribed" class="innerbox" style="width: 400px; height: 230px;">
    </div>
</div>

<br>

<div id="receive" class="box" style="position:absolute;left:0px;top:350px">

    Received messages:<br>

    <div id="received" class="innerbox" style="width: 400px; height: 275px;">
    </div>

</div>

<div id="status" class="box" style="position:absolute;left:450px;top:350px">
    <input type="button" id="connectButton" value="Open connection"/><br>
    <input type="button" id="closeButton" value="Close connection"/><br>
    Connection Status:&nbsp;
    <div id="status_info">Not connected</div>
</div>

<script>

    var eb = null;

    function publish(address,  message) {
        if (eb) {
            var json = {text: message};
            eb.publish(address, json);
            $('#sent').append($("<code>").text("Address:" + address + " Message:" + message));
            $('#sent').append($("</code><br>"));
        }
    }

    function subscribe(address) {
        if (eb) {
            eb.registerHandler(address, function(msg, replyTo) {
                $('#received').append("Address:" + address + " Message:" + msg.text + "<br>");
            });
            $('#subscribed').append($("<code>").text("Address:" + address));
            $('#subscribed').append($("</code><br>"));
        }
    }

    function closeConn() {
        if (eb) {
            eb.close();
        }
    }

    function openConn() {
        if (!eb) {
            eb = new vertx.EventBus("http://localhost:8585/eventbus");

            eb.onopen = function() {
                $("#status_info").text("Connected");
            };

            eb.onclose = function() {
                $("#status_info").text("Not connected");
                eb = null;
            };
        }
    }

    $(document).ready(function() {
        $("#sendButton").click(function() {
            publish($("#sendAddress").val(), $("#sendMessage").val());
        });

        $("#subscribeButton").click(function() {
            subscribe($("#subscribeAddress").val());
        });

        $("#closeButton").click(function() {
            closeConn();
        });

        $("#connectButton").click(function() {
            openConn();
        });
    });

</script>

</body>
</html>