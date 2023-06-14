


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

これらのon/offが1,0に対応し、その理論に基づいて2進法がコンピューターで利用されている。

## ascii code

    Dec Hex Sym    Dec Hex Char  Dec Hex Char  Dec Hex Char
    -----------    ------------  ------------  ------------
    0   0  NUL     32  20        64  40  @     96  60  `
    1   1  SOH     33  21  !     65  41  A     97  61  a
    2   2  STX     34  22  "     66  42  B     98  62  b
    3   3  ETX     35  23  #     67  43  C     99  63  c
    4   4  EOT     36  24  $     68  44  D    100  64  d
    5   5  ENQ     37  25  %     69  45  E    101  65  e
    6   6  ACK     38  26  &     70  46  F    102  66  f
    7   7  BEL     39  27  '     71  47  G    103  67  g
    8   8   BS     40  28  (     72  48  H    104  68  h
    9   9  TAB     41  29  )     73  49  I    105  69  i
    10   A   LF     42  2A  *     74  4A  J    106  6A  j
    11   B   VT     43  2B  +     75  4B  K    107  6B  k
    12   C   FF     44  2C  ,     76  4C  L    108  6C  l
    13   D   CR     45  2D  -     77  4D  M    109  6D  m
    14   E   SO     46  2E  .     78  4E  N    110  6E  n
    15   F   SI     47  2F  /     79  4F  O    111  6F  o
    16  10  DLE     48  30  0     80  50  P    112  70  p
    17  11  DC1     49  31  1     81  51  Q    113  71  q
    18  12  DC2     50  32  2     82  52  R    114  72  r
    19  13  DC3     51  33  3     83  53  S    115  73  s
    20  14  DC4     52  34  4     84  54  T    116  74  t
    21  15  NAK     53  35  5     85  55  U    117  75  u
    22  16  SYN     54  36  6     86  56  V    118  76  v
    23  17  ETB     55  37  7     87  57  W    119  77  w
    24  18  CAN     56  38  8     88  58  X    120  78  x
    25  19   EM     57  39  9     89  59  Y    121  79  y
    26  1A  SUB     58  3A  :     90  5A  Z    122  7A  z
    27  1B  ESC     59  3B  ;     91  5B  [    123  7B  {
    28  1C   FS     60  3C  <     92  5C  \    124  7C  |
    29  1D   GS     61  3D  =     93  5D  ]    125  7D  }
    30  1E   RS     62  3E  >     94  5E  ^    126  7E  ~
    31  1F   US     63  3F  ?     95  5F  _    127  7F 


    Name   Char  Dec   Hex  Description           
    NUL     ^@   00    00   null
    SOH     ^A   01    01   start of heading
    STX     ^B   02    02   start of text
    ETX     ^C   03    03   end of text
    EOT     ^D   04    04   end of transmission
    ENQ     ^E   05    05   enquiry
    ACK     ^F   06    06   acknowledge
    BEL     ^G   07    07   bell
    BS      ^H   08    08   backspace
    TAB     ^I   09    09   horizontal tab
    LF, NL  ^J   10    0A   line feed, new line
    VT      ^K   11    0B   vertical tab
    FF, NP  ^L   12    0C   form feed, new page
    CR      ^M   13    0D   carriage return
    SO      ^N   14    0E   shift out
    SI      ^O   15    0F   shift in
    DLE     ^P   16    10   data link escape
    DC1     ^Q   17    11   device control 1
    DC2     ^R   18    12   device control 2
    DC3     ^S   19    13   device control 3
    DC4     ^T   20    14   device control 4
    NAK     ^U   21    15   negative acknowledge
    SYN     ^V   22    16   synchronous idle
    ETB     ^W   23    17   end of trans. block
    CAN     ^X   24    18   cancel
    EM      ^Y   25    19   end of medium
    SUB     ^Z   26    1A   substitute
    ESC     ^[   27    1B   escape
    FS      ^\   28    1C   file separator
    GS      ^]   29    1D   group separator
    RS      ^^   30    1E   record separator
    US      ^_   31    1F   unit separator
    SPACE        32    20   space
    DEL          127   7F   delete
</pre>
https://www.ieee.li/computer/ascii.htm



## 実態


### 数字をバイナリ形式で見てみる

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


このコードをbuild & 実行し、出力結果を`data`というファイルに格納する。

```sh
go build num.go
./num > data
```

`data`ファイルを`xxd`コマンドで確認する。
xxdの-bオプションはファイルの中身をbinary形式で見ることができる。

```sh
xxd -b data
```

サンプル実行結果

> 00000000: 00


### 文字列を`xxd`コマンドで見てみる

まずは`data`に`a`が入力されているかどうかを確認する。

```sh
echo a > data
cat data
```

次に、`xxd`コマンドで文字列データをバイナリ形式で見てみる

```sh
xxd data
```

> 00000000: 610a

これをascii表で確認してみます。
すると、`61`は16進数で`a`に対応し、意図した文字がバイナリとして保存されていることが分かりました。

    Dec Hex Char
    97  61  a

また、`0a`が16進数でどれに該当するか確認してみると、改行コードであることが分かると思います。















































