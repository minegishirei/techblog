

## プロシージゃの暗号化


前述のようにPL / SQLプログラムを作成すると、ソースコードがデータディクショナリにクリアテキストで表示され、DBAはそれを表示または変更することもできます。

営業秘密を保護したり、コードの改ざんを防止したりするために、PL / SQLソースコードを配信する前に難読化する方法が必要になる場合があります。


Oracleは、多くのCREATEステートメントをプレーンテキストと16進数の組み合わせに変換するwrapと呼ばれるコマンドラインユーティリティを提供しています。

これは真の暗号化ではありませんが、コードを隠すのに大いに役立ちます。ラップされたファイルからの抜粋を次に示します。

- 対象のコード


<pre><code>
CREATE OR REPLACE FUNCTION wordcount (str IN VARCHAR2)RETURN PLS_INTEGER　AS
    len PLS_INTEGER := NVL(LENGTH(str),0);
    inside_a_word BOOLEAN;
BEGIN
    FOR i IN 1..len + 1
    LOOP
        IF ASCII(SUBSTR(str, i, 1)) < 33 OR i > len　THEN
            IF inside_a_word
            THEN
                words := words + 1;
                inside_a_word := FALSE;
            END IF;
        ELSE
            inside_a_word := TRUE;
        END IF;
    END LOOP;
    return Words;
END;
/
</code></pre>




- サンプルコード

<pre><code>
FUNCTION wordcount wrapped

</code></pre>

- 実行結果

<pre><code>
0
abcd
abcd ...snip...
1WORDS:
10:
1LEN:
1NVL:
1LENGTH:
1INSIDE_A_WORD:
1BOOLEAN: ...snip...
a5 b 81 b0 a3 a0 1c 81
b0 91 51 a0 7e 51 a0 b4
2e 63 37 :4 a0 51 a5 b a5
b 7e 51 b4 2e :2 a0 7e b4 2e 52 10 :3 a0 7e 51 b4 2e d :2 a0 d b7 19 3c b7 :2 a0 d b7 :2 19 3c b7 a0 47 :2 a0
</code></pre>



## 注意

真の暗号化が必要な場合（たとえば、本当に安全である必要があるパスワードなどの情報を配信する場合）、この機能に依存しないでください



## 備考

title:プロシージゃの難読化【PLSQL基礎入門】

category:営業秘密を保護したり、コードの改ざんを防止したりするために、PL / SQLソースコードを配信する前に難読化する方法が必要になる場合があります。




img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")



