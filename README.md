# YaLoremJa

簡易版 日本語 lorem です。

## Installation

Add this line to your application's Gemfile:

    gem 'ya_lorem_ja'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ya_lorem_ja

## Usage

```ruby
require 'ya_lorem_ja'

lorem = YaLoremJa::Lorem.new

# puts a word.
puts lorem.word

# puts ten words.
puts lorem.words(10)

# puts a sentence.
puts lorem.sentence

# puts three sentences.
puts lorem.sentences(3)

# puts a paragraph.
puts lorem.paragraph

# puts five paragraphs.
puts lorem.paragraphs(5)
```

## Interface

Middleman の lorem のインターフェースを参考にしています。

実装しているインターフェースは以下です。

- word
- words(num_of_words)
- sentence
- sentences(num_of_sentces)
- paragraph
- paragraphs(num_of_paragraph)
- date(format)
- image(size, options={})

## 実装

日本語 lorem の簡易版であるため、自然言語処理は一切していません。
文を最小単位とした文章リソースから、指定された文字数に収まる文を選択しています。

そのため、 word(or words) が指定された場合は、1単語あたり2〜6文字(コンストラクタで変更可)の範囲でランダムに文字数を決定し、
その文字数に収まる文を選択しています。ただし、 word(or words)の場合は、選択した文末に句点が存在する場合、文末の句点を削除します。

sentence(or sentence)が指定された場合は、1文あたり6〜15単語(コンストラクタで変更可)の範囲でランダムに単語数を決定し、単語数×単語の文字数に収まる文を選択しています。
複数文(例: sentences(3))を指定した場合は、改行文字(デフォルト "\n", line_breakプロパティで変更可)で各文を結合します。

paragraph(or paragraphs)が指定された場合は、1段落あたり2〜5文(コンストラクタで変更可)の範囲でランダムに文数を決定し、文を選択します。
複数段落(例: paragraphs(3))を指定した場合は、2つ分の改行文字(デフォルト "\n\n)を段落区切りとして設定します。

## 文章リソース

文章リソースとして、以下を収録しています。
デフォルトでは [坂口安吾「風博士」](http://www.aozora.gr.jp/cards/001095/card42616.html) が使用されます。

+ [坂口安吾「風博士」](http://www.aozora.gr.jp/cards/001095/card42616.html)
+ [宮沢賢治「注文の多い料理店」](http://www.aozora.gr.jp/cards/000081/card43737.html)

文書リソースの指定方法は以下になります。

```ruby
require 'ya_lorem_ja'
# 坂口安吾「風博士」 を使用する場合
lorem_kazehakase = YaLoremJa::Lorem.new
# or 
lorem_kazehakase = YaLoremJa::Lorem.new(:kazehakase)

# 宮沢賢治「注文の多い料理店」を使用する場合
lorem_ryouriten = YaLoremJa::Lorem.new(:chuumon_no_ooi_ryouriten)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
