# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mucomo}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Menke"]
  s.date = %q{2012-02-27}
  s.description = %q{mucomo is a lightweight library for the representation and management of multimodal corpora. It is a reference implementation of the data model which forms the central element of my ongoing dissertation project. This enterprise is associated with the project X1 "Multimodal Alignment Corpora" at the Collaborative Research Centre 673 "Alignment in Communication", funded by the German Research (DFG / Deutsche Forschungsgemeinschaft).}
  s.email = %q{pmenke@googlemail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "lib/mucomo.rb",
    "lib/mucomo/model.rb",
    "lib/mucomo/model/corpus.rb",
    "lib/mucomo/model/design.rb",
    "lib/mucomo/model/design_component.rb",
    "lib/mucomo/model/resource.rb",
    "lib/mucomo/model/resource_allocation.rb",
    "lib/mucomo/model/resource_part.rb",
    "lib/mucomo/model/resource_part_allocation.rb",
    "lib/mucomo/model/trial.rb",
    "test/helper.rb",
    "test/test_model_corpus.rb",
    "test/test_model_design.rb",
    "test/test_mucomo.rb"
  ]
  s.homepage = %q{http://github.com/pmenke/mucomo}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Lightweight library for the representation and management of multimodal linguistic corpora.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

