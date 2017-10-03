<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?309a44f8a4f1ad5f2a7b3ae8bc7f70b4";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>

<div class="site-brand-wrapper">
  <div class="site-nav-toggle">
    <button>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
    </button>
  </div>
</div>
<div class="info">
  <h4><a href="#category">FRONT-END</a></h4>
  <h1>Welcome,<span id="greeting"></span></h1>
  <div class="meta">
    <a href="javascript:" target="_b" class="author"></a><br> By <a href="https://github.com/mnggle" target="_b">ShuiZhenyang</a> on May 20, 2017
  </div>
</div>
<script language="javaScript"> 
  var now = new Date(),hour = now.getHours() 
  var greeting = document.getElementById('greeting');
  if(hour < 12){greeting.innerHTML="Good Morning"} 
  else if (hour < 17){greeting.innerHTML="Good Afternoon"} 
  else if (hour < 22){greeting.innerHTML="Good Evening"} 
  else {greeting.innerHTML="Good Night"} 
</script>
<nav class="site-nav">
  {% set hasSearch = theme.swiftype_key || theme.algolia_search.enable || theme.tinysou_Key || theme.local_search.enable %}
  {% if theme.menu %}
    <ul id="menu" class="menu">
      {% for name, path in theme.menu %}
        {% set itemName = name.toLowerCase() %}
        <li class="menu-item menu-item-{{ itemName }}">
          <a href="{{ url_for(path) }}" rel="section">
            {{ __('menu.' + name) }}
          </a>
        </li>
      {% endfor %}

      {% if hasSearch %}
        <li class="menu-item menu-item-search">
          {% if theme.swiftype_key %}
            <a href="javascript:;" class="st-search-show-outputs">
          {% elseif theme.local_search.enable || theme.algolia_search.enable %}
            <a href="javascript:;" class="popup-trigger">
          {% endif %}
            {% if theme.menu_icons.enable %}
            {% endif %}
            {{ __('menu.search') }}
          </a>
        </li>
      {% endif %}
    </ul>
  {% endif %}

  {% if hasSearch %}
    <div class="site-search">
      {% include 'search.swig' %}
    </div>
  {% endif %}
</nav>