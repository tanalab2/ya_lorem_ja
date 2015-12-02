# -*- coding: utf-8 -*-
require 'spec_helper'

describe YaLoremJa do

  it 'インスタンスのリソースを切り替え可能なこと' do
    lorem = YaLoremJa::Lorem.new(:chuumon_no_ooi_ryouriten)
    expect(lorem).not_to be_nil
    expect(lorem.resource_name).to be == :chuumon_no_ooi_ryouriten
    lorem.reload_resource(:kazehakase)
    expect(lorem.resource_name).to be == :kazehakase
    expect(lorem).not_to be_nil
  end


end
