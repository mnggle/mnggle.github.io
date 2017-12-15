---
title: webRTC多人视频解决方案
date: 2017-12-15 15:40:47
tags:
---
![](http://oq6xfel71.bkt.clouddn.com/17-12-15/50659383.jpg)
<center> <font size=4>你的浏览器很厉害</font></center >
本文的重点是“多人视频解决方案”，所以这里不对webRTC做过多的解释，[官网](https://webrtc.org/ "webRTC")有详细的介绍以及教程。简单的说webRTC（Web Real-Time Communication）它提供了一系列的API，只要通过浏览器就能实现p2p的视频通话，聊天，文件传输等。
<!-- more -->

在研究利用webRTC实现多人视频的时候，网上没有比较完整的方案或者demo。而且和webRTC相关的很多文档都是英文文档，MDN上很多内容也都是未翻译状态，看起来相对比较吃力，但是既然研究了，我也不想轻易放弃。最终功夫不负有心人，最后琢磨出一个相对可行的方案。有兴趣的同学可以看我自己做的demo的gihub地址[https://github.com/mnggle/webrtc-multi](https://github.com/mnggle/webrtc-multi)，主要内容在branch分支上还没有合并。项目还不完整，代码也有点乱，只是提供一个参考，不过我会一直维护这项目。下面简单介绍一下原理吧。

本次我使用的信令服务器是node+socket.io，由于只是本地调试，所以没有搭建stun/turn服务器。

## 1、每一个连接都有一个RTCPeerConnection对象。 ##
RTCPeerConnection接口代表一个由本地计算机到远端的WebRTC连接。该接口提供了创建，保持，监控，关闭连接的方法的实现。说白了就是端与端之间连接的通道。如果是一对一的视频通讯，那么这个就比较容易实现，官方也有比较好的demo。但是多人的时候就会复杂许多，我的方法是将每一次的端对端连接都建立一个RTCPeerConnection，然后将这个RTCPeerConnection放入一个对象obj中。该对象的key为socket.io提供的，每个终端独有的socket id。value就是RTCPeerConnection。这样就可以通过`obj[socket.id]`区分当前连接的终端为哪个。

## 后加入者createOffer ##
在建立连接前涉及到creatOffer和createAnwser问题。关于这两者的用途，官方文档有解释。拿一对一视频来说，A如果想要和B实现视频通话，那么A需要发送一个createOffer给B，B接收到以后需要发送一个createAnwser回复给A，实现的逻辑比较清晰。但是，如果将人数增加到3个人,甚至更多，两两之间都要完成一次createOffer和createAnwser，并且连接的两端各自只能发送createOffer或发送createAnwser。这样一来问题就会变得相对复杂。我的方法是规定，后加入方发送createOffer。即：如果房间内有一个A，B两人，如果C想加入，那么C需要发送createOffer给房间内的其他成员，即这里的A和B，然后A和B接收到C的createOffer后会各自回复对应的createAnwser，以此类推。不过这方法涉及到并发的问题，需要后期解决。不过webRTC多人视频理论上没有连接个数的限制，但是建议保持在4-8个人为好。

以上就是利用webRTC实现多人视频聊天的方案。只是一个粗略的介绍。很多地方可能考虑的不周，希望多多指正，我也能从你们的指正中慢慢完善这个项目。今后我会继续分享webRTC相关的研究成果，这篇文章可以算是一个开始吧。
