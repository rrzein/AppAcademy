require 'singleton'
require 'sqlite3'
require './user.rb'
require './question.rb'
require './questionfollower.rb'
require './reply.rb'
require './questionlike.rb'
require './tag.rb'
require 'debugger'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("questions.db")

    self.results_as_hash = true
    self.type_translation = true
  end
end

