require 'date'

class Database
  def initialize(filename)
    @filename = File.expand_path(filename)
  end

  def entries
    return [] unless File.file?(@filename)

    File.readlines(@filename).map(&:strip).map {|s| s.split(':') }
  end

  def write_entry(new_entry)
    File.open(@filename, 'a+') {|f| f << new_entry.join(":") << "\n" }
    true
  end
end

class DailyTracker
  def initialize
    @entries = []
  end

  def report(date = nil)
    entries_for_date(date).inject([]) do |report_lines, day_entries|
      report_lines << build_report_line(day_entries)
    end
  end

  def add_food_entry(meal, food)
    @new_entry = ['f', meal, food, Date.today.to_s]
  end

  def load_from(db)
    db.entries.each {|e| load_entry e }
  end

  def save_to(db)
    if @new_entry
      db.write_entry @new_entry
    end
  end

  private

  def load_entry(entry)
    @entries << entry
  end

  def entries_for_date(date)
    EntryList.new(@entries).for_date(date)
  end

  def build_report_line(day_entries)
    report_line = [day_entries.first]
    report_line += day_entries.last['f'].map {|e| e[2] }
    report_line.join("\n")
  end
end

class EntryList
  def initialize(entries)
    @entries = entries
  end

  def for_date(date)
    group_entries_by_date
    group_entries_by_type
    order_food_entries
    entries_ordered_by_date
  end

  private

  def group_entries_by_date
    @entries_by_date = @entries.group_by(&:last)
  end

  def group_entries_by_type
    @entries_by_date.each do |key, entries|
      @entries_by_date[key] = entries.group_by(&:first)
    end
  end

  def order_food_entries
    @entries_by_date.values.each do |entries|
      if food_group = entries['f']
        food_group.sort_by! {|f| %w(b l d).index(f[1]) }
      end
    end
  end

  def entries_ordered_by_date
    @entries_by_date.keys.sort.inject([]) do |sorted_entries, key|
      sorted_entries << [key, @entries_by_date[key]]
    end
  end
end

class InputHandler
  def initialize(tracker)
    @tracker = tracker
  end

  def handle(input)
    case input.first
    when 'r'
      date = Date.parse(input.last) rescue nil
      puts @tracker.report(date).join("\n\n====\n\n")
    when 'a'
      @tracker.add_food_entry(*input[2..-1])
    else
      $stderr.puts usage_notes
    end
  end

  def usage_notes
<<END
Usage:

# report entire daily tracker
ruby exercise_1_storyish.rb r

# a single day's report
ruby exercise_1_storyish.rb r 2014-08-04

# add a food entry (b = breakfast, l = lunch, d = dinner)
ruby exercise_1_storyish.rb a f l "ham and eggs"

# add an exercise entry (not yet implemented)
ruby exercise_1_storyish.rb a e "kettlebell swings"
END
  end
end

# stuff = File.file?('stuff.txt') ? File.readlines('stuff.txt').map(&:chomp) : []
#
# if ARGV[0] == 'a'
#   new_stuff = ARGV[1..-1]
#   new_stuff << Date.today
#   stuff << new_stuff.join(':')
# elsif ARGV[0] == 'r'
#   split_stuff = stuff.map {|s| s.split(':') }
#   grouped_stuff = split_stuff.group_by {|s| s.last }
#   grouped_stuff.each {|k, v| grouped_stuff[k] = v.group_by {|s| s.first } }
#   sorted_keys = grouped_stuff.keys.sort
#   sorted_keys.each do |key|
#     parsed = Date.parse(ARGV.last) rescue nil
#     next if parsed && parsed != Date.parse(key)
#
#     puts key
#     group = grouped_stuff[key]
#     if (ARGV[1] != 'e') && (f = group['f'])
#       f.sort_by {|i| %w(b l d).index(f[1]) }.each do |i|
#         puts i[2]
#       end
#     end
#
#     if (ARGV[1] != 'f') && group['e']
#       puts '----'
#       group['e'].each {|e| puts e[1] }
#     end
#
#     puts "===="
#   end
# end
#
# File.open('stuff.txt', 'w') do |file|
#   stuff.each {|s| file << s << "\n" }
# end
