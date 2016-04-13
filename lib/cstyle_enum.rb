require "cstyle_enum/version"

module CstyleEnum
	def enum step = 1, &block
		receiver = block.binding.eval("self")
		has_const_missing = receiver.methods(false).include? :const_missing
		receiver.const_set :ENUM_DUMMY_VALUE, -step

		receiver.singleton_class.instance_eval {
			if has_const_missing
				alias_method :tmp_enum_const_missing, :const_missing
			end

			define_method :const_missing do |name|
				const_set(name, const_get(constants.last) + step)
			end
			block.call

			remove_method :const_missing

			if has_const_missing
				alias_method :const_missing, :tmp_enum_const_missing
			end
		}

		receiver.__send__ :remove_const, :ENUM_DUMMY_VALUE
	end
end

class Module
	include CstyleEnum
end
