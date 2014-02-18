module ApplicationHelper
	def trim_name(string, leters=6)
		if string.length > leters
			string[0, leters] + "..."
		else
			string
		end
	end

  def image_picker_options_for_select(images, blank=nil)
    content = images.map { |image| "<option data-img-src='#{image.photo.url(:thumb)}' value='#{image.id}'>#{image.name}</option>" }.join
    if blank.present?
      "<option value=''>#{blank}</option>#{content}".html_safe
    else
      content.html_safe
    end
  end
end
