

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/json2/0.1/json2.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/backbone-localstorage.js/1.1.0/backbone.localStorage-min.js"></script>


## サンプルアプリ

TODOリストアプリ

<div class="taskApp">
    <h1>TODO</h1>
    <form class="addTask">
        <input type="text" class="title" placeholder="タスクを入力してください">
        <span class="error"></span>
    </form>
    <ul class="taskList"></ul>
    <button class="clear">全て削除</button>
</div>
<script type="text/template" id="temp-taskItem">
    <input type="checkbox" class="toggle" <%= closed ? 'checked' : '' %> >
    <span class="title"><%-title%></span>
    <a class="del" href="#">x</a>
</script>



## サンプルコード

### html

<pre><code>
<div class="taskApp">
    <h1>TODO</h1>
    <form class="addTask">
        <input type="text" class="title" placeholder="タスクを入力してください">
        <span class="error"></span>
    </form>
    <ul class="taskList"></ul>
    <button class="clear">全て削除</button>
</div>
<script type="text/template" id="temp-taskItem">
    <input type="checkbox" class="toggle" <%= closed ? 'checked' : '' %> >
    <span class="title"><%-title%></span>
    <a class="del" href="#">x</a>
</script>
</code></pre>

### css

<pre><code>
<style>
    .taskApp input.title{
    padding:8px;
    border-radius: 4px;
    width:20em;
    border: solid 1px #ccc;
}
.taskApp ul.taskList{
    padding-left: 0;
}
.taskApp ul.taskList li{
    list-style:none;
}
.taskApp li.closed .title{
    color: gray;
    text-decoration: line-through;
}
.taskApp .del{
    color: #ff5577;
    text-decoration: none;
    font-weight: bold;
}
.taskApp .error{
    color: red;
}
</style>
</code></pre>


### script


<pre><code>

<script>
    //モデル
var Task = Backbone.Model.extend({
    defaults: {
        title: '',
        closed: false
    },
    validate: function(attrs){
        if(_.isEmpty(attrs.title)){
            return 'タスク名が指定されてません';
        }
    }
});
//コレクション
var Tasks = Backbone.Collection.extend({
    model: Task,
    localStorage: new Store('task-app')
});
// ビュー（リストアイテム部分）
var TaskView = Backbone.View.extend({
    tagName: 'li',
    events: {
        'click .toggle': 'toggleTask',
        'click .del': 'delTask'
    },
    initialize: function(){
        this.model.on('destroy', this.remove, this);
        this.model.on('change', this.render, this); // (1)
    },
    template: _.template($('#temp-taskItem').html()), // (2)
    render: function(){
        var html = this.template(this.model.toJSON());
        this.$el.html(html)[
            this.model.get('closed') ? 'addClass' : 'removeClass'
        ]('closed');
        return this;
    },
    toggleTask : function(){
        this.model.set('closed', !this.model.get('closed')).save();
    },
    delTask : function(e){
        e.preventDefault();
        if(confirm('削除しますか？')){
            this.model.destroy();
        }
    }
});
// ビュー（画面全体）
var TaskApp = Backbone.View.extend({
    events: {
        'submit .addTask': 'addTask',
        'click .clear': 'clearTask'
    },
    initialize: function(){
        var o = this;
        o.$title = o.$el.find('input.title')
        o.$list = o.$el.find('ul.taskList');
        o.$error = o.$el.find('.error');
        o.collection.on('add', function(task){
            var taskView = new TaskView({model: task});
            o.$list.prepend(taskView.render().el)
        })
        o.collection.fetch();
        o.collection.on("invalid", function(task, error) { // (3)
            o.$error.text(error);
        });
    },
    addTask : function(e){
        var o = this;
        e.preventDefault();
        var sts = o.collection.create(
            {title: o.$title.val()},
            {validate: true}
        );
        if(sts){
            o.$title.val('')
            o.$error.text('');
        }
    },
    clearTask : function(){
        var o = this;
        if(confirm('全て削除してよろしいですか？')){
            o.collection.each(function(task){
                o.collection.first().destroy();
            });
        }
    }
});
var taskApp = new TaskApp({
    el: $('div.taskApp'),
    collection: new Tasks()
});
</script>
</code></pre>


## 備考

title: Backbone jsを理解するためのサンプルコード











<style>
    .taskApp input.title{
    padding:8px;
    border-radius: 4px;
    width:20em;
    border: solid 1px #ccc;
}
.taskApp ul.taskList{
    padding-left: 0;
}
.taskApp ul.taskList li{
    list-style:none;
}
.taskApp li.closed .title{
    color: gray;
    text-decoration: line-through;
}
.taskApp .del{
    color: #ff5577;
    text-decoration: none;
    font-weight: bold;
}
.taskApp .error{
    color: red;
}
</style>

<script>
    //モデル
var Task = Backbone.Model.extend({
    defaults: {
        title: '',
        closed: false
    },
    validate: function(attrs){
        if(_.isEmpty(attrs.title)){
            return 'タスク名が指定されてません';
        }
    }
});
//コレクション
var Tasks = Backbone.Collection.extend({
    model: Task,
    localStorage: new Store('task-app')
});
// ビュー（リストアイテム部分）
var TaskView = Backbone.View.extend({
    tagName: 'li',
    events: {
        'click .toggle': 'toggleTask',
        'click .del': 'delTask'
    },
    initialize: function(){
        this.model.on('destroy', this.remove, this);
        this.model.on('change', this.render, this); // (1)
    },
    template: _.template($('#temp-taskItem').html()), // (2)
    render: function(){
        var html = this.template(this.model.toJSON());
        this.$el.html(html)[
            this.model.get('closed') ? 'addClass' : 'removeClass'
        ]('closed');
        return this;
    },
    toggleTask : function(){
        this.model.set('closed', !this.model.get('closed')).save();
    },
    delTask : function(e){
        e.preventDefault();
        if(confirm('削除しますか？')){
            this.model.destroy();
        }
    }
});
// ビュー（画面全体）
var TaskApp = Backbone.View.extend({
    events: {
        'submit .addTask': 'addTask',
        'click .clear': 'clearTask'
    },
    initialize: function(){
        var o = this;
        o.$title = o.$el.find('input.title')
        o.$list = o.$el.find('ul.taskList');
        o.$error = o.$el.find('.error');
        o.collection.on('add', function(task){
            var taskView = new TaskView({model: task});
            o.$list.prepend(taskView.render().el)
        })
        o.collection.fetch();
        o.collection.on("invalid", function(task, error) { // (3)
            o.$error.text(error);
        });
    },
    addTask : function(e){
        var o = this;
        e.preventDefault();
        var sts = o.collection.create(
            {title: o.$title.val()},
            {validate: true}
        );
        if(sts){
            o.$title.val('')
            o.$error.text('');
        }
    },
    clearTask : function(){
        var o = this;
        if(confirm('全て削除してよろしいですか？')){
            o.collection.each(function(task){
                o.collection.first().destroy();
            });
        }
    }
});
var taskApp = new TaskApp({
    el: $('div.taskApp'),
    collection: new Tasks()
});
</script>

