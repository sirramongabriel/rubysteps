$:.unshift '.' # add current dir to the require path
require 'exercise_1_implementation'

db = Database.new('trackerdb.txt')
tracker = DailyTracker.new
handler = InputHandler.new tracker

tracker.load_from db
handler.handle ARGV
tracker.save_to db
