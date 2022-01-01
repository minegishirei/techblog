


## CREATE句

新しいオブジェクトを作成するための句です

※CREATE系を実行した後は直後にCOMMITが自動実行されます。

## CREATE TABLE文

表を作成するための句です

構文

<pre><code>
CREATE TABLE [スキーマ名].表名
(
    列名 データ型
    [,列名 データ型
     ,列名 データ型
     ...
    ]
)
</code></pre>

サンプルコード

<pre><code>
CREATE TABLE employees
(
    empno NUMBER(4),
    ename VARCHAR2(20)
)
</code></pre>


## DEFAULTオプション

表の作成時に列の定義にデフォルトオプションを追加できる。

INSERT文で値を省略した際にはこの時に設定した値が適応される。

構文

<pre><code>
CREATE TABLE [スキーマ名].表名
(
    列名 データ型 DEFAULT デフォルト値
    [,列名 データ型
     ,列名 データ型
     ...
    ]
)
</code></pre>

- サンプルコード

<pre><code>
CREATE TABLE employees
(
    empno NUMBER(4),
    ename VARCHAR2(20),
    hiredate DATE DEFAULT SYSDATE
)
</code></pre>

- INSERT時の挙動

<pre><code>
INSERT INTO emp2(empno, ename)
values (10, 'tarou');

SELECT * FROM emp2;
</code></pre>


## DEFAULTの値

リテラル値、式またはSQL関数を指定できる。(SYSDATE式やUSER式など)









title: CREATE

