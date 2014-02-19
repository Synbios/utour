nbsp = Prawn::Text::NBSP

def chinese(string)
	string.gsub(/\s/, Prawn::Text::NBSP)    
end

# Registering a single TTF font
pdf.font_families.update("default" => {
	:normal => "#{Rails.root.join('public/fonts/diablo.ttf')}",
	:bold => "#{Rails.root.join('public/fonts/diablo.ttf')}"
	})

pdf.font('default') do
	pdf.text "#{@tour.name}", :align => :center
end


pdf.move_down 20
pdf.font('default')
tour_table = [[ "参考行程，实际以出团通知书为准！" ]]
@tour.days.each do |day|
	content = ""
	site_activities = day.sites
	if site_activities.empty?
		content = day.itinerary
	else
		site_activities.each do |activity|
			content += chinese "<b>#{activity.site.name}：</b>#{activity.full_des}\n"
		end
	end
	day_table = pdf.make_table ([
		["第#{day.number}天", {:content => "#{day.title}", :colspan => 3}],
		[{:content => content, :colspan => 4}],
		["团餐", "早餐: #{ day.breakfast.blank? ? "自理" : day.breakfast }", "午餐: #{ day.lunch.blank? ? "自理" : day.lunch }", "晚餐: #{ day.dinner.blank? ? "自理" : day.dinner }"],
		["住宿", {:content => "#{ day.breakfast.blank? ? "自理" : day.accommodation }", :colspan => 3}]
		]) do 
		cells.style do |c|
			columns(0).width = 60
			columns(1).width = (pdf.bounds.width - 60)/3
			columns(2).width = (pdf.bounds.width - 60)/3
			columns(3).width = (pdf.bounds.width - 60)/3

			columns(0).rows(0).align = :center
			columns(0).rows(0).valign = :center

			rows(1).style(:inline_format => true, :leading => 5)

			columns(0).rows(2).align = :center
			columns(0).rows(2).valign = :center

			columns(0).rows(3).align = :center
			columns(0).rows(3).valign = :center

			case c.row % 4
			when 0
				c.background_color = "F5F5FF"
			when 2
				c.background_color = "00EFED"
			when 3
				c.background_color = "FFFF1A"
			end
		end
	end

	tour_table.push [day_table]
end



pdf.table tour_table, :width => pdf.bounds.width, :header => true, :position => :center, :cell_style => { :leading => 5 } do
	row(0).align = :center
	row(0).background_color = "FB99CC"
end

pdf.move_down 20
if !@tour.notes.blank?
	list = @tour.notes.split("\n")
	pdf.text "备注:"
	(1 .. list.size).each do |i|
		pdf.text "#{i}.#{nbsp}#{list[i-1]}"
	end
end

pdf.move_down 20
if !@tour.include.blank?
	list = @tour.include.split("\n")
	pdf.text "产品包含项目:"
	(1 .. list.size).each do |i|
		pdf.text "#{i}.#{nbsp}#{list[i-1]}"
	end
end

pdf.move_down 20
if !@tour.exclude.blank?
	list = @tour.exclude.split("\n")
	pdf.text "产品不含项目:"
	(1 .. list.size).each do |i|
		pdf.text "#{i}.#{nbsp}#{list[i-1]}"
	end
end

pdf.move_down 20
if !@tour.transportations.blank?
	list = @tour.transportations.split("\n")
	pdf.text "交通工具:"
	(1 .. list.size).each do |i|
		pdf.text "#{i}.#{nbsp}#{list[i-1]}"
	end
end

pdf.move_down 20
if !@tour.visa.blank?
	list = @tour.visa.split("\n")
	pdf.text "签证要求及注意事项:"
	(1 .. list.size).each do |i|
		pdf.text "#{i}.#{nbsp}#{list[i-1]}"
	end
end

