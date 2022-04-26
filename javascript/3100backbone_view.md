

## ViewのHelloWorldについて

1. 定義部分

<pre><code>
var SongView = Backbone.View.extend({
    render: function(){
        this.$el.html("hello World")
        return this;
    }
})
</code></pre>

2. 使用部分

<pre><code>
var songView = new SongView({ el: "#container"});
songView.render();
</code></pre>

3. html部分

<code>
<div id="container"></div>
</code>

## 実行結果





