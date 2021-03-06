#[4.9]様々な繰り返し処理
#配列とeachメソッドの組み合わせはRubyにおける繰り返し処理の代表例ですが、Rubyには繰り返し処理を行う方法が他にもたくさんあります。
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.1]timesメソッド
#配列を使わず、単純にn回処理を繰り返したい、という場合はIntegerクラスのtimesメソッドを使うと便利です。

  sum = 0
  # 処理を5回繰り返す。nには0, 1, 2, 3, 4が入る
  5.times { |n| sum += n }
  puts sum
  # ==> 10

#不要であればブロック引数は省略しても構いません。

  sum = 0
  # sumに1を加算する処理を5回繰り返す
  5.times { sum += 1}
  puts sum
  # ==> 5

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.2]uptoメソッドとdowntoメソッド
#nからmまで数値を1つずつ増やしながら何か処理をしたい場合は、Integerクラスのuptoメソッドを使いましょう。

  a = []
  10.upto(14) { |n| a << n }
  puts a
  # ==> [10, 11, 12, 13, 14]

#逆に数値を減らしていきたい場合はdowntoメソッドを使います。

  a = []
  14.downto(10) { |n| a << n }
  puts a
  # ==> [14, 13, 12, 11, 10]

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.3]stepメソッド
#1, 3, 5, 7のように、nからmまで数値をx個ずつ増やしながら何かを処理したい場合は、Numeicクラスのstepメソッドを使います。
#stepメソッドは次のような仕様になっています。

  開始値.step(上限値, １度に増減する大きさ)

# EX 1から10まで2ずつ値を増やしながら処理をしたい場合
  a = []
  1.step(10, 2) { |n| a << n }
  puts a
  # ==> [1, 3, 5, 7, 9]

# EX 10から1まで2ずつ値を減らす場合
  a = []
  10.step(1, -2) { |n| a << n }
  puts a
  # ==> [10, 8, 6, 4, 2]

#----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.2]while文とuntil文
#ここまではオブジェクトのメソッドとブロックを組み合わせて繰り返し処理を実行してきましたが、Rubyには繰り返し処理用の構文も用意されています。
#その構文の一つがwhile文です。while文は指定した条件が真である間、処理を繰り返します。

  while 条件式(真であれば実行)
    繰り返したい処理
  end

# EX 配列の要素数が5つになるまで値を追加するwhile文
  a = []
  while a.size < 5
    a << 1
  end
  puts a
  # ==> [1, 1, 1, 1, 1]

# EX 条件式の後ろにdoを入れると1行で書くこともできます。
  a = []
  while a.size < 5 do a << 1 end
  puts a
  # ==> [1, 1, 1, 1, 1]

  #しかし、1行で書くのであれば修飾子としてwhile文を後ろに置いた方がスッキリ書けます。
  a = []
  a << 1 while a.size < 5
  puts a
  # ==> [1, 1, 1, 1, 1]

#どんな条件でも最低1回は実行したい、という場合はbegin ... endで囲んでからwhileを書きます。
  a = []

  while false
    #このコードは常に条件が偽になるので実行されない
    a << 1
  end
  puts a
  # ==> []

  #begin ... endで囲むとどんな条件でも最低1回は実行される
  begin
    a << 1
  end while false
  puts a
  # ==> [1]

#while文の反対で、条件が偽である間、処理を繰り返すuntil文もあります。

  until 条件式(偽であれば実行)
    繰り返したい処理
  end

#繰り返しの条件が逆になること以外は、while文と使い方は同じです。
# EX 配列の要素数が3以下になるまで配列の要素を後ろから削除していくコード
  a = [10, 20, 30, 40, 50]
  until a.size <= 3
    a.delete_at(-1)
  end
  puts a
  # ==> [10, 20, 30]

#while文もuntil文も、条件式を間違えたり、いつまでたっても条件式の結果が変わらないようなコードを書いたりすると無限ループしてしまいます。
#while文やuntil文を書く場合は無限ループを発生させないように注意してください。

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.5]for文
#配列やハッシュはfor文で繰り返し処理することもできます。

  for 変数　in 配列やハッシュ
    繰り返し処理
  end

#上の説明では「配列やハッシュ」と書きましたが、厳密にはeachメソッドを定義しているオブジェクトであれば何でも構いません。

# EX 配列の中身を順番に加算していくコード
  numbers = [1, 2, 3, 4]
  sum = 0
  for n in numbers
    sum += n
  end
  puts sum
  # ==> 10

#とはいえ、上のfor文は実質的にはeach文を使った次のコードと同じです。Rubyのプログラムでは通常、for文よりもeachメソッドを使います。
  numbers = [1, 2, 3, 4]
  sum = 0
  numbers.each do |n|
    sum += n
  end
  puts sum
  # ==> 10

#厳密には全く同じではなく、for文の場合は配列の要素を受け取る変数やfor文の中で作成したローカル変数がfor文の外でも使える、という違いがあります。

  numbers = [1, 2, 3, 4]
  sum = 0
  numbers.each do |n|
    sum_value = n.even? ? n * 10 :n
    sum += sum_value
  end
  # ブロック引数やブロック内で作成した変数はブロックの外では参照できない
  puts n
  # ==> (NameError) undefined local variable or method `n' for main:Object
  puts sum_value
  # ==> (NameError) undefined local variable or method `sum_value' for main:Object

  numbers = [1, 2, 3, 4]
  sum = 0
  for n in numbers
    sum_value = n.even? ? n * 10 : n
    sum += sum_value
  end
  # for文で作成された変数はfor文の外でも参照できる
  puts n
  # ==> 4
  puts sum_value
  # ==> 40

#このような微妙な違いはあるものの、Rubyではfor文ではなく、eachメソッドやmapメソッドといった繰り返し処理用のメソッドを使う場合がほとんどです。

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.9.6]loopメソッド
#あえて無限ループを作りたい、という場合はwhile文を使って次のようなコードが書けます。

  while true
    #無限ループ用の処理
  end

#これに加えてもうひとつ、Kernelモジュールのloopメソッドとブロックを使う方法があります。
#ここではputsメソッドやpメソッドのようにloopメソッドも「どこでも呼び出せるメソッド」と考えてOKです。(詳細は第8章で)

  loop do
    # 無限ループ用の処理
  end

#無限ループから脱出する場合はbreakを使います。
# EX 配列に格納した5つの数値の中からランダムに数値を選び、５が出たタイミングで脱出する無限ループのサンプルコード

  numbers = [1, 2, 3, 4, 5]
  loop do
    # sampleメソッドでランダムに要素を1つ取得する
    n = numbers.sample
    puts n
    break if n == 5
  end
  # ==> 1
  #     2
  #     2
  #     1
  #     4
  #     2
  #     3
  #     2
  #     4
  #     2
  #     4
  #     1
  #     2
  #     5 <-５が出るまでループし続ける

#上記のコードはwhile文でも書くことができます。
numbers = [1, 2, 3, 4, 5]
  while true
    n = numbers.sample
    puts n
    break if n == 5
  end
  # ==> 4
  #     5

#loopメソッドはブロックを使うので変数nがループの外で参照できません。
#一方、while文はループの外でもnが参照できます。この違いはfor文とeachメソッド違いと同じなので、詳しい理由はfor文の項を参照してください。
#------------------------------------------------------------------------------------------------------------------------------------------------------------------