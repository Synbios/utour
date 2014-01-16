module LegaciesHelper
  def locate_node(hash, id=nil)
    return hash if id.nil?
    parts = id.split(/\./)
    cursor = hash
    parts.each do |part|
      found = false
      return nil if cursor.nil?
      cursor["contents"].each do |member|
        if part == member["index"]
          cursor = member
          found = true
          break
        end
      end
      return nil if found == false
    end
    return cursor
  end

  def add_node(tag, node)
    return "home?node=#{node}" if tag == ""
    "home?node=#{tag}.#{node}"
  end
end
