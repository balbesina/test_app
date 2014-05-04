module OperationsHelper
	def separate_comma(number)
	  whole, decimal = number.to_s.split(".")
	  whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
	  [whole_with_commas, decimal].compact.join(".")
	end

	DTFormat = '%d/%m/%Y %H:%M:%S'
	DTFormatJS = 'dd/MM/yyyy hh:mm:ss'
end
