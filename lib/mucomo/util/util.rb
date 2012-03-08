

class Mucomo::Util::Util


  def self.example_corpus
  @@example_corpus ||= self.construct_example_corpus  
  end
  
  def construct_example_corpus
    corpus = Mucomo::Model::Corpus.new
    
    return corpus
  end
  
end