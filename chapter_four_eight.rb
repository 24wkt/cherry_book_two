#[4.8]ブロックについてもっと詳しく
#---------------------------------------------------------------------------------------------------------------------------------------------------------------

#[4.8.1]添字付きの繰り返し処理
#既に説明した通り、Rubyではeachメソッドを使って繰り返し処理を行う場合が大半です。
#しかし、eachメソッドでは何番目の要素を処理しているか、ブロック内で判別できません。繰り返し処理をしつつ、処理している要素の添字も取得したい。
#このようなケースでは、each_with_indexメソッドを使う便利です。このメソッドを使うと、ブロック引数の第2引数に添字を渡してくれます。

  fruits = ['apple', 'orange', 'melon']
  # ブロック引数のiには0, 1, 2...と要素の添字に入る
  fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
  # ==> 0: apple
  #     1: orange
  #     2: melon

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.8.2]with_indexメソッドを使った添字付きの繰り返し処理
#前項で紹介したeach_with_indexメソッドだと、eachメソッドの代わりにしか使えません。
#例えばmapメソッドで繰り返し処理をしつつ、添字も同時に取得したい時はそうすればいいでしょうか？
#このようなケースではmapメソッドとwith_indexメソッドを組みわせて使います。

  fruits = ['apple', 'orange', 'melon']
  # mapとして処理しつつ、添字も受け取る
  fruits.map.with_index { |fruit, i| "#{i}: #{fruit}" }
  # ==> ["0: apple", "1: orange", "2: melon"]

#with_indexメソッドはmap以外のメソッドとも組み合わせることができます。

  fruits = ['apple', 'orange', 'melon']
  # 名前に"a"を含み、なおかつ添字が奇数である要素を削除する
  fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd? }
  puts fruits
  # ==> ["apple", "melon"]

#このメソッドはEnumeratorクラスのインスタンスメソッドです。
#そして、eachメソッドやmapメソッド、delete_ifメソッドなど繰り返し処理を行うメソッドの大半はブロックを省略して呼び出す、Enumeratorオブジェクトを返すようになっています。

  fruits = ['apple', 'orange', 'melon']
  # ブロックなしでメソッドを呼び出すとEnumeratorオブジェクトが返る。よってwith_indexが呼び出される
  puts fruits.each
  # ==> #<Enumerator:0x00007fec7a134930> / <Enumerator: ['apple', 'orange', 'melon']:each>
  puts fruits.map
  # ==> #<Enumerator:0x00007fec7a134930> / <Enumerator: ['apple', 'orange', 'melon']:map>
  puts fruits.delete_if
  # ==> #<Enumerator:0x00007fec7a134930> / <Enumerator: ['apple', 'orange', 'melon']:each>

#このようになっているため、with_indexメソッドはあたかも様々な処理用のメソッドと組み合わせて実行できるように見えるのです。

#----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.8.3]添字を０以外の数値から開始させる
#each_with_indexメソッドやwith_indexメソッドを使うと、繰り返し処理に添字を取得できて便利なのですが、添字はいつも０から始まります。
#これを０以外の数値(例えば、１や１０)から始めたい、と思った場合はどうすればいいでしょうか？

#この場合はwith_indexメソッドに引数を渡します。そうすると添字が引数で渡した数値から開始します。

  fruits = ['apple', 'orange', 'melon']

  # eachで繰り返しつつ、1から始める添字を取得
  fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
  # ==> 1: apple
  #     2: orange
  #     3: melon

  # mapで処理しつつ、10から始まる添字を取得する
  fruits.each.with_index(10) { |fruit, i| puts "#{i}: #{fruit}" }
  # ==> 10: apple
  #     11: orange
  #     12: melon

#ちなみに、each_with_indexメソッドには引数を渡せないため、each_with_index(1)ではなく、上のコードのようにeach.with_index(1)の形で呼び出す必要があります。

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.8.4]配列がブロック引数に渡される場合
#配列の配列に対して繰り返し処理を実行すると、ブロック引数に配列が渡ってきます。
#例えば、縦の長さと横の長さを配列に格納し、それを複数用意した配列があったとします。

  dimensions = [
    #[縦, 横]
    [10, 20],
    [30, 40],
    [50, 60]
  ]

  #面積の計算結果を格納する配列
  areas = []
  #ブロック引数が1個であれば、ブロック引数の値が配列になる
  dimensions.each do |dimension|
    length = dimension[0]
    width = dimension[1]
    areas << length * width
  end

  puts areas
  # ==> [200, 1200, 3000]

#しかし、ブロック引数の数を2個にすると、縦と横の値を別々に受け取ることができ、上のコードよりもシンプルに書くことができます。

  dimensions = [
    #[縦, 横]
    [10, 20],
    [30, 40],
    [50, 60]
  ]

  # 面積の計算結果を格納する配列
  areas = []
  # 配列の要素分だけブロック引数を用意すると、各要素の値が別々に変数に格納される
  dimensions.each do |length, width|
    areas << length * width
  end

  puts areas
  # ==> [200, 1200, 3000]

#あまり意味はありませんが、ブロック引数が多すぎる場合ははみ出しているブロック引数はnilになります。

  # lengthとwidthには値が渡されるが、fooとbarはnilになる
  dimensions.each do |length, width, foo, bar|
    p[length, width, foo, bar]
  end
  # ==> [10, 20, nil, nil]
  #     [30, 40, nil, nil]
  #     [50, 60, nil, nil]

#配列の要素が3個あるのに、ブロック引数が2個しかない場合は3つ目が切り捨てられます。ですが、わかりづらいので特別な理由がない限りこうしたコードは避けましょう。

  dimensions = [
    #[縦, 横]
    [10, 20, 100],
    [30, 40, 200],
    [50, 60, 300]
  ]

  # 3つの値をブロック引数に渡そうとするが、2つしかないので3つ目の値は捨てられる
  dimensions.each do |length, width|
    p[length, width]
  end
  # ==> [10, 20]
  #     [30, 40]
  #     [50, 60]

#ではeach_with_indexのように、元からブロック引数を2つ受け取る場合はどうすればいいでしょうか？
#試しに「|length, width, i|」のように3つのブロック引数を並べてみましょう。

  dimensions = [
    #[縦, 横]
    [10, 20],
    [30, 40],
    [50, 60]
  ]
  dimensions.each_with_index do |length, width, i|
    puts "length: #{length}, width: #{width}, i: #{i}"
  end
  # ==> length: [10, 20], width: 0, i:
  #     length: [30, 40], width: 1, i:
  #     length: [50, 60], width: 2, i:

#最初のブロック引数にlengthに配列が丸ごと渡されてしまっています…。その影響でブロック引数の割り当てがズレて、widthに添字がiにnilが入っています。
#それならば、次のようにブロック引数を2つにすると、第一引数で縦と横の値を配列として取得できそうです。

  dimensions = [
    #[縦, 横]
    [10, 20],
    [30, 40],
    [50, 60]
  ]

  # 一旦、配列のまま受け取る
  dimensions.each_with_index do |dimension, i|
    # 配列から縦から横の値を取り出す
    length = dimension[0]
    width = dimension[1]
    puts "length: #{length}, width: #{width}, i: #{i}"
  end
  # ==> length: 10, width: 20, i: 0
  #     length: 30, width: 40, i: 1
  #     length: 50, width: 60, i: 2

#しかし、一度配列で受け取ってから変数に入れ直すのが面倒ですね。なんとか一気にブロック引数で受け取る方法はないでしょうか？
#こういう場合は次のように配列の要素を受け取るブロック引数を()で囲むと、配列の要素を別々に引数として受け取ることができます。

  dimensions = [
    #[縦, 横]
    [10, 20],
    [30, 40],
    [50, 60]
  ]
  # ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
  dimensions.each_with_index do |(length, width), i|
    puts "length: #{length}, width: #{width}, i: #{i}"
  end
  # ==> length: 10, width: 20, i: 0
  #     length: 30, width: 40, i: 1
  #     length: 50, width: 60, i: 2

#ご覧のように、縦の値、横の値、添字と3つの値を一度にブロック引数で受け取ることができました。
#------------------------------------------------------------------------------------------------------------------------------------------------------------------