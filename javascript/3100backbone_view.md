




## Viewの概要

<pre><code>
var TodoView = Backbone.View.extend(
    { 
        tagName: 'li',
        todoTpl: _.template( "An example template" ),
        events: {
            'dblclick label': 'edit',
            'keypress .edit': 'updateOnEnter',
            'blur .edit':   'close'
        },
        render: function() {
            //htmlの
            this.$el.html( this.todoTpl( this.model.toJSON() ) ); 
            this.input = this.$('.edit');
            return this;
        },
        edit: function() {
            //ダブルクリックしたときに実行される関数
        },
        close: function() {
            // フォーカスが外れた時に実行される関数
        },
        updateOnEnter: function( e ) {
            // エンターが押される時（更新された時）に実行される関数
        } 
    });
var todoView = new TodoView();
console.log(todoView.el); 
// liタグの表示
</code></pre>


## BackboneのViewでの属性値設定方法

以下のようにView.extendでの辞書を設定するときに属性を設定できる

<pre><code>
var TodosView = Backbone.View.extend({
    tagName: 'ul',
    className: 'container', 
    id: 'todos',
});

var todosView = new TodosView();
console.log(todosView.el);
</code></pre>

実行結果

```{.html}
// logs <ul id="todos" class="container"></ul>
```

## Backboneのrenderメソッドについて

render()メソッドはビューに関連付けられたモデルの属性のtoJSON関数にて
このテンプレートを使用します。

テンプレートは、モデルのタイトルと完了フラグを使用してそれらを含む式を評価した後、マークアップを返します。

次に、$elプロパティを使用して、このマークアップをelDOM要素のHTMLコンテンツとして設定します。

<pre><code>
var ListView = Backbone.View.extend(
    { 
        render: function(){
            this.$el.html(this.model.toJSON()); 
        }
    });
</code></pre>


## BackboneのViewのネストについて

ビューのネストは要素の階層を管理するための直感的なアプローチです。

ページはネストされた要素で構成され、バックボーンビューはページ内の要素に対応します。

<pre><code>
var ListView = Backbone.View.extend({
    initialize : function () {
        //...
    },
    render : function () {
        this.$el.empty();
        this.innerView1 = new Subview({options}); 
        this.innerView2 = new Subview({options});
        this.$('.inner-view-container')
            .append(this.innerView1.el)
            .append(this.innerView2.el);
    }
}
</code></pre>





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




## 備考

title:BackboneのViewの基礎【ビュー編】

description:バックボーンのViewには特別な関数がいくつか備えられています。今回はそのサンプルコードをいくつか紹介します。

img:http://lh4.googleusercontent.com/-vWEuTNpGLTE/VK3H2siMs_I/AAAAAAAAIu0/LNSy61X0aUE/s288/backbone.png

category_script:True
