




## なぜキャッシュメモリが必要なのか?

コンプーターは以下の処理を繰り返している

- メモリからCPUのレジスタにデータを入れる
- レジスタ上で計算
- 計算結果をメモリに書き戻す

しかし、メモリのデータの操作はレジスタの計算に比べてはるかに遅い。
よって、メモリアクセスがボトルネックになりがち

- レジスタ上の計算：数ナノ秒オーダー
- メモリアクセス：100ナノ秒オーダー

これを、「キャッシュメモリ」を挟むことで解決している。




## amd-ryzenの具体例


https://www.amd.com/ja/products/apu/amd-ryzen-5-5600g



<figure class="figure-image figure-image-fotolife" title="cpuのl2 l3キャッシュ">[f:id:minegishirei:20230615170959p:plain:alt=]<figcaption>cpuのl2 l3キャッシュ</figcaption></figure>

CPUのコアの数（CPUコア数6）だけ、以下のスペックの情報が存在する。

- L2キャッシュ合計: 3MB
- L3キャッシュ合計: 16MB






