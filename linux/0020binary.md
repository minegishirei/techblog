


## コンピューターは1と0で動く...とは？

プログラミングをするとき、人間から見て半端な数字が多い。

- 8bit
- 16GB, 32GB
- 32bitcpu, 64bitcpu

 →切りのいい数字じゃダメなんか?

これらの数字はすべて2のn乗。



## 理論

### 素子のon/offがたくさんある。

データは何らかの物理デバイスのon/offの塊であらわされる。

- メモリ、SSD：素子内部の電荷
- HDD;磁性体の向き
- DVD:ディスクの溝の深さ

これらのデバイスに刻まれた指標をもとにon/offが決まる。

### 素子の数で表現できる数は変わる

そして、素子が多ければ多いほど、表現できる数は増える。

素子一つだけだと、表現できる状態は2つ

- off,onの二通。

素子二つになると、表現できる状態は4つ

- off-off, off-on, on-off, on-onの4通り。



## 実態

- `xxd`プログラムを使ってみる。
これは、ファイルの中身を2進数や16進数表記で見ることができる。

- `num`プログラムを使う

```go
package main

import (
    "os",
    "bytes",
    "encoding/binary"
)
func main(){
    buf := new(bytes.Buffer)
    var num uint8
    num = 0
    err := binary.Write(buf, binary.LittleEndian, num)
    if err != nil {
        panic("faild to write a number")
    }
    os.Stdout.Write(buf.Bytes())
}
```

```go
package main

import (
    "os",
    "bytes",
    "encoding/binary"
)

func main() {
    buf := new(bytes.Buffer)
    var num uint8
    num = 0
    err := binary.Write(buf, binary.LittleEndian, num)
    if err != nil {
        panic("faild to write a number")
    }
    os.Stdout.Write(buf.Bytes())
}
```


このプログラムはいかのリンクから写経したものです。

https://www.youtube.com/watch?v=8qg2b8ZZm_c






















































