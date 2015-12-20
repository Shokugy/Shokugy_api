# -*- encoding: utf-8 -*-
# stub: sorcery 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sorcery"
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Noam Ben Ari", "Kir Shatrov", "Grzegorz Witek"]
  s.date = "2015-04-05"
  s.description = "Provides common authentication needs such as signing in/out, activating by email and resetting password."
  s.email = "nbenari@gmail.com"
  s.homepage = "http://github.com/NoamB/sorcery"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.2"
  s.summary = "Magical authentication for Rails 3 & 4 applications"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.4", "~> 0.4"])
      s.add_runtime_dependency(%q<oauth2>, [">= 0.8.0"])
      s.add_runtime_dependency(%q<bcrypt>, ["~> 3.1"])
      s.add_development_dependency(%q<abstract>, [">= 1.0.0"])
      s.add_development_dependency(%q<json>, [">= 1.7.7"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0.3.8"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.0.0"])
    else
      s.add_dependency(%q<oauth>, [">= 0.4.4", "~> 0.4"])
      s.add_dependency(%q<oauth2>, [">= 0.8.0"])
      s.add_dependency(%q<bcrypt>, ["~> 3.1"])
      s.add_dependency(%q<abstract>, [">= 1.0.0"])
      s.add_dependency(%q<json>, [">= 1.7.7"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0.3.8"])
      s.add_dependency(%q<rspec>, ["~> 3.0.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.0.0"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0.4.4", "~> 0.4"])
    s.add_dependency(%q<oauth2>, [">= 0.8.0"])
    s.add_dependency(%q<bcrypt>, ["~> 3.1"])
    s.add_dependency(%q<abstract>, [">= 1.0.0"])
    s.add_dependency(%q<json>, [">= 1.7.7"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0.3.8"])
    s.add_dependency(%q<rspec>, ["~> 3.0.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.0.0"])
  end
end
