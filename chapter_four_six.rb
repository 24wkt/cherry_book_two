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

