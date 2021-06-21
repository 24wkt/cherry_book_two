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

#[4.4.3]find/detect
#findメソッド(エイリアスメソッドはdetect)はブロックの戻り値が真になった最初の要素を返します。
# EX 偶数の数値だを集める
  numbers = [1, 2, 3, 4, 5, 6]
  #ブロックの戻り値が最初に真になった要素を返す
  even_number = numbers.find { |n| n.even? }
  puts even_number  # ==> [2]

#[4.4.4]inject/reduce
#injectメソッド(エイリアスメソッドはreduce)はたたみ込み演算を行うメソッドです。実際のコードを見ながらの方が理解しやすいでしょう。
# EX eachメソッドを使って１から４までの値を変数sumに加算していくコード
  numbers = [1, 2, 3, 4]
  sum = 0
  numbers.each { |n| sum += n }
  puts sum  # ==> 10

#上のコードをinjectを使って書くと下記のようになります。これをサンプルに解説をしていきます。
  numbers = [1, 2, 3, 4]
  sum = numbers.inject(0) { |result, n| result + n }
  puts sum  # ==> 10

#ブロックの第1引数(サンプルではresult)は初回のみinjectメソッドの引数(サンプルでは0)が入ります。2回目以降は前回のブロックの戻り値が入ります。
#ブロックの第2引数(サンプルではn)は配列の各要素(1, 2, 3, 4)が順番に入ります。
#ブロックの戻り値は次の回に引き継がれ、ブロックの第1引数(result)に入ります。繰り返し処理が最後まで終わると、ブロックの戻り値がinjectメソッドとブロックは次のように協調します。

numbers = [1, 2, 3, 4]
sum = numbers.inject(0) { |result, n| result + n }

#[1回目]：result=0 , n=1 , 0+1=1  ==> これが次のresultに入る。
#[2回目]：result=1 , n=2 , 1+2=2  ==> この結果が次のresultに入る。
#[3回目]：result=3 , n=3 , 3+3=6  ==> この結果が次のresultに入る。
#[4回目]：result=6 , n=4 , 6+4=10 ==> 最後の要素に達したのでこれがinjectメソッドの戻り値になる。

#別の見方をすると…
puts ((((0 + 1) +2 ) +3 ) + 4)    # ==> 10

#injectメソッドは数値以外のオブジェクトに対して適用することも可能です。
# EX 文字列に対してinjectメソッドを使う
  puts ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].inject('Sun') { |result, s| result + s }
# ==> SunMonTueWedThuFriSat
# 別の見方をすると…
puts (((((('Sun' + 'Mon') +'Tue' ) +'Wed' ) + 'Thu') + 'Fri') + 'Sat')    # ==> SunMonTueWedThuFriSat