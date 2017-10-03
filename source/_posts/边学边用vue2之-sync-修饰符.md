---
title: vue2边学边用之“.sync ”修饰符
date: 2017-07-26 22:37:32
tags: 开发总结
categories: vue.js
---
![](http://oq6xfel71.bkt.clouddn.com/17-7-29/36373046.jpg)
<center> <font size=4>相比angularjs，vue的学习曲线真的是如丝一般润滑。</font></center >
<!-- more -->
由于公司需要将原来使用anuglar的项目改为使用vue，最近一直忙于对于vue的学习和使用，相比angularjs，vue的学习曲线真的是如丝一般润滑。故想在边学边用之余总结一些开发过程中遇到的问题和get到的点。这次分享的是 `.sync` 修饰符。

首先来一张官方文档的截图：

![](http://oq6xfel71.bkt.clouddn.com/17-7-26/8384530.jpg)

从上图的介绍中我们可以得知， `.sync` 修饰符是为了能让`prop`实现双向绑定，在开发过程中，由于组件的复用，很多时候确实需要从子组件中获取数据。而官方文档又规定`prop`是单项绑定的，即父组件属性发生变化，将传导给子组件，但是不会反过来。如demo所示:


```
		<!-- 父组件代码 -->
		<template>
			<div class="parent">
		  <child :testValue="testValue"></child>
		  <p>{{testValue}}</p>
			</div>
		</template>
		
		<script>
		import child from './child'
		export default {
		  data () {
		   return {
		    testValue: '来自父级的值'
		   }
		  },
		  computed: {},
		  methods: {},
		  created () {},
		  components: {
		    child
		  }
		}
		
		</script>
```


```	
		<!-- 子组件代码： -->
		<template>
			<div class="child">
		      <input type="text" name="" v-model="testValue">
			</div>
		</template>
	
		<script>
		export default {
		  props: {
		    testValue: String
		  },
		  data () {
		   return {}
		  },
		  computed: {},
		  methods: {},
		  created () {},
		  components: {}
		}

		</script>
```
![](http://oq6xfel71.bkt.clouddn.com/17-7-26/93780721.jpg)

按照上述写法，在input中输入值不仅无法实现双向数据绑定，在控制台也会报错：
![](http://oq6xfel71.bkt.clouddn.com/17-7-26/97334337.jpg)

这是由于vue不允许你直接改变`prop`的值，想要改变必须在父组件中加入`.sync`修饰符，并且当子组件想要更新`prop`时，需要显式地触发一个事件demo如下：

```
	<!-- 父组件代码 -->
	<template>
		<div class="parent">
	  <child :testValue.sync="testValue"></child>
	  <p>{{testValue}}</p>
		</div>
	</template>
	
	<script>
	import child from './child'
	export default {
	  data () {
	   return {
	    testValue: '来自父级的值'
	   }
	  },
	  computed: {},
	  methods: {},
	  created () {},
	  components: {
	    child
	  }
	}
	
	</script>
```
```
	<!-- 子组件代码 -->
	<template>
		<div class="child">
	      <input type="text" name="" :value="testValue" @input="changeTest">
		</div>
	</template>
	
	<script>
	export default {
	  props: {
	    testValue: String
	  },
	  data () {
	   return {}
	  },
	  computed: {},
	  methods: {
	    changeTest (event) {
	      this.$emit('update:testValue', event.target.value)// 显式触发一个更新事件
	    }
	  },
	  created () {},
	  components: {}
	}
	
	</script>
```
如此就将子组件的属性变化传递给了父组件。然而事情还没完。在原来的基础上将传递的值改为一个对象的时候：


```
	<!-- 父组件代码 -->
	<template>
		<div class="parent">
	  <child :testObj="testObj"></child>
	  <p>{{testObj.message}}</p>
		</div>
	</template>
```


```
	<!-- 子组件代码 -->
	<template>
		<div class="child">
	      <input type="text" name="" v-model="testObj.message">
		</div>
	</template>
```
![](http://oq6xfel71.bkt.clouddn.com/17-7-26/48945219.jpg)

父组件并没有使用`.sync`修饰符，子组件也没有显式地提交一个事件，但是改变输入框的内容，父组件也发生了变化。说好的单向绑定，单向数据流呢。
其实。。。在官方文档中有说明了：

![](http://oq6xfel71.bkt.clouddn.com/17-7-26/16448338.jpg)

尤大也在vue的	某个issue中说了
![](http://oq6xfel71.bkt.clouddn.com/17-7-26/89066167.jpg)

人家只是长得像而已，别误会了!基础原理的只是在开发过程中真的很重。。不然不是瞎猫碰上死耗子，就是瞎猫死在耗子手上。

引用类型可以参考这篇文章：
[http://www.qdfuns.com/notes/17660/7f82003c5ce92d39d19d6be0403f3f3b.html](http://www.qdfuns.com/notes/17660/7f82003c5ce92d39d19d6be0403f3f3b.html "js 基本类型与引用类型的区别（我觉得很棒的一篇文章）")