# -*- coding: utf-8 -*-
require "ya_lorem_ja/version"
require 'ya_lorem_ja/word_resource'
require 'ya_lorem_ja/resources/kazehakase'

  
##
# Yet Anothoer Japanese Lorem
# 
module YaLoremJa
  ##
  # Japanese Lorem
  class Lorem
    attr_reader :resource_name
    
    ##
    # @param [Symbol] resource_name name of word resource
    # @param [Range] char_count_range range of character count in a word
    # @param [Range] word_count_range range of word count in sentence
    # @param [Range] sentence_count_range renage of sentence count in paragraph
    # 
    def initialize(resource_name=:kazehakase, char_count_range=2..6, word_count_range=6..15, sentence_count_range=2..5)
      @resource_name = resource_name
      # 文章辞書の読み込み
      @resource = ::YaLoremJa::WordResources.load(resource_name, char_count_range, word_count_range, sentence_count_range)
    end

    ##
    # @return [Range] range of character count in a word
    def char_count_range
      return @resource.char_count_range_in_a_word
    end

    ##
    # @return [Range] range of word count in a sentence
    def word_count_range
      return @resource.word_count_range_in_a_sentence
    end
    
    ##
    # @return [Range] range of sentence count in a paragraph
    def sentence_count_range
      return @resource.sentence_count_range_in_a_paragraph
    end

    ##
    # @return [Array] return sentence end chars
    def sentence_end_chars
      return @resource.sentence_end_chars
    end

    ##
    # set line break character
    # @param [String] char line break character
    def line_break=(char)
      @resource.line_break = char
    end

    ##
    # @return [String] line break character
    def line_break
      @resource.line_break
    end

    ##
    # return a random word from word resource
    # @return [String] word
    def word
      # 1単語返却
      @resource.word
    end

    ##
    # return rondom words from word resource
    #
    # @param [Fixnum] total count of word
    # @return [String] words
    def words(total)
      @resource.words(total)
    end

    ##
    # return a random sentence from word resource
    # @return [String] sentence 
    def sentence
      @resource.sentence
    end

    ##
    # return rondom sentences from word resource
    #
    # @param [Fixnum] total count of sentence
    # @return [String] words
    def sentences(total)
      @resource.sentences(total)
    end

    ##
    # return a random paragraph from word resource
    # @return [String] sentence     
    def paragraph
      @resource.paragraph
    end

    ##
    # return random paragraphs from word resource
    # @param [Fixnum] total count of paragraph
    # @return [String] paragraph 
    def paragraphs(total)
      @resource.paragraphs(total)
    end


    def date(fmt='%Y年%m月%d日')
      y = rand(20) + 1990
      m = rand(12) + 1
      d = rand(31) + 1
      Time.local(y, m, d).strftime(fmt)
    end

    
    # Get a placeholder image, using placehold.it by default
    # @param [String] size
    # @param [Hash] options
    # @return [String]
    def image(size, options={})
      domain           = options[:domain] || 'http://placehold.it'
      src              = "#{domain}/#{size}"
      hex              = %w(a b c d e f 0 1 2 3 4 5 6 7 8 9)
      background_color = options[:background_color]
      color            = options[:color]

      if options[:random_color]
        background_color = hex.shuffle[0...6].join
        color = hex.shuffle[0...6].join
      end

      src << "/#{background_color.sub(/^#/, '')}" if background_color
      src << '/ccc' if background_color.nil? && color
      src << "/#{color.sub(/^#/, '')}" if color
      src << "&text=#{Rack::Utils.escape(options[:text])}" if options[:text]

      src
    end
    
  end
end
