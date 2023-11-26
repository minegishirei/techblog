




## React環境構築

reactで最も単純な環境構築は、**スクリプトタグを読み込むことです**

次のコードでは最もシンプルなReactの環境を構築します。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Pure React Samples</title>
    </head>
    <body>

        <!-- Target container -->
        <div class="react-container"></div>

        <!-- React library & ReactDOM-->
        <script src="https://unpkg.com/react@15.4.2/dist/react.js"></script>
        <script src="https://unpkg.com/react-dom@15.4.2/dist/react-dom.js"></script>
        <script>
        // Pure React and JavaScript code
        </script>
    </body>
</html>
```

これらは、ブラウザーで React を操作するための最小要件です。

JavaScriptソースは別のファイルに配置することができますが、ページのどこかにロードする必要があります。



## 備考

title:Reactのスクリプトタグで環境構築を行う

description:reactで最も単純な環境構築は、スクリプトタグを読み込むことです。次のコードでは最もシンプルなReactの環境を構築します。

category_script:page_name.startswith("2")