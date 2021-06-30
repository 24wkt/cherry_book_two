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