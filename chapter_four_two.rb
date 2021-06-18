#[4.2]配列
#配列とは複数のデータをまとめて格納できるオブジェクトのことです。
#配列内のデータ(要素)は順番に並んでいて、添字(インデックス)を指定することでそのデータを取り出すことができます。
#配列は次のように[]を使って作成します(配列リテラル)

# EX 空の配列を作る
  []

# EX 3つの要素が格納された配列を作る
  [要素1, 要素2, 要素3]

#配列はArrayクラスのオブジェクトになっています。
#「Arrayクラス」とは配列オブジェクトの元になっているクラスのことです。

# EX からの配列を作成してそのクラス名を確認する
  puts [].class   # ==> Array

# EX 数値の１、２、３が格納された配列を変数aに代入するコード
# ==> 下記のように２通りの書き方ができる。
  a = [1, 2, 3]

  a = [
        1,
        2,
        3
  ]


#配列は数値に限らず、どんなオブジェクトでも格納できます。
# EX 文字列を格納する。
  a = ['apple', 'orange', 'melon']

#また、異なるデータ型を格納することもできます。
# EX 数値と文字列を混在させた配列を格納する
  a = ['apple', 1, 'orange', 2, 'melon', 3]

#配列に配列を含めることもできます。
# EX
  a = [[10, 20, 30], [40, 50, 60], [70,80,90]]

#配列の各要素を取得する場合は、[]添字(数値)を使います。最初の添字は０です。

  a = [1, 2, 3]
  #1つ目の要素の取得
  puts a[0]   # ==> 1
  #2つ目の要素の取得
  puts a[1]   # ==> 2
  #3つ目の要素の取得
  puts a[2]   # ==> 3

#存在しない要素を指定してもエラーにはならず、nilが返ります。

  a = [1, 2, 3]
  puts a[100]    # ==> nil

#sizeメソッド(エイリアスメソッドはlength)を使うと配列の長さ(要素の個数)を取得できます。

  a = [1, 2, 3]
  puts a.size     # ==> 3
  puts a.length   # ==> 3