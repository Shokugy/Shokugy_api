# -*- encoding: utf-8 -*-
# stub: grape-jbuilder 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-jbuilder"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Shu Masuda"]
  s.date = "2014-03-02"
  s.description = "Use Jbuilder in Grape"
  s.email = ["masushu@gmail.com"]
  s.homepage = "https://github.com/milkcocoa/grape-jbuilder"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Use Jbuilder in Grape"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<grape>, [">= 0.3"])
      s.add_runtime_dependency(%q<jbuilder>, [">= 0"])
      s.add_runtime_dependency(%q<tilt>, [">= 0"])
      s.add_runtime_dependency(%q<tilt-jbuilder>, [">= 0.4.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<json_expressions>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<grape>, [">= 0.3"])
      s.add_dependency(%q<jbuilder>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 0"])
      s.add_dependency(%q<tilt-jbuilder>, [">= 0.4.0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<json_expressions>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<grape>, [">= 0.3"])
    s.add_dependency(%q<jbuilder>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 0"])
    s.add_dependency(%q<tilt-jbuilder>, [">= 0.4.0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<json_expressions>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
