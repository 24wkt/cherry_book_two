#[5.1]イントロダクション
#配列と同様、ハッシュも使用頻度の高いオブジェクトです。本格的なRubyプログラミングを書く上では避けて通ることはできません。
#また、シンボルは少し変わったデータ型で、最初は文字列と混同してしまうかもしれませんが、こちらも使用頻度が高いデータ型なので、しっかり理解していきましょう。
#---------------------------------------------------------------------------------------------------------------------------------------------------------
#[5.1.1]この章の例題：長さの単位変換プログラム
#この章では長さの単位を変換するプログラムを作成します。このプログラムを通じてハッシュの使い方を学びます。
#長さの単位変換プログラムの仕様は次の通りです。

#・メートル(m)、フィート(ft)、インチ(in)の単位を交互に変換する。
#・第一引数に変換元の長さ（数値）、第二引数に変換元の単位、第三引数に変換後の単位を指定する。
#・メソッドの戻り値は変換後の長さ（数値）とする。端数が出る場合は少数第3位で四捨五入する。

#----------------------------------------------------------------------------------------------------------------------------------------------------------
#[5.1.2]長さの単位変換プログラムの実行例
# EX 実行例（初期バージョン）
  convert_length(1, 'm', 'in')
  # ==> 39.37
  convert_length(15, 'in', 'm')
  # ==> 0.38
  convert_length(35000, 'ft', 'm')
  # ==> 10670.73

#なお、上の実行例は初期バージョンで、実装したらそこから徐々に引数の指定方法を改善していきます。

#---------------------------------------------------------------------------------------------------------------------------------------------------------
#[5.1.3]この章で学ぶこと
# ・ハッシュ
# ・シンボル

#冒頭でも述べた通り、ハッシュもシンボルもRubyプログラムに頻繁に登場するデータ型です。
#この章の内容を理解して、ちゃんと使いこなせるようになりましょう。

#---------------------------------------------------------------------------------------------------------------------------------------------------------