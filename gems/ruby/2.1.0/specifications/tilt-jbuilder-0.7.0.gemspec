# -*- encoding: utf-8 -*-
# stub: tilt-jbuilder 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tilt-jbuilder"
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Anthony Smith"]
  s.date = "2015-07-12"
  s.description = "Jbuilder support for Tilt"
  s.email = ["anthony@sticksnleaves.com"]
  s.homepage = "https://github.com/anthonator/tilt-jbuilder"
  s.rubygems_version = "2.2.2"
  s.summary = "Adds support for rendering Jbuilder templates in Tilt."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tilt>, ["< 3", ">= 1.3.0"])
      s.add_runtime_dependency(%q<jbuilder>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<tilt>, ["< 3", ">= 1.3.0"])
      s.add_dependency(%q<jbuilder>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<tilt>, ["< 3", ">= 1.3.0"])
    s.add_dependency(%q<jbuilder>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
