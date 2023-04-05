# Static-site

```bash
## 追加
rails g controller StaticPages home help
## 削除
rails d controller StaticPages home help
```

大事そうだからmemo


- アプリケーションのコード >> テストコード (短い) =簡単に書ける 「先に」

- 動作の仕様がまだ固まりきっていない場合、アプリケーションのコードを先に書き、期待する動作を「後で」書く

- セキュリティが重要な課題またはセキュリティ周りのエラーが発生した場合、テストを「先に」書く

- バグを見つけたら、そのバグを再現するテストを「先に」書き、回帰バグを防ぐ体制を整えてから修正に取りかかる

- すぐにまた変更しそうなコード (HTML構造の細部など) に対するテストは「後で」書く

- リファクタリングするときは「先に」テストを書く。特に、エラーを起こしそうなコードや止まってしまいそうなコードを集中的にテストする

=> 基本エラーが起こりそう or 楽にかける 「先に」
=> 仕様が変わりがち、すぐ編集する 「後で」


## カスタムヘルパー

views/layout/*.erb
```ruby
<%= yield(:title) %> | Ruby on Rails Tutorial Sample App
```

views/static_pages/*.erb
```ruby
<% provide(:title, "Home") %>
```

helpersに定義する


## 文法
- if系
    ```ruby
    if s.nil?
        "s is nil"
    elsif s.empty?
        "s is empty"
    elsif s.include("foo")
        "s include foo"
    end
    ```

- 文字変換

    ```ruby
    object.to_s
    ```

    メソッドチェーンできる
    ```ruby
    object.to_s.empty?
    # => true
    ```

    後続タスク
    method1が真の時、method2が実行される
    ```ruby
    {method1} unlress {method2}
    ```


- 例外処理
    ```ruby
    file.save!  #失敗 => 例外発生
    file.save   #失敗 => nil


    begin
      10 / 0
    rescue => e
      puts e
    end

    # => divided by 0

    ```

- 関数
    ```ruby
    def string_message(str = '')
        return "It's an empty string!" if str.empty?
        return "The string is nonempty."
    end

    #　関数のオブジェクト => :string_message
    puts string_message("foobar")
    ```

- 配列操作
    ```ruby
    a = [2, 3, 4, 7]

    # 結合
    a.join
    # => "2347"
    a.join(',')
    # => "2,3,4,7"
    
    # range操作
    b = (0..9).to_a
    # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    # 0から2まで
    b[0..2]
    # => [0, 1, 2]
    # 0から3つ
    b[0,3]
    # => [0, 1, 2]
    ```

- ブロック
    ```ruby
    (1..3).each {|i| puts 2 * i}
    2
    4
    6
    => 1..3

    ## (1..3) 範囲オブジェクト
    ## { |i| puts 2 * i } ブロック

    ## 書き換え
    (1..3).each do |i|
        puts 2 * i
    end


    # map
    (1..5).map { |i| i**2 }
    ## => [1, 4, 9, 16, 25]
    ```

    symbol-to-proc
    ```ruby
    ## ラムダ式みたいなやつで省略できるっぽい
    %w[A B C].map { |char| char.downcase }
    %w[A B C].map { &:downcase }
    ```

- hash
    ```ruby
    user = {}
    user["name"] = "hogehoge"
    user["id"] = 22
    # => {"fdf"=>"fdsf", "id"=>22}
   
    user[:name]   
    # => "hogehoge"
    
    # :name <- このことをシンボル
    # railsでは文字列よりシンブルで扱うのが一般的

    a = {"one" => 'uno', "two" => "doc", "three" => "tres"}

    # こっちの方が良い
    a = {:one => 'uno', :two => "doc", :three => "tres"}
    # これでも良い(こっちの方が直感的だなぁ)
    a = {one: 'uno', two: "doc", three: "tres"}
    # a[:one]でアクセスできる
    ```

- class
    ```ruby
    s = "foobar"       # ダブルクォートは文字列のコンストラクタ
    s = String.new("foobar")

    # 継承
    class Word < String
        # @@でクラス変数 => staticのこと
        @@uouo = "hoge"
        # コンストラクタ
        def initialize(name)
            # 初期処理
            ## @でインスタンス変数
            @name = name
        end
        def uouo?
            puts "uouou"
        end
    end
        
    ```

- class拡張
    ```ruby
    class String
        def palindrome?
            self == self.reverse
        end
    end
    ## 普通に書けばoverrideできる
    ## なんかアンセーフな感じできもいなぁ
    ```


- マスアサイメント
    ```ruby
    ## こういうの
    Person.new(name: 'hoge', age: 24)
    person.update(name: 'hoge', age: 24)
    ```
    rails3 => `attr_accessible`とかを用意して更新対象を限定していた
    rails4 => 脆弱性があるから Strong Parametersを導入
    ```ruby
    def person_params
        params.require(:person).permit(:name, :age)
    end
    ```


- Asset Pipeline

app => 画像とかスタイルシート
lib => 自作ライブラリ
vender => サードパーティライブラリ

- プリプロセッサエンジン
  つまり.erbを.htmlにしてくれるやつ
  coffeeスクリプトとか色々


- リンクのテスト
  ```bash
  rails g integration_test site_layout
  ```

  ```ruby
  require 'test_helper'

    class SiteLayoutTest < ActionDispatch::IntegrationTest

        test "layout links" do
            get root_path
            assert_template 'static_pages/home'
            assert_select "a[href=?]", root_path, count: 2
            assert_select "a[href=?]", help_path
            assert_select "a[href=?]", about_path
            assert_select "a[href=?]", contact_path
        end
    end
```

helper関数のテスト書く時
test/helpers/*.rb ActionView::TestCase継承したクラスでequalとかテストしてやる
helperのモジュールはtest_helperにincludeしてtest_helperから叩く
