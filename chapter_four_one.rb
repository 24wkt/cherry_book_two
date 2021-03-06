#第4章 配列や繰り返し処理を理解する
#[4.1]イントロダクション
#配列は非常に利用頻度の高いオブジェクトです。また、ブロックも配列や繰り返し処理と切っても切れない関係にあるため、非常に重要です。
#その一方で、他の言語と比べるとRubyの配列や繰り返し処理は一風変わった部分があるかもしれません。
#他の言語経験に囚われず、Rubyらしい考え方やRubyらしいコードの書き方を身につけましょう。

#[4.1.1]この章の例題：RGBカラー変換プログラム
#今回はRubyカラーを変換するプログラムを作ってみましょう。
#RGBカラーとは1つの色を荒らすためにRed(赤)、Green(緑)、Blue(青)の3色を数値化したものです。
#「R=65,G=105,B=255」のように10進数の整数で表現されることもありますし、「#4169el」のように2桁の16進数を3つ並べた文字列で表現されることもあります。

#RGBカラー変換プログラムの仕様は次の通りです。
# ・10進数を16進数に変換する「to_hexメソッド」と16進数を10真数に変換する「to_intsメソッド」の2つを定義する。
# ・「to_hexメソッド」は3つの整数を受け取り、それぞれを16進数に変換した文字列を返す。文字列の先頭には”#”をつける。
# ・「to_intsメソッド」はRGBカラーを表す16進数文字列を受け取り、R、G、Bのそれぞれを10進数の整数に変換した値を配列として返す。

#[4.1.2]RGBカラー変換プログラムの実行例
#「to_hexメソッド」と「to_intsメソッド」の実行例を次に示します。

to_hex(0, 0, 0)             # ==> '#000000'
to_hex(255, 255, 255)       # ==> '#ffffff'
to_hex(4, 60, 120)          # ==> '#043c78'
to_ints('#000000')          # ==> [0, 0, 0]
to_ints('#ffffff')          # ==> [255, 255, 255]
to_ints('#043c78')          # ==> [4, 60, 120]

#[4.1.3]この章で学ぶこと
#この章では次のようなことを学びます。

# ・配色
# ・ブロック
# ・範囲(Range)
# ・さまざまな繰り返し処理
# ・繰り返し処理用の制御構造
