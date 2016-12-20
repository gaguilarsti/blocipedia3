#defining RandomData as a module becuase it is a standalone library.
module RandomData
  #defining random_paragraph and set sentences to an array.
  def self.random_paragraph
    sentences = []
    #create 4 to 6 random sentences.
    rand(4..6).times do
      sentences << random_sentence
    end
    #call join to combine each sentence in the array and seperate them with a space.  This creates a full paragraph.
    sentences.join(" ")
  end

  #using the same pattern as above to create 3 to 8 random sentences.
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    #capitalize returns a copy of the sentence with the first character capitalized and the rest lowercase.
    sentence.capitalize << "."
  end

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0, rand(3..8)].join
  end

  def self.random_name
    first_name = random_word.capitalize
    last_name = random_word.capitalize
    "#{first_name} #{last_name}"
  end

  def self.random_email
    "#{random_word}@#{random_word}.com"
  end


end
