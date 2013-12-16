<%--
  Created by IntelliJ IDEA.
  User: schintha
  Date: 12/16/13
  Time: 11:05 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Cloud Management Platform: CMP Console</title>
    <meta name="author" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


    <style>
    html,
    body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    body {
        width: 100%;
        overflow: hidden;
        background: #000;
        display: -webkit-box;
        display: -moz-box;
        -webkit-box-orient: vertical;
        -moz-box-orient: vertical;
    }
    body header,
    body section,
    body footer {
        display: block;
        -webkit-box-flex: 1;
        -moz-box-flex: 1;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
    }
    </style>
</head>

<body>

<section id="canvasContainer">
    <canvas id="mainCanvas" data-speed="15" data-frame-rate="30" data-colorize="true" data-sumarize="true" data-time="true">
    </canvas>
</section>


<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js" ></script>
<script src="//cdn.sockjs.org/sockjs-0.3.4.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/vertx/2.0.0/vertxbus.min.js"></script>
<g:javascript src="reqscanvas.js" />
</body>
</html>