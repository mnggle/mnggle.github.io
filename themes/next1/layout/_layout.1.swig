<!doctype html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.use_motion %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>
//   <style>
//     #s-canvas{
//       position: relative;
//       /*height: 336px;*/
//       display: inline-block;
//       margin: 0 auto;
//     }
// /*    #s-canvas canvas{
//       position: absolute;
//       top:0;
//       left: 50%;
//       margin-left: -500px;
//     }*/
    
//   </style>
   <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Montserrat">
 <!--  <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,600"> -->
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
</head>

<body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">

  {% include '_third-party/analytics/index.swig' %}

  {% set container_class = "container " %}
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}

  <div class="{{ container_class }} {% block page_class %}{% endblock %} ">
    <div class="headband"></div>

    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
<!--     <div id="s-canvas">
    </div> -->
      <div class="header-inner"> {%- include '_partials/s-header.swig' %} </div>
    </header>

    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap">
          <div id="content" class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_third-party/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>
        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
      </div>
    </main>

    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_third-party/analytics/busuanzi-counter.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <i class="fa fa-arrow-up"></i>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}

  </div>

  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}{% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_third-party/comments/index.swig' %}
  {% include '_third-party/search/index.swig' %}
  {% include '_third-party/analytics/lean-analytics.swig' %}
  {% include '_third-party/seo/baidu-push.swig' %}
  {% include '_third-party/mathjax.swig' %}
  {% include '_third-party/scroll-cookie.swig' %}
  {% include '_third-party/exturl.swig' %}
  // <script>
  //   "use strict";~
  //   let particles = [];
  //   let frequency = 20
  //   // Popolate particles
  //   setInterval(
  //     function(){
  //       popolate()
  //     }.bind(this),
  //     frequency
  //   )
  //   let c1 = createCanvas({width: $('.header-inner').width(), height: $('.header-inner').height()})
  //   let c2 = createCanvas({width: $('.header-inner').width(), height: $('.header-inner').height()})
  //   let c3 = createCanvas({width: $('.header-inner').width(), height: $('.header-inner').height()})

  //   let tela   = c1.canvas;
  //   let canvas = c1.context;

  //   // $("body").append(tela);
  //   $(".site-nav").before(c3.canvas);
  //   writeText(c2.canvas, c2.context, "SHUIZHENY\nGITHUB\nBLOG")


  //   class Particle{
  //     constructor(canvas, options){
  //       let random = Math.random()
  //       this.canvas = canvas;
  //       this.x = options.x
  //       this.y = options.y
  //       this.s = (3 + Math.random());
  //       this.a = 0
  //       this.w = $(window).width()
  //       this.h = 336
  //       this.radius = 0.5 + Math.random()*20
  //       this.color  = this.radius > 5 ? "#FF5E4C" : "#ED413C" //this.randomColor()
  //     }

  //     randomColor() {
  //       let colors = ["#FF5E4C", "#FFFFFF"];
  //       return colors[this.randomIntFromInterval(0,colors.length-1)];
  //     }

  //     randomIntFromInterval(min,max){
  //         return Math.floor(Math.random()*(max-min+1)+min);
  //     }

  //     render(){
  //       this.canvas.beginPath();
  //       this.canvas.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
  //       this.canvas.lineWidth = 2;
  //       this.canvas.fillStyle = this.color;
  //       this.canvas.fill();
  //       this.canvas.closePath();
  //     }

  //     move(){
  //       //this.swapColor()
  //       this.x += Math.cos(this.a) * this.s;
  //       this.y += Math.sin(this.a) * this.s;
  //       this.a += Math.random() * 0.8 - 0.4;

  //       if(this.x < 0 || this.x > this.w - this.radius){
  //         return false
  //       }

  //       if(this.y < 0 || this.y > this.h - this.radius){
  //         return false
  //       }
  //       this.render()
  //       return true
  //     }
  //   }

  //   function createCanvas(properties){
  //     let canvas = document.createElement('canvas');
  //         canvas.width = properties.width;
  //         canvas.height = properties.height;
  //     let context = canvas.getContext('2d');
  //     return {
  //       canvas: canvas,
  //       context: context
  //     }
  //   }

  //   function writeText(canvas, context, text){
  //     let size = 80
  //     context.font = size + "px Montserrat";
  //     context.fillStyle = "#111111";
  //     context.textAlign = "center";
  //     let lineheight = 60
  //     let lines = text.split('\n');
  //     for(let i = 0; i<lines.length; i++){
  //       context.fillText(lines[i], canvas.width/2, canvas.height/2 + lineheight*i - (lineheight*(lines.length-1))/3);
  //     }
  //   }

  //   function maskCanvas(){
  //     c3.context.drawImage(c2.canvas, 0, 0, c2.canvas.width, c2.canvas.height);
  //     c3.context.globalCompositeOperation = 'source-atop';
  //     c3.context.drawImage(c1.canvas, 0, 0);
  //     blur(c1.context,c1.canvas, 4)
  //   }

  //   function blur(ctx,canvas, amt) {
  //     ctx.filter = `blur(${amt}px)`
  //     ctx.drawImage(canvas, 0, 0)
  //     ctx.filter = 'none'
  //   }


  //   /*
  //    * Function to clear layer canvas
  //    * @num:number number of particles
  //    */
  //   function popolate(){
  //     particles.push(
  //       new Particle(canvas,{
  //         x: ($('.header-inner').width()/2.2),
  //         y: ($('.header-inner').height()/2)
  //       })
  //     )
  //     return particles.length
  //   }

  //   function clear(){
  //     canvas.globalAlpha=0.03;
  //     canvas.fillStyle='#111111';
  //     canvas.fillRect(0, 0, tela.width, tela.height);
  //     canvas.globalAlpha=1;
  //   }

  //   function update(){
  //     clear();
  //     particles = particles.filter(function(p) {
  //       return p.move()
  //     })
  //     maskCanvas()
  //     requestAnimationFrame(update.bind(this))
  //   }

  //   update()
  // </script>
</body>
</html>
