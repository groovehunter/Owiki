
require 'lingo/lingo'
#require 'wordnet'


class Entry < ActiveRecord::Base

  has_and_belongs_to_many :terms

  def process
    fpat = 'content*'
    Dir.glob(fpat) do |fn|
      File.delete(fn) if File::exists?(fn)
    end
#    File.delete('content') if File::exists?('content')

    f = File.open('content',"w")
    f.puts content
#    logger.debug "content #{content}"

    sleep 2
#    config = 'lingo-call.cfg'
    config = 'flo.cfg'
    lingo = Lingo.call(config=config)
    @res = lingo.talk
    sleep 1
    content_out = Rails.root + "lib/lingo/content.any"
    logger.debug "content_out #{content_out}"
    f = File.open(content_out,"r")
    lines = f.readlines()
    lines
  end

  def splitwords

    lines = content.split(" ")
    lines
  end

  def process_terms(lines)
    lines.each do |line|
      if line.size > 5
        line.strip!
        line.gsub!(/[.,_*+#!"§$%"{}]/,'')
        #lex = WordNet::Lexicon.new
        #res = lex.grep line
        #logger.debug "res #{res}"
        term = Term.where(:name => line).first
        if not term
          term = Term.new(:name => line, :count=>0)
        end
        term.count += 1
        if term.count > 1
          logger.debug "term - name: #{term.name} count: #{term.count}"
        end
        if not terms.include? term
          terms << term
          logger.debug "new term of this entry, relation created"
        end
        logger.debug "term count: #{term.count}"
      end
    end
  end

end
