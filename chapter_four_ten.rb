#[4.10]繰り返し処理用の制御構造
#「[4.9.6]loopメソッド」の項ではループを脱出するために　breakを使いました。
#Rubyには他にも繰り返し処理の動きを変えるための制御構造が用意されています。次がそのキーワードの一覧です。

  ・break
  ・next
  ・redo

#また、Kernelモジュールのthrowメソッドとcatchメソッドもbreakと同じような用途で使われます。

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.10.1]break
#breakを使うと、繰り返し処理を脱出することができます。
# EX eachメソッドとbreakを組み合わせるコード
  # shuffleメソッドで配列の要素をランダムに並び替える
  numbers = [1, 2, 3, 4, 5].shuffle
  numbers.each do |n|
    puts n
    # 5が出たら繰り返し処理を脱出
    break if n == 5
  end
  # ==> 1
  #     3
  #     5

#breakはeachメソッドだけでなく、while文やuntil文、for文でも使うことができます。
# EX 上記のbreakの使用例をwhile文を使って書き直したもの
  numbers = [1, 2, 3, 4, 5].shuffle
  i = 0
  while i < numbers.size
    n = numbers[i]
    puts n
    break if n == 5
    i += 1
  end
  # ==> 4
  #     1
  #     5

#breakに引数を渡すと、while文やfor文の戻り値になります。引数を渡さない場合の戻り値はnilです。
# EX
  ret =
    while true
      break
    end
  puts ret
  # ==> nil

  ret =
    while true
      break 123
    end
  puts ret
  # ==> 123

# 繰り返し処理が入れ子になっている場合は、一番内側の繰り返し処理を脱出します。
# EX
  fruits = ['apple', 'melon', 'orange']
  numbers = [1, 2, 3]
  fruits.each do |fruit|
    # 配列の数字をランダムに入れ替え、3が出たらbreakする
    numbers.shuffle.each do |n|
      puts "#{fruit}, #{n}"
      # numbersのループは脱出するが、fruitsのループは継続する
      break if n == 3
    end
  end
  # ==> apple, 1
  #     apple, 3
  #     melon, 3
  #     orange, 1
  #     orange, 2
  #     orange, 3

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#[4.10.2]throwとcatchを使った大域脱出
#先ほど「breakでは一番内側の繰り返し処理しか脱出できない」と説明しました。一気に外側のループまで脱出したい場合は、Krenelモジュールのthrowメソッドとcatchメソッドを使います。

  catch タグ　do
    # 繰り返し処理など
    throw タグ
  end

#throw、catchというキーワードは、他の言語では例外処理に使われる場合がありますが、Rubyのthrow、catchは例外処理とは関係ありません。Rubyではraiseとrescueを例外処理で使います。
#throwメソッドとcatchメソッドは次のように使います。
# EX "orange"と３の組み合わせが出たらすべての繰り返し処理を脱出するコード
  fruits = ['apple', 'melon', 'orange']
  numbers = [1, 2, 3]
  catch :done do
    fruits.shuffle.each do |fruit|
      numbers.shuffle.each do |n|
        puts "#{fruit}, #{n}"
        if fruit == 'orange' && n == 3
          # 全ての繰り返し処理を脱出する
          throw :done
        end
      end
    end
  end
  # ==> orange, 2
  #     orange, 1
  #     orange, 3

#タグには通常シンボルを使います。
#throwとcatchのタグが一致しない場合はエラーが発生します。
# EX
  fruits = ['apple', 'melon', 'orange']
  numbers = [1, 2, 3]
  catch :done do
    fruits.shuffle.each do |fruit|
      numbers.shuffle.each do |n|
        puts "#{fruit}, #{n}"
        if fruit == 'orange' && n == 3
          # catchと一致しないタグをthrowする
          throw :foo
        end
      end
    end
  end
  # ==> /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:9:in `throw': uncaught throw :foo (UncaughtThrowError)
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:9:in `block (3 levels) in <main>'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:5:in `each'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:5:in `block (2 levels) in <main>'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:4:in `each'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:4:in `block in <main>'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:3:in `catch'
	#     from /Users/ryotaono/Desktop/programming/cherry_book_two/tempCodeRunnerFile.rb:3:in `<main>'
  #     apple, 1
  #     apple, 3
  #     apple, 2
  #     orange, 3

#throwメソッドに第二引数を渡すとcatchメソッドの戻り値になります。
# EX
  ret =
  catch :done do
    throw :done
  end
  puts ret
  # ==> nil

  ret =
  catch :done do
    throw :done, 123
  end
  puts ret
  # ==> 123

#上のコード例のように、catchとthrowは繰り返し処理と無関係に利用することができます。
#ただし、実際は繰り返し処理の大域脱出で使われることが多いと思います。

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------