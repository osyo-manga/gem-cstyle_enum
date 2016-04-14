require "cstyle_enum/version"

module CstyleEnum
	def enum step = 1, &block
		receiver = block.binding.eval("self")
		start_constants = receiver.constants

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
		Hash[(receiver.constants - start_constants).map{ |it| [it, receiver.const_get(it)] }]
	end
	alias_method :cstyle_enum, :enum
end

class Module
	include CstyleEnum
end
