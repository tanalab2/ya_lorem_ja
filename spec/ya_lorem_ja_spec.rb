# -*- coding: utf-8 -*-
require 'spec_helper'

describe YaLoremJa do
  it 'should have a version number' do
    expect(YaLoremJa::VERSION).not_to be_nil
  end

  it 'インスタンスを生成できること' do
    lorem = YaLoremJa::Lorem.new
    expect(lorem).not_to be_nil
  end

  it '1語を取得できること' do
    lorem = YaLoremJa::Lorem.new
    a_word = lorem.word
    puts a_word
    expect(a_word.size).to be <= lorem.char_count_range.max
  end

  it '2語を取得できること' do
    lorem = YaLoremJa::Lorem.new
    words = lorem.words(2)
    puts words
    expect(words.size).to be <= (lorem.char_count_range.max * 2)
  end

  it '10語を取得できること' do
    lorem = YaLoremJa::Lorem.new
    words = lorem.words(10)
    puts words
    expect(words.size).to be <= (lorem.char_count_range.max * 10)
  end

  it 'デフォルト改行文字は\nであること' do
    lorem = YaLoremJa::Lorem.new
    expect(lorem.line_break).to be == "\n"
  end

  it '1文を取得できること' do
    lorem = YaLoremJa::Lorem.new
    a_sentence =  lorem.sentence
    puts a_sentence
    expect(a_sentence.size).to be <= (lorem.word_count_range.max * lorem.char_count_range.max)
  end

  it '3文を取得できること' do
    lorem = YaLoremJa::Lorem.new
    sentences =  lorem.sentences(3)
    puts sentences
    expect(sentences.split("\n").count).to be == 3
  end

  it '1段落を取得できること' do
    lorem = YaLoremJa::Lorem.new
    a_para =  lorem.paragraph
    expect(a_para).not_to be_nil
    puts a_para
    expect(a_para.split(/\n{1}/).count).to be >= lorem.sentence_count_range.min
  end

  it '3段落を取得できること' do
    lorem = YaLoremJa::Lorem.new
    paras =  lorem.paragraphs(3)
    expect(paras).not_to be_nil
    puts paras
    expect(paras.split(/\n{2}/).count).to be == 3
    paras.split(/\n{2}/).each do |a_para|
      expect(a_para.split(/\n{1}/).count).to be >= lorem.sentence_count_range.min
    end
  end
  
  it '改行文字を変更時、文の改行文字も変更されること' do
    lorem = YaLoremJa::Lorem.new
    lorem.line_break = "\r\n"
    sentences =  lorem.sentences(3)
    p sentences
    expect(sentences.split("\r\n").count).to be == 3    
  end

  it '改行文字を変更時、段落の改行文字も変更されること' do
    lorem = YaLoremJa::Lorem.new
    lorem.line_break = "\r\n"
    paras =  lorem.paragraphs(3)
    expect(paras).not_to be_nil
    p paras
    expect(paras.split("\r\n"*2).count).to be == 3
    paras.split("\r\n"*2).each do |a_para|
      expect(a_para.split("\r\n").count).to be >= lorem.sentence_count_range.min
    end

  end
  
end
