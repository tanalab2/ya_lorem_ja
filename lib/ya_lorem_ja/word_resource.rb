# -*- coding: utf-8 -*-
module YaLoremJa

  ##
  # manage word resources
  module WordResources
    @default_resource_name = :kazehakase
    class << self

      def default_resource_name=(resource_name)
        @default_resource_name = resource_name
      end

      ##
      # retrun repository of word resource
      def resource
        @resource ||= { }
      end

      ##
      # register word resource
      # @param [Symbol] name  name of word resource
      # @param [Class] namespace class of word resource
      def register(name, namespace)
        if resource.key?(name)
          return
        end
        resource[name.to_sym] = namespace
      end

      ##
      # create a instance of word resource
      # @param [Symbol] name name of word resource
      # @param [Range] char_count_range range of character count in a word
      # @param [Range] word_count_range range of word count in sentence
      # @param [Range] sentence_count_range renage of sentence count in paragraph
      # @return [WordResource] instance of word resource
      def load(name, char_count_range, word_count_range, sentence_count_range)
        kls = resource[name.to_sym]
        unless kls
          return nil
        end
        return kls.new(char_count_range, word_count_range, sentence_count_range)
      end

    end
  end

  ##
  # base class of word resource
  class WordResource

    ##
    # default line break character of sentence of paragraph
    DEFAULT_LINE_BREAK = "\n"

    attr_reader :sentence_end_chars, :sentence_map, :char_count_range_in_a_word, :word_count_range_in_a_sentence, :sentence_count_range_in_a_paragraph
    attr_accessor :line_break

    ##
    # @param [Range] char_count_range range of character count in a word
    # @param [Range] word_count_range range of word count in sentence
    # @param [Range] sentence_count_range renage of sentence count in paragraph
    def initialize(char_count_range, word_count_range, sentence_count_range)
      # 単語の文字数範囲の設定
      @char_count_range_in_a_word = char_count_range
      # 文の単語数範囲の設定
      @word_count_range_in_a_sentence = word_count_range
      # 段落の文数範囲の設定
      @sentence_count_range_in_a_paragraph = sentence_count_range
      # 改行文字
      @line_break = DEFAULT_LINE_BREAK
    end

    def sentence_map_keys
      @sentence_map_keys ||= sentence_map.keys.sort.reverse
    end

    ##
    # return a random word from word resource
    # @return [String] word
    def word
      words(1)
    end

    ##
    # return rondom words from word resource
    #
    # @param [Fixnum] total count of word
    # @return [String] words
    def words(num_of_word)
      target_len = num_of_word.times.inject(0){ |sum| sum + rand(@char_count_range_in_a_word) }
      sentence_key = bsearch(sentence_map_keys, target_len)
      unless sentence_key
        sentence_key = sentence_map.keys.min
      end
      wk_word = sentence_map[sentence_key].sample
      return wk_word.sub(/[#{ sentence_end_chars.join() }]$/, "")
    end

    ##
    # return a random sentence from word resource
    # @return [String] sentence
    def sentence
      sentences(1)
    end

    ##
    # return rondom sentences from word resource
    #
    # @param [Fixnum] total count of sentence
    # @return [String] words
    def sentences(total)
      list = []
      total.times do
        word_count = rand(word_count_range_in_a_sentence)
        sentence_len = word_count.times.inject(0){ |sum| sum + rand(char_count_range_in_a_word) }
        sentence_key = bsearch(sentence_map_keys, sentence_len)
        unless sentence_key
          sentence_key = sentence_map.keys.min
        end
        list << sentence_map[sentence_key].sample
      end
      return list.join(@line_break)
    end

    ##
    # return a random paragraph from word resource
    # @return [String] sentence
    def paragraph(opts)
      paragraphs(1, opts)
    end

    ##
    # return random paragraphs from word resource
    # @param [Fixnum] total count of paragraph
    # @return [String] paragraph
    def paragraphs(total, opts)
      list = []
      total.times do
        sentence_count = rand(sentence_count_range_in_a_paragraph)
        start_sep = opts[:start_sep].to_s
        end_sep = opts[:end_sep].to_s
        list << start_sep + self.sentences(sentence_count) + end_sep
      end
      return list.join()
    end

    private

    def bsearch(array, val)
      if array.respond_to?(:bsearch)
        return array.bsearch{ |elm| elm <= val }
      else
        return array.find{ |elm| elm <= val }
      end
    end

    class << self
      ##
      # register word resource
      def register(resource_name)
        ::YaLoremJa::WordResources.register(resource_name, self)
      end
    end
  end


end
