#[4.5]範囲(Range)
#Rubyには「1から5まで」「文字'a'から文字'e'まで」のように、値の範囲を表すオブジェクトがあります。
#これをオブジェクト範囲と言います。範囲オブジェクトは次のように「..」または「...」を使って作成します。

最初の値..最後の値(最後の値を含む)
最初の値...最後の値(最後の値を含まない)

# EX 具体例
  1..5
  1...5       # ==> 5は含まない
  'a'..'e'
  'a'...'e'   # ==> 5は含まない

#範囲オブジェクトはrangeクラスのオブジェクトです。
  puts (1..5).class   # ==> Range
  puts (1...5).class  # ==> Range

#「..」または「...」の違いは、最後の値を含めるか含めないかの違いになります。
# EX include?メソッドを使うと引数の値に含まれるかどうかを判定できるの、このメソッドを使って確認してみましょう！
  #..を使うと5が範囲に含まれている(1以上5以下)
  range = 1..5
  puts range.include?(0)    # ==> false(0は含まれない)
  puts range.include?(1)    # ==> true(1は含まれる)
  puts range.include?(4.9)  # ==> true(4.9は含まれる)
  puts range.include?(5)    # ==> true(5は含まれる＝最後の値)
  puts range.include?(6)    # ==> false(6は含まれない)

  #...を使うと5が範囲に含まれない(1以上5未満)
  range = 1...5
  puts range.include?(0)    # ==> false(0は含まれない)
  puts range.include?(1)    # ==> true(1は含まれる)
  puts range.include?(4.9)  # ==> true(4.9は含まれる)
  puts range.include?(5)    # ==> false(5は含まれない=最後の値)
  puts range.include?(6)    # ==> false(6は含まれない)

# ==> コードを見てもらえればわかる通り、「1..5」であれば5が範囲に含まれますが、「1...5」の場合は末尾の5が範囲に含まれません(4.99999999999999...........は含まれる)

#なお、範囲オブジェクトを変数に入れず、直接include?のようなメソッドを呼び出す時は範囲オブジェクトを()で囲む必要があるので注意！
# EX 
  #()で囲まずにメソッドを呼び出した場合
  puts 1..5.include?(1)   # ==> (NoMethodError) undefined method `include?' for 5:Integer
  #()で囲んだ場合
  puts (1..5).include?(1) # ==> true

# ==> これは「..」や「...」の優先順位が低いためです。（演算子の優先順位を参照）

#()で囲まなかった場合のコードは次のように解釈されたため、エラーが発生しました。
  1..(5.include?(1))

#範囲オブジェクトを標準でサポートするプログラミング言語はちょっと珍しいかもしれません。
#この説明だけではどういう時に使うのかイメージがわかないかもしれませんが、Rubyでは範囲オブジェクトを使うと便利な場所がよくあります。

#[4.5.1]配列や文字列の一部を抜き出す
#配列に対して添字の代わりに範囲オブジェクトを渡すと、指定した範囲の要素を取得することができます。

  a = [1, 2, 3, 4, 5]
  puts a[1..3]
  # ==> 2, 3, 4
  # ==> 2番目から4番目までの要素を取得する

#文字列に対しても同じような操作ができます。

  a = 'abcdef'
  puts a[1..3]
  # ==> b, c, d
  # ==> 2文字目から4文字目までを抜き出す

#[4.5.2]n以上m以下、n以上m未満の判定をする
#n以上m以下、n以上m未満の判定をしたい場合、<や>=のような記号(不等号)を使うよりも範囲オブジェクトを使った方がシンプルにかけます。

# EX 不等号を使う場合
  def liquid?(temperature)
    # 0度以上100度未満であれば液体、と判定したい
    0 <= temperature && temperature < 100
  end
  puts liquid?(-1)    # ==> false
  puts liquid?(0)     # ==> true
  puts liquid?(99)    # ==> true
  puts liquid?(100)   # ==> false

# EX 範囲オブジェクトを使う場合
  def liquid?(temperature)
    (0...100).include?(temperature)
  end
  puts liquid?(-1)    # ==> false
  puts liquid?(0)     # ==> true
  puts liquid?(99)    # ==> true
  puts liquid?(100)   # ==> false

#[4.5.3]case文で使う
#範囲オブジェクトはcase文と組み合わせることもできます。
# EX 年齢に応じて料金を判定するメソッド
  def charge(age)
    case age
    #0歳から5歳
    when 0..5
      0
    #6歳から12歳
    when 6..12
      300
    #13歳から18歳
    when 13..18
      600
    #それ以外の場合
    else
      1000
    end
  end
  puts charge(3)    # ==> 0
  puts charge(12)   # ==> 300
  puts charge(16)   # ==> 600
  puts charge(25)   # ==> 1000