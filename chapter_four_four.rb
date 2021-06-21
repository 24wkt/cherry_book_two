#[4.4]ブロックを使う配列メソッド
#ここからはブロックを使う配列のメソッドのうち、仕様頻度が高い次のメソッドを見ていきます！

# ・map/collect
# ・select/find_all/reject
# ・inject/reduce

#[4.4.1]map/collect
#配列でeachメソッドの次に使用頻度が高いメソッドといえばmapメソッド(エイリアンスメソッドはcollect)だと思います。
#mapメソッドは各要素に対してブロックを評価した結果を新しい配列に返します。
# EX 配列の各要素を10倍した新しい配列を作るコード
  numbers = [1, 2, 3, 4]
  new_numbers = []
  numbers.each { |n| new_numbers << n * 10 }
  puts new_numbers

# ==> mapメソッドを使うとブロックの戻り値が配列の要素となる新しい配列が作成されるため、mapメソッドの戻り値をそのまま新しい変数に入れることができます。

# EX 上のコードをmapメソッドを使って記述した場合
  numbers = [1, 2, 3, 4]
  #ブロックの戻り値が新しい配列の各要素になる
  new_numbers = numbers.map { |n| n * 10 }
  puts new_numbers  # ==> new_numbers = [10, 20, 30, 40]

# ==> 空の配列を用意して、他の配列をループ処理した結果を空の配列に詰め込んでいくような処理の大半をmapメソッドに置き換えることができます。

#[4.4.2]select/find_all/reject
#selectメソッド(エイリアンスメソッドはfind_all)は各要素に対してブロックを評価し、その戻り値の要素を集めた配列を返すメソッドです。
# EX 偶数の数値だけを集めた配列を新たに作れる
  numbers = [1, 2, 3, 4, 5, 6]
  #ブロックの戻り値が真になった要素だけが集められる
  even_numbers = numbers.select { |n| n.even? }
  puts even_numbers   # ==> even_numbers = [2, 4, 6]

#rejectメソッドはselectメソッドの反対で、ブロックの戻り値が真になった要素を除外した配列を返します。
#言い換えると、ブロックの戻り値が偽である要素を集めるメソッドです。
# EX 3の倍数を除外するメソッド
  numbers = [1, 2, 3, 4, 5, 6]
  #3の倍数を除外する(3の倍数以外を集める)
  non_multiples_of_numbers = numbers.reject { |n| n % 3 == 0}
  puts non_multiples_of_numbers   # ==> [1, 2, 4, 5]