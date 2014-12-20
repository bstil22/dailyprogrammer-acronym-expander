
class Dictionary
  def initialize file='acronym_dictionary.txt'
    @acronyms_and_definitions = Hash.new
    @file = file
  end

  def populate
    file_lines = IO.readlines(@file)
    file_lines.each do |line|
      acronym_and_definition = line.split(" - ")
      acronym = acronym_and_definition[0]
      definition = acronym_and_definition[1].chomp
      @acronyms_and_definitions[acronym] = definition
    end
  end

  def lookup acronym
    @acronyms_and_definitions[acronym]
  end
end


class ChatMessage
  def initialize message, dictionary
    @message = message
    @dictionary = dictionary
  end

  def expand_acronyms
    @message.gsub(/\w+/) do |word|
      match = @dictionary.lookup word
      if match
        match
      else
        word
      end
    end
  end
end



# dict = Dictionary.new.populate
# p dict

dict = Dictionary.new
dict.populate
m = ChatMessage.new("wtf that was unfair", dict)
p m.expand_acronyms


