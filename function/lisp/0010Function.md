
- [グローバル関数](#グローバル関数)
  - [1.  概要：](#1--概要)
  - [2. サンプルコード](#2-サンプルコード)
    - [引数をとらない場合](#引数をとらない場合)
    - [引数をとる場合](#引数をとる場合)
  - [3.命名規則：](#3命名規則)
  - [4. その他注意事項：](#4-その他注意事項)
- [ローカル関数](#ローカル関数)



## グローバル関数

### 1.  概要：

Lispでは、`defun`という特別な形式を使って関数を定義します。`defun`は、関数名、引数、本体といった要素を指定し、関数を定義するための特別なシンタックスです。

基本的な構文は次のようになります。


```lisp
(defun 関数名 (引数1 引数2 ...) 
   関数の本体)
```


### 2. サンプルコード

#### 引数をとらない場合

例えば、次のようなLispの関数を定義することができます。

```lisp
(defun hello-world () 
  (format t "Hello, world!"))
```

上記の例では、hello-worldという関数を定義しています。この関数は、引数を受け取らず、単に"Hello, world!"というテキストを出力するだけです。formatは、Lispの標準的な出力関数であり、tは標準出力を表します。

#### 引数をとる場合

以下の例では、`square`という関数を定義しています。引数として1つの数値を受け取り、その数値の2乗を返します。

```lisp
(defun square (x)
    (* x x))
```

*は掛け算を表すため、同じ値を二回掛けるこの関数は数字の二乗を返す。


### 3.命名規則：

Lispの関数名には、単語をつなげた「ケバブケース」（ハイフン区切り）がよく使われます。例えば、`my-function`や`calculate-sum`などです。

### 4. その他注意事項：

* Lispでは、関数の引数と本体の間に改行を入れるのが一般的です。
* `defun`にはオプションとして、関数についてのドキュメンテーション文字列を指定することができます。これは、関数の利用者が関数の使い方を理解するためのヒントとして役立ちます。
* Lispでは、関数は値を返す必要があります。関数の最後に評価された式が返り値となります。例えば、上記の`square`関数では、`(* x x)`が最後に評価され、その結果が返り値となります。


## ローカル関数

Lispの`flet`は、ローカルな関数定義を行うための特殊な構文です。以下は、fletを使用してローカル関数を定義する方法の例です。

```lisp
(flet ((local-function (arg1 arg2)
         (body)))
  (local-function value1 value2))
```

より具体的な


```lisp
(defun add-and-square (x y)
  (flet ((square (z) (* z z)))
    (let ((sum (+ x y)))
      (square sum))))
```


上記の例では、`add-and-square`という関数を定義しています。`flet`の中で`square`という名前のローカル関数を定義しています。`square`は引数`z`を受け取り、その2乗を返します。`add-and-square`は、`x`と`y`を受け取り、`flet`で定義した`square`を使用して、`x`と`y`の和を2乗した値を返します。



```lisp
(let ((x 3) (y 4))
  (let ((square (z) (* z z)))
    (let ((sum (+ x y)))
      (square sum))))
```

上記の式が評価されると、`sum`の値は`7`になります。`square`が`7`を受け取り、これを2乗して`49`を返します。したがって、`(add-and-square 3 4)`の結果は`49`になります。




