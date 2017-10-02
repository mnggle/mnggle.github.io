---
title: javascript原型链笔记
date: 2017-09-22 11:49:30
tags:
---
![](http://oq6xfel71.bkt.clouddn.com/17-10-3/50610144.jpg)
<center> <font size=4>只停留在会用的层面，这比纯理论来的更可怕</font></center >

最近在阅读underscore.js的源码，过程中，发现有必要好好学习一下javascript原型链的知识。参考了不少的博客，也翻阅了《javascript高级程序设计》。由于原型链这块确实有点绕，怕自己过段时间忘了，所以趁热打铁做一下总结。
<!-- more -->

本文从“对象”和“函数”切入：

##### 1. 一切（引用类型）都是对象，对象是属性的集合

这句话不用想太多，直接上例子。
```
	console.log(typeof x);// undefined
	console.log(typeof 10);   // number
	console.log(typeof 'abc'); // string
	console.log(typeof true);  // boolean
	
	console.log(typeof function () {});  //function
	
	console.log(typeof [1, 'a', true]);  //object
	console.log(typeof { a: 10, b: 20 });  //object
	console.log(typeof null);  //object
	console.log(typeof new Number(10));  //object'
```
可以看到数组，对象，null，以及用new Number()构造出来的内容使用 `typeof`操作符返回的值都是`Object`。放下基本类型不管，这里有一个特殊的返回值`function` ，那么问题来了，`function` 到底是啥呢，是不是对象呢。

##### 2.函数是一种对象
```
	var fn = function () { };
	console.log(fn instanceof Object);  // true
```
从上例可以看到，使用`instanceof`运算符 得到函数`fn`和`Object`之间存在关系。
借用MDN上对`instanceof`运算符的解释：
> instanceof 运算符用来测试一个对象在其原型链中是否存在一个构造函数的 prototype 属性。

可以进一步确定，函数`fn`是对象的一种形式。如果觉得这句话莫名其妙。那么记住下面这句话：
> 函数是一种对象，但是函数却不像数组一样——你可以说数组是对象的一种，因为数组就像是对象的一个子集一样。但是函数与对象之间，却不仅仅是一种包含和被包含的关系，函数和对象之间的关系比较复杂，甚至有一点鸡生蛋蛋生鸡的逻辑。

举个例子加强印象：
```
	var fn = function () { 
		alert('我是一个函数')	
	};
	fn.a = 10;
	fn.b = [1,2,3];
	fn.c = {
		name:'对象'，
		value:'函数下的对象'
	}
	fn.d = function(){
		alert('我是函数下的函数')
	}
```
上例中，函数`fn`就被当做对象被赋值了一些属性。`fn`是一个属性的集合。

##### 3.对象都是通过函数创建的
```
    var obj = new Object();
```

这种创建对象的方式肯定见过。包括数组也是如此。
```
	var arr = new Array();
```
其实可以通过 `typeof`操作符来说明问题。
```
	console.log(typeof (Object));  // function
	console.log(typeof (Array));  // function
```
可以看出`Object`和`Array`都是函数，而上面的对象`obj`和数组`arr`分别被这两个函数创建。

再来一个例子。
```
	function Person(){
		this.name = 'muggle',
		this.job = 'FE'
		this.age = 18
	}
	var person1 = new Fn();//{name: "muggle", job: "FE", age: 18}
```
##### 4.慢慢体会
总结一下2、3两点：函数是对象的一种，对象都是通过函数创建的。。。呃。。。什么鬼？

直接上图：

![](http://oq6xfel71.bkt.clouddn.com/17-9-22/3088097.jpg)

结合一下几句话：

1. 每个对象都有一个`__proto__`属性（隐式原型），指向创建该对象的函数的`prototype`
2. 每个函数都有一个属性叫做`prototype`。
3. `Object.prototype`确实一个特例——它的`__proto__`指向的是null
4. Function也是一个函数，函数是一种对象，也有`__proto__`属性。既然是函数，那么它一定是被`Function`创建。所以——`Function`是被自身创建的。所以它的`__proto__`指向了自身的`Prototype`
5. 调用构造函数创建实例会经历一下4个步骤：
	- 创建一个新对象
	- 将构造函数的作用域赋给新对象（因此this就指向了这个对象）
	- 执行构造函数中的代码（为这个新对象添加属性）
	- 返回新对象

接来下就可以顺着这张图的每一条线慢慢体会了。

原型链的知识还是挺多的，即使理解了一些原理，但是想要完全掌握它还是需要在接下来的工作学习中慢慢体会。很多原理性的东西要结合了实际才会有味道。毕竟我不是理论科学家，不想纯研究理论。我也不想当无脑码农，只停留在会用的层面，这比纯理论来的更可怕。

主要参考：

[http://www.cnblogs.com/wangfupeng1988/p/3977924.html](http://www.cnblogs.com/wangfupeng1988/p/3977924.html "深入理解javascript原型和闭包")
[https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Inheritance_and_the_prototype_chain](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Inheritance_and_the_prototype_chain "继承与原型链")