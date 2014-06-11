#!/usr/bin/env ruby
require 'thor'
require 'json'

class TreemapConverter
  def initialize(options = {})
    @options = options
  end

  def convert(json_data = {})
    convert_root(json_data)
  end

  private

  def max_depth
    @options[:max_depth]
  end

  def convert_root(root_node)
    convert_value(root_node)[:children].first
  end

  def convert_value(val, current_depth = 0, parent_key = nil)
    return convert_simple(val) if current_depth > max_depth

    if val.is_a? Hash
      convert_hash(val, current_depth)
    elsif val.is_a? Array
      convert_array(val, current_depth, parent_key)
    else
      convert_simple(val)
    end
  end

  def convert_array(val, current_depth = 0, parent_key = nil)
    {
      children: val.each.map do |el|
        {name: "#{parent_key}[]"}.merge(convert_value(el, current_depth + 1))
      end
    }
  end

  def convert_simple(val)
    {
      size: val.to_json.length
    }
  end

  def convert_hash(hash = {}, current_depth = 0)
    {
      children: hash.each.map do |k,v|
          {name: k}.merge(convert_value(v, current_depth + 1, k))
      end
    }
  end

end

class Convert < Thor
  desc "treemap", "convert json file to treemap format"
  option :input, :aliases => '-i', :required => true
  option :output, :aliases => '-o', :required => false, :default => "treemap.json"
  option :max_depth, :aliases => '-d', :type => :numeric, :default => 4
  def treemap
    puts "Converting #{options[:input]} to treemap format"
    data = JSON.parse(open(options[:input]).read())
    output = TreemapConverter.new(max_depth: options[:max_depth]).convert(data)
    open(options[:output], 'w').write(output.to_json)
    puts "Done saved to #{options[:output]}"
  end
end
Convert.start(ARGV)
