require 'spec_helper'


class X
	def self.const_missing name
		name
	end

	Colors = enum {
		RED
		GREEN = 3
		BLUE
	}

	cstyle_enum(2) {
		MADO = 2
		MAMI
		HOMU
	}
end


describe CstyleEnum do
  it 'has a version number' do
    expect(CstyleEnum::VERSION).not_to be nil
  end

  it "defined enums" do
	  expect([X::RED, X::GREEN, X::BLUE]).to eq [0, 3, 4]
	  expect([X::MADO, X::MAMI, X::HOMU]).to eq [2, 4, 6]
  end

  it "call X.const_missing" do
	  expect(X::SAYA).to eq :SAYA
  end

  it "enum return value" do
	  expect(X::Colors.values).to eq [0, 3, 4]
	  expect(X::Colors.keys).to eq [:RED, :GREEN, :BLUE]
  end

end
