module ApplicationHelper
	def trim_name(string, leters=6)
		if string.length > 6
			string[0, 6] + "..."
		else
			string
		end
	end
end
