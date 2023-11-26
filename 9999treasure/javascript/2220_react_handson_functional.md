







## 関数型プログラミングハンズオン

関数型プログラミングの中心的な概念を紹介してきました。

次はこれらの概念を活用して、小さな JavaScript アプリケーションを構築してください。

JavaScript を使用すると、機能的パラダイムから抜け出すことができますが、ルールに従わなければならないので、集中し続ける必要があります。

この3つの簡単なルールにことに従うことは、目標を達成するための近道です。

1. データを不変に保ちます。

2. 関数を純粋に保つ — 少なくとも 1 つの引数を受け入れ、データまたは別の関数を返す
ション。

3. ループよりも再帰を使用します (可能な限り)。



## 課題


私たちの挑戦は時を刻む時計を作ることです。

- 時計は時間、分、秒と時刻から成り立ちます。

- 各フィールドは常に 2 桁でなければなりません。つまり、1 や 2 などの 1 桁の値には先行ゼロを適用する必要があります。

- また、表示を毎秒tickして変更する必要があります。


## 愚かな解決方法

通常のプログラミングでは以下のようなソースになるはずです。

```js
// Log Clock Time every Second
setInterval(logClockTime, 1000);
function logClockTime() {
    // Get Time string as civilian time
    var time = getClockTime();
    // Clear the Console and log the time
    console.clear();
    console.log(time);
}
function getClockTime() {
    // Get the Current Time
    var date = new Date();
    var time = "";

    // Serialize clock time
    var time = {
        hours: date.getHours(),
        minutes: date.getMinutes(),
        seconds: date.getSeconds(),
        ampm: "AM"
    }
    if (time.hours == 12) {
        time.ampm = "PM";
    } else if (time.hours > 12) {
        time.ampm = "PM";
        time.hours -= 12;
    }
    // Prepend a 0 on the hours to make double digits
    if (time.hours < 10) {
        time.hours = "0" + time.hours;
    }
    // prepend a 0 on the minutes to make double digits
    if (time.minutes < 10) {
        time.minutes = "0" + time.minutes;
    }
    // prepend a 0 on the seconds to make double digits
    if (time.seconds < 10) {
        time.seconds = "0" + time.seconds;
    }
    // Format the clock time as a string "hh:mm:ss tt"
    return time.hours + ":"
    + time.minutes + ":"
    + time.seconds + " "
    + time.ampm;
}
```

この解決策は非常に簡単です。

しかし、これらの機能は大規模で複雑です。

各関数は多くのことを行い、それらは理解するのが難しく、コメントが必要であり、保守するのは大変でしょう。



## 関数型を取り入れた解決方法


機能的アプローチがよりスケーラを生み出す方法を見てみましょう。

私たちの目標は、アプリケーション ロジックを小さな部分、つまり関数に分割することです。

各関数は単一のタスクに焦点を当て、それらをより大きな関数に構成します。

1. まず、値を与えてコンソールを管理するいくつかの関数を作成しましょう。

2. 1秒を返す関数、現在の時刻を返す関数が必要です。

3. コンソールにメッセージを記録し、コンソールをクリアするいくつかの関数。

関数型プログラムでは、可能な限り値よりも関数を使用する必要があります。

```js
const oneSecond = () => 1000
const getCurrentTime = () => new Date()
const clear = () => console.clear()
const log = message => console.log(message)
```


次に、データを変換するための関数が必要になります。

この 3 つの関数は、Date オブジェクトを時計に使用できるオブジェクトに変更するために使用されます。

- serializeClockTime

日付オブジェクトを受け取り、時間を含む時間のオブジェクトを返します

```js
const serializeClockTime = date =>
    ({
        hours: date.getHours(),
        minutes: date.getMinutes(),
        seconds: date.getSeconds()
    })
```

- civilianHours

時計の時刻オブジェクトを受け取り、時間を人間が読めるオブジェクトに変換します。

```js
const civilianHours = clockTime =>
    ({
        ...clockTime,
        hours: (clockTime.hours > 12) ?　clockTime.hours - 12 :clockTime.hours
    })
```

> 例: 1300 は 1 時になります

- appendAMPM

時刻オブジェクトを取得し、そのオブジェクトに AM または PM の時刻を追加します。

```js
const appendAMPM = clockTime =>
    ({
        ...clockTime,
        ampm: (clockTime.hours >= 12) ? "PM" : "AM"
    })
```


これら 3 つの関数は、元のデータを変更せずにデータを変換するために使用されます。



次に、いくつかの高階関数が必要になります:


- display

ターゲット関数を受け取り、ターゲットに時間を送信する関数を返します。
この例では、ターゲットは console.log になります。

```js
const display = target => time => target(time)
```

- formatClock

テンプレート文字列を受け取り、あるルールに基づいてフォーマットされた時刻を返します。

この例では、テンプレート文字列は「hh:mm:ss tt」です。

そこから、formatClock は、プレースホルダーを時、分、秒、および時刻に変更します。

```js
const formatClock = format =>
    time =>
    format.replace("hh", time.hours)
        .replace("mm", time.minutes)
        .replace("ss", time.seconds)
        .replace("tt", time.ampm)
```

- prependZero

オブジェクトのキーを引数として取り、格納された値の先頭にゼロを追加します。

```js
const prependZero = key => clockTime => ({
    ...clockTime,
    [key]: (clockTime[key] < 10) ?
    "0" + clockTime[key] :
    clockTime[key]
})
```

時を刻む時計を構築するために必要な関数がすべて揃ったので、次のものが必要です。


- convertToCivilianTime
クロック時間を引数として取り、それを次のように変換する単一の関数

```js
const convertToCivilianTime = clockTime =>
    compose(
        appendAMPM,
        civilianHours
    )(clockTime)
```

- doubleDigits

時間と分と秒は、必要に応じて先頭にゼロを追加して 2 桁で表示します。

```js
const doubleDigits = civilianTime =>
    compose(
        prependZero("hours"),
        prependZero("minutes"),
        prependZero("seconds")
    )(civilianTime)
```

- startTicking

毎秒コールバックを呼び出す間隔を設定してクロックを開始します。

コールバックは、次のすべての処理を行います。

コンソールは毎秒クリア、currentTime の取得、変換、自然言語化、フォーマット、および表示。

```js
const startTicking = () =>
    setInterval(
        compose(
            clear,
            getCurrentTime,
            serializeClockTime,
            convertToCivilianTime,
            doubleDigits,
            formatClock("hh:mm:ss tt"),
            display(log)
        ),
        oneSecond()
    )
startTicking()
```

このクロックの関数型バージョンは、命令バージョンと同じ結果を達成します。

ただし、このアプローチにはかなりの利点があります。

- まず、これらすべての機能は **簡単にテストして再利用できます。** それらは、将来の時計やその他のデジタル障害で使用できます。

- また、**このプログラムは簡単に拡張できます。** 副作用はありません。

この章では、関数型プログラミングの原則を紹介しました。


次の章では、原則の理解を深めて、公式に React に飛び込みます。










## 備考


title:Javascriptで関数型プログラミングハンズオン！

description:関数型プログラミングにはかなりの利点があります。まず、これらすべての機能は 簡単にテストして再利用できます。それらは、将来の時計やその他のデジタル障害で使用できます。また、このプログラムは簡単に拡張できます。そこに副作用はありません。


category_script:page_name.startswith("2")
