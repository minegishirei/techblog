
- [lispのlambda関数の使用方法](#lisp-lambda-------)
- [lambdaがしていること](#lambda-------)
- [lispでlambdaが大事なわけ](#lisp-lambda------)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## lispのlambda関数の使用方法

Lispのlambda関数は、匿名の関数を定義するために使用されます。これは、他の関数に引数として渡すことができます。

lambda関数は、次のように書式化されます。

```lisp
(lambda (arg1 arg2 ...) body)
```

ここで、arg1、arg2、...は、引数の名前を表し、bodyは、lambda関数が実行する処理を記述した式です。

たとえば、次のようなlambda関数を定義することができます。

```lisp
(lambda (x y) (+ x y))
```


これは、2つの引数xとyを受け取り、それらを加算して返すlambda関数です。この関数を呼び出すには、次のようにします。

```lisp
((lambda (x y) (+ x y)) 2 3)
```

この場合、引数xに2を、引数yに3を渡し、5が返されます。

また、lambda関数は、変数に割り当てることもできます。たとえば、次のように書くことができます。


```lisp
(setq add (lambda (x y) (+ x y)))
```

これにより、addという変数に、先程定義したlambda関数が割り当てられます。この関数を呼び出すには、次のようにします。


```lisp
(add 2 3)
```


これは、先程と同じく、2つの引数2と3を加算して5を返します。

## lambdaがしていること

これまで、関数を使用するためにはまず定義しなければならなかった。
たとえば、渡した数をはんぶんにして返す関数halfを作るとき、次のような書き方になるだろう。

```lisp
(defun half(n)
    (/ n 2))
```

そして、これらの関数をmapcarで実行するためには、次のように`#'`で関数を呼び出す。

```lisp
(mapcar #'half `(2 4 6))
```

lambdaはこれらの手順で必要だった**関数の定義と呼び出しを一度に行うことができる**

```lisp
(mapcar  (lambda (n)(/ n 2))  `(2 4 6) )
```


## lispでlambdaが大事なわけ

Lispの`lambda`は、ラムダ計算（ラムダアブストラクション）という数理論理学の分野に基づいています。ラムダ計算は、関数を抽象化する方法を提供する理論であり、数学的に扱うことができます。ラムダ計算において、関数は引数を取り、結果を返す形式で表されます。

Lispにおける`lambda`は、このラムダ計算の概念をプログラミングに応用したものです。具体的には、`lambda`は無名関数を作成するための構文であり、関数を定義するための方法の一つとなっています。

Lispの`lambda`が重要な理由は、以下のようなものが挙げられます。

1.  **高階関数を実現するための基盤となる**

Lispでは、関数が一級オブジェクトとして扱われます。つまり、関数を変数に代入したり、引数として渡したり、戻り値として返したりできます。このように関数を扱うことができることで、高階関数（関数を引数や戻り値として扱う関数）を実現することができます。`lambda`を使うことで、無名関数を定義して高階関数を実現することができます。

1.  **無名関数を定義できる**

`lambda`を使うことで、無名関数を定義することができます。無名関数を定義することで、一時的な関数を作成したり、関数を引数として渡すことができるようになります。また、無名関数は定義時に名前をつける必要がないため、コードの可読性を向上させることができます。

1.  **コードの簡潔化が可能**

`lambda`を使うことで、関数を定義するための煩雑な手続きを省略することができます。例えば、簡単な処理を行う関数を定義する場合、`lambda`を使って無名関数を作成することで、不要なコードを省略することができます。

以上のように、Lispの`lambda`は、高階関数の実現や無名関数の定義、コードの簡潔化など、様々な用途で活用されることができます




