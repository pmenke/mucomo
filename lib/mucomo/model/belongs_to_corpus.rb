module Mucomo::Model::BelongsToCorpus
  
  attr_reader :corpus

  # @todo access to containing corpus object
  def corpus=(parent_corpus)
    @corpus = parent_corpus
  end
  
  def has_corpus?
    @corpus!=nil
  end
  
end