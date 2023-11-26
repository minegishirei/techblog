


## backboneのmodelサンプルコード


バックボーンモデルには、アプリケーションのデータと、このデータに関連するロジックが含まれています。

たとえば、モデルを使用して、todoアイテムの概念を表すことができます。

todoデータには次の属性を含むとします。

- タイトル（todoコンテンツ）

- completed（todoの現在の状態）

次のようにBackbone.Modelを拡張することでモデルを作成できます。


<pre><code>
var Todo = Backbone.Model.extend({});
var todo1 = new Todo();
console.log(JSON.stringify(todo1));
// Following logs: {}

var todo2 = new Todo({
    title: 'Check the attributes of both model instances in the console.',
    completed: true
});
console.log(JSON.stringify(todo2));
// Following logs: {"title":"Check the attributes of both model
// instances in the console.","completed":true}

</code></pre>


## backbone.jsのInitialization

<pre><code>
var Todo = Backbone.Model.extend({
    initialize: function(){
        console.log('This model has been initialized.');
    }
});
var myTodo = new Todo();
// Logs: This model has been initialized
</code></pre>


## backbone.jsのdefault値

モデルに一連のデフォルト値を設定したい場合があります。

これらを使用してモデルのデフォルトと呼ばれるプロパティを設定することができます。

<pre><code>
var Todo = Backbone.Model.extend({
    // Default todo attribute values
    defaults: {
        title: '',
        completed: false
    }
});
var todo1 = new Todo();
console.log(JSON.stringify(todo1));

var todo2 = new Todo({
    title: 'Check attributes of the logged models in the console.'
});
console.log(JSON.stringify(todo2));

var todo3 = new Todo({
    title: 'This todo is done, so take no action on this one.',
    completed: true
});
console.log(JSON.stringify(todo3));
</code></pre>

## backbone.jsのGetterとSetter

getメソッドはアクセスを容易にするためのメソッドです。

<pre><code>
var Todo = Backbone.Model.extend({
    // Default todo attribute values
    defaults: {
        title: '',
        completed: false
    }
});

var todo1 = new Todo();
console.log(todo1.get('title')); 
// 出力：empty string
console.log(todo1.get('completed')); 
// 出力：false

var todo2 = new Todo({
    title: "Retrieved with model's get() method.",
    completed: true
});
console.log(todo2.get('title')); 
// 出力：Retrieved wit
console.log(todo2.get('completed')); 
// 出力：true
</code></pre>


## backbone.jsのtoJSONメソッド

モデルのすべてのデータ属性を読み取ったり複製したりする必要がある場合は、そのtoJSONメソッドを使用します。

このメソッドは、属性のコピーをJSONオブジェクトとして返します（JSON文字列ではありません）

JSの辞書型として返されます。

<pre><code>
var Todo = Backbone.Model.extend({
    // Default todo attribute values
    defaults: {
        itle: '',
        completed: false
    }
});

var todo1 = new Todo();
var todo1Attributes = todo1.toJSON();
console.log(todo1Attributes);
// 出力: {"title":"","completed":false}

var todo2 = new Todo({
 title: "Try these examples and check results in console.",
 completed: true
});
console.log(todo2.toJSON());
// 出力: {"title":"Try these examples and check results in console.",　"completed":true}

</code></pre>


## backbone.jsのset

Model.set()はモデルに1つ以上の属性を含むハッシュを設定します。

追加には二つの方法があります。

一つは辞書方形式でデータを設定する方法。
この方法では複数の値を設定できます。(No1)

もう一つはキーとバリューのペアを指定してデータを設定する方法。(No2)


<pre><code>
var Todo = Backbone.Model.extend({
    // Default todo attribute values
    defaults: {
    title: '',
    completed: false
    }
});
// Setting the value of attributes via instantiation
var myTodo = new Todo({
    title: "Set through instantiation."
});
// 追加前の状態確認
console.log('Todo title: ' + myTodo.get('title'));
// 出力結果：Todo title: Set through instantiation.
console.log('Completed: ' + myTodo.get('completed'));
// 出力結果：Completed: false

// 追加後の状態確認（No2の方法)
myTodo.set("title", "Title attribute set through Model.set().");
console.log('Todo title: ' + myTodo.get('title'));
// 出力結果：Todo title: Title attribute set through Model.set().
console.log('Completed: ' + myTodo.get('completed'));
// 出力結果：Completed: false

// 追加後の状態確認2（No1の方法）
myTodo.set({
    title: "Both attributes set through Model.set().",
    completed: true
});
console.log('Todo title: ' + myTodo.get('title'));
// Todo title: Both attributes set through Model.set().
console.log('Completed: ' + myTodo.get('completed'));
// Completed: true
</code></pre>



## データベースの変更を検知するon関数


以下の記述によってデータベースの変更を検知することができる

<code>
this.on('change', 関数名)
</code>

backboneモデルが変更されたときに通知を受け取りたい場合は、
変更イベントのモデルのリスナーを利用します。

リスナーを追加するのに便利な場所は次に示すように、initializeがおすすめです。


次の例では

<pre><code>
var Todo = Backbone.Model.extend({
    // Default todo attribute values
    defaults: {
        title: '',
        completed: false
    },
    initialize: function(){
        console.log('This model has been initialized.');
        // データベースの変更を検知するためのon関数
        this.on('change', function(){
            console.log('- Values for this model have changed.');
        });
    }
});
var myTodo = new Todo();

// 変更の検知を確認する実験1
myTodo.set('title', 'The listener is triggered whenever an attribute value changes.');
console.log('Title has changed: ' + myTodo.get('title'));
// ログの出力は以下の通り
// - Values for this model have changed.
// Title has changed: The listener is triggered when an attribute value changes.

// 変更の検知を確認する実験2
myTodo.set('completed', true);
console.log('Completed has changed: ' + myTodo.get('completed'));
// ログの出力は以下の通り
// - Values for this model have changed.
// Completed has changed: true

// 変更を検知を確認する実験3
myTodo.set({
    title: 'Changing more than one attribute at the same time only triggers the listener once.',
    completed: true
});
// - Values for this model have changed.
</code></pre>


## データの有効性を確かめる

バックボーンはmodel.validate（）によるモデル検証をサポートします。

これにより、モデルを設定する前にモデルの属性値を確認できます。

デフォルトでは

- モデルがsaveメソッドを介して永続化されるとき

- {validate：true}が引数として渡された場合にset（）が呼び出されるとき

の条件で検証が行われます。

<pre><code>
var Person = new Backbone.Model({name: 'Jeremy'});
// Validate the model name
Person.validate = function(attrs) { if (!attrs.name) {
return 'I need your name'; }
};
    // Change the name
Person.set({name: 'Samuel'}); console.log(Person.get('name')); // 'Samuel'
    // Remove the name attribute, force validation
Person.unset('name', {validate: true}); // false
</code></pre>

- 少し複雑な例

<pre><code>
var Todo = Backbone.Model.extend(
    { 
        defaults: {completed: false },
        //該当ソースは以下の部分
        validate: function(attribs){ 
            if(attribs.title === undefined){
                return "Remember to set a title for your todo."; 
            }
        },
        initialize: function(){
            console.log('This model has been initialized.'); 
            this.on("invalid", function(model, error){
                console.log(error);
            });
        } 
    });
    
var myTodo = new Todo();
myTodo.set('completed', true, {validate: true});
// ログの内容: Remember to set a title for your todo.

console.log('completed: ' + myTodo.get('completed')); 
// 出力結果：completed: false
</code></pre>




title:BackboneのModel基礎【モデル編】

description:バックボーンモデルには、アプリケーションのデータと、このデータに関連するロジックが含まれています。

img:http://lh4.googleusercontent.com/-vWEuTNpGLTE/VK3H2siMs_I/AAAAAAAAIu0/LNSy61X0aUE/s288/backbone.png

category_script:True
