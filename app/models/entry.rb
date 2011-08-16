
require 'lingo/lingo'

class Entry < ActiveRecord::Base
# =begin
  def work
    #@lingo = Lingo.config

    @lingo = Lingo.meeting

    @lingo
  end
#end
end
