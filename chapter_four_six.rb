#[4.6]例題：RGB変換プログラムを作成する
#RGB変換プログラムの仕様を確認する。
#　・10進数を16進数に変換するto_hexメソッドと16進数を10進数に変換するto_intsメソッドの2つを定義する。
#　・to_hexメソッドは3つの整数を受け取り、それぞれ16進数に変換した文字列を返す。文字列の先頭には"#"をつける。
#　・to_intsメソッドはRGBカラーを表す16進数文字列を受け取り、R、G、Bのそれぞれを10進数の整数に変換した値を配列として返す。

# EX 実行例

  puts to_hex(0, 0, 0)            # ==> '#000000'
  puts to_hex(255, 255, 255)      # ==> '#ffffff'
  puts to_hex(4, 60, 120)         # ==> '#043c78'
  puts to_ints('#000000')         # ==> [0, 0, 0]
  puts to_ints('#ffffff')         # ==> [255, 255, 255]
  puts to_ints('#043c78')         # ==> [4, 60, 120]

#[4.6.1]to_hexメソッドを作成する
#今回はto_hexメソッドのテストコードから作成していきます。いわゆる「テスト駆動開発(TDD、Test driven development)」というやつ。
#「プログラムのインプットとアウトプットが明確である」「テストコードの書き方が最初からイメージできる」という2つの条件が揃っている場合はTDDが向いています。

#今回のテストコード
# ==> 「rgb_test.rb」に別途作成済み

require 'minitest/autorun'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
  end
end

# EX このままテストファイルを実行する

1) Error:
RgbTest#test_to_hex:
NoMethodError: undefined method 'to_hex' for #<RgbTest:0x00007fe82e8e1570>
    rgb_test.rb:5:in test_to_hex

1 runs, 0 assertions, 0 failures, 1 errors, 0 skips

# ==> 案の定、テストは失敗しました。NoMethodErrorなので、「to_hex」が見つからない、定義されていないと言われています。

#それからrgb.rbを作成して下記内容を記述する。(別途作成済み)

def to_hex(r, g, b)
    '#000000'
  end

#ここではあえてロジックらしいロジックを書かずに、あえて'#000000'という固定の文字列を返しています。
#これはまず、テストコードがちゃんと機能しているか、とういうことをチェックするためです。

#テストファイルに今回作成したrgb.rbをテストコードに読み込ませます。

  require 'minitest/autorun'
  require_relative './rgb.rb'　# <== 新しく追加

  class RgbTest < Minitest::Test
    def test_to_hex
      assert_equal '#000000', to_hex(0, 0, 0)
    end
  end

#ひとまず、テストを実行してみましょう！
  Run options: --seed 4503
  # Running:
  .


  Finished in 0.000717s, 1394.6999 runs/s, 1394.6999 assertions/s.

  1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

#期待通り、テストをパスできました。しかし、これで満足してはいけません。テストコードにはもう一つ検証コードを追加します。

require 'minitest/autorun'
require_relative './rgb.rb'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)   # <== 新しく追加
  end
end

#テストを実行してみても、当たり前ですが失敗します。

1) Failure:
RgbTest#test_to_hex [rgb_test.rb:7]:
Expected: "#ffffff"
  Actual: "#000000"

1 runs, 2 assertions, 1 failures, 0 errors, 0 skips

#ここで必要な作業は整数値を16進数に変換することです。これは「to_sメソッド」を使うと実現できます。

  puts 0.to_s(16)     # ==> "0"
  puts 255.to_s(16)   # ==> "ff"

#基本的にはto_sメソッドで16進数に変換できます。
#ところが、0の時は1桁の"0"になっています。こちらが期待しているのは"00"のような2桁の文字列です。
#今回の場合だとrjustメソッドを使って右寄せすると便利です。第1引数には桁数を指定します。デフォルトは空白(半角スペース)で桁揃えされますが、第2引数を指定すると、空白以外の文字列を埋めることができます。

  puts '0'.rjust(5)       # ==> "    0"
  puts '0'.rjust(5, '0')  # ==> "00000"
  puts '0'.rjust(5, '_')  # ==> "____0"

#このメソッドを組み合わせれば、0を2桁の"00"に変換できますね。

  puts 0.to_s(16).rjust(2, '0')     # ==> "00"
  puts 255.to_s(16).rjust(2, '0')   # ==> "ff"

#次のようにrgb.rb内のto_hexメソッドをちゃんと実装できます。
  def to_hex(r, g, b)
    '#' +
      r.to_s(16).rjust(2, "0") +
      g.to_s(16).rjust(2, "0") +
      b.to_s(16).rjust(2, "0")
  end

#テストをパスできるか確認しましょう！
  # Running:

  .

  Finished in 0.000602s, 1661.1298 runs/s, 3322.2595 assertions/s.

  1 runs, 2 assertions, 0 failures, 0 errors, 0 skips

#テストもパスすることができました。
#念のため、r、g、bの各値がバラバラになっているテストも追加します。

require 'minitest/autorun'
require_relative './rgb.rb'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)
    assert_equal '#043c78', to_hex(4, 60, 120)      # <== 新しく追加
  end
end

#テストをパスしたら今度はリファクタリングをおこないます！

#[4.6.2]to_hexメソッドをリファクタリングする
#リファクタリングとは外から見た振る舞いは保ったまま、理解や修正が簡単にできるように内部のコードを改善することです。
#先程のto_hexメソッドを確認してみましょう！

  def to_hex(r, g, b)
    '#' +
      r.to_s(16).rjust(2, "0") +
      g.to_s(16).rjust(2, "0") +
      b.to_s(16).rjust(2, "0")
  end

# ==> 今の状態だと「.to_s(16).rjust(2, "0")」が3回登場します。
#　　　これだと将来、何か変更があった時に同じ変更を3回繰り返さないといけません。

#プログラミングにはDRY原則と呼ばれる有名な原則があります。
#これは「Don't repeat yourself」の略で、「繰り返しを避けること」という意味です。DRY原則に従い、to_hexメソッドからコードの重複を取り除きましょう。

# 同じ処理を3回するのであれば、r、g、bの各値を配列に入れて繰り返し処理すれば済みそうです。
  
  class RgbTest < Minitest::Test
    def test_to_hex(r, g, b)
      hex = "#"
      [r, g, b].each do |n|
        hex += n.to_s(16).rjust(2, "0")
    end
    puts hex
  end

# ==> 上のコードでは[r, g, b]というように引数として渡された各値を配列に入れた後、eachメソッドを使って繰り返し処理しています。
#     eachメソッドの内部では数値を16進数に変換した文字列を、ブロックの外で作成したhex変数に連結します。

# ==> そして最後に変数hexをメソッドに戻り値として返却しています。
#     この結果、.to_s(16).rjust(2, "0")は一度しか登場しなくなりました。

#これでもテストをパスできるか確認してみましょう！

  Finished in 0.000883s, 1132.5029 runs/s, 3397.5086 assertions/s.

  1 runs, 3 assertions, 0 failures, 0 errors, 0 skips

#リファクタリングしてもテストをパスしましたね！

#さらにinjectメソッドを使用すると、もっと短くコーディングできます！

  def test_to_hex(r, g, b)
    [r, g, b].inject('#') do |hex, n|
      hex + n.to_s(16).rjust(2, "0")
  end

#ここでおさえておくべきポイントは3つあります。
# (1)　最初の繰り返し処理ではhexに'#'が入ること。
# (2)　ブロックの中のhex + n.to_s(16).rjustu(2, '0')で作成された文字列は次の繰り返し処理のhexに入ること。
# (3)　繰り返し処理が最後まで到達したら、ブロックの戻り値がinjectメソッド自身の戻り値になること。

# ==> ここでピンと来ないときは「[4.4.4]inject/reduce」を読み直そう

#[4.6.3]to_intsメソッドを作成する
#16進数の文字列を10進数の数値3つに変換するメソッドです。

  to_ints('#000000')    # ==> [0, 0, 0]
  to_ints('#ffffff')    # ==> [255, 255, 255]
  to_ints('#043c78')    # ==> [4, 60, 120]

#to_hexメソッドの時と同じようにテストコードを書き込みましょう！

# EX rgb_test.rb
  class RgbTest < Minitest::Test
    def test_to_hex
      assert_equal '#000000', to_hex(0, 0, 0)
      assert_equal '#ffffff', to_hex(255, 255, 255)
      assert_equal '#043c78', to_hex(4, 60, 120)
    end

    def test_to_ints                                    # 新しく追加
      assert_equal [0, 0, 0], to_ints('#000000')        #    |
    end                                                 #    |
  end

#次にrgb.rbを開き、to_intsメソッドの仮実装します。

# EX rgb.rb
  def to_hex(r, g, b)
    [r, g, b].inject('#') do |hex, n|
      hex + n.to_s(16).rjust(2, "0")
    end
  end

  def to_ints(hex)                      # 新しく追加
    [0, 0, 0]                           #    |
  end                                   #    |

# EX テストを実行してみる
  ryotaono@onoyuufutoshinoMacBook-Air cherry_book_two % ruby rgb_test.rb
  Run options: --seed 44069

  # Running:

  ..

  Finished in 0.000693s, 2886.0032 runs/s, 5772.0064 assertions/s.

  2 runs, 4 assertions, 0 failures, 0 errors, 0 skips

#二つ目の検証コードを追加しましょう！
# EX rgb_test.rb
require 'minitest/autorun'
require_relative './rgb.rb'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)
    assert_equal '#043c78', to_hex(4, 60, 120)
  end

  def test_to_ints
    assert_equal [0, 0, 0], to_ints('#000000')
    assert_equal [255, 255, 255], to_ints('#ffffff')    # <== 新しく追加
  end
end

# EX テストを実行してみよう
  1) Failure:
  RgbTest#test_to_ints [rgb_test.rb:13]:
  Expected: [255, 255, 255]
    Actual: [0, 0, 0]

# ==> 失敗してしまいました…。

#to_intsメソッドの実装で必要な手順は大きく分けて次の２つです。

# ①文字列から16進数の文字列を2文字ずつ取り出す。
# ②2桁の16進数を10進数の整数に変換する。

#まず、16進数の文字列を2つずつ取り出す方法ですが、これは[]と範囲オブジェクトを使うことにします。
#「[4.5.1]配列と文字列の一部を抜き出す」のこうでも既に説明した通り、例えば、文字列の2文字目から4文字目までを取り出したい時は、次のように取り出すことができます。

# EX 範囲オブジェクトで取り出す方法
  s = 'abcde'
  puts s[1..3]  # ==> bcd

#この方法を利用することによって次のようのに文字列からR(赤)、G(緑)、B(青)の各値を取り出すことができます。

# EX 文字列からR(赤)、G(緑)、B(青)の各値を取り出す方法
  hex = '#12abcd'
  puts r = hex[1..2]    # ==>12
  puts g = hex[3..4]    # ==>ab
  puts b = hex[5..6]    # ==>cd

#次に考えるのは16進数の文字列を10進数の整数に変更する方法です。
#これはstringクラスにhexというズバリそのもののメソッドがあります。

# EX hexクラス
  puts '00'.hex   # ==> 0
  puts 'ff'.hex   # ==> 255
  puts '2a'.hex   # ==> 42

#さあ、これらの知識を結合すると、to_intsメソッドを次のように実装できます。
# EX rgb.rb内を下記のように書き換え
  def to_ints(hex)
    r = hex[1..2]
    g = hex[3..4]
    b = hex[5..6]
    ints = []
    [r, g, b].each do |s|
      ints << s.hex
    end
    puts ints
  end

#上のコードの処理フローは次の通りです。
# ・引数の文字列から3つの16進数を抜き出す。
# ・3つの16進数を配列に入れ、ループを回しながら10進数の整数に変換した値を別の配列に詰め込む。
# ・10進数の整数が入った配列を返す。

#テストを実行してみましょう！
# EX テスト結果

