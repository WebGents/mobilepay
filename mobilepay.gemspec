# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobilepay/version'

Gem::Specification.new do |spec|
    spec.name = 'mobilepay'
    spec.version = Mobilepay::VERSION
    spec.authors = ['JungleCoders', 'Anton Bogdanov']
    spec.email = ['kortirso@gmail.com']

    spec.summary = 'Gem for interaction with MobilePay API'
    spec.description = 'Actions with payments in MobilePay system'
    spec.homepage = 'https://github.com/WebGents/mobilepay'
    spec.license = 'MIT'

    spec.files = `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
    end
    spec.bindir = 'exe'
    spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.add_development_dependency 'bundler', '~> 1.14'
    spec.add_development_dependency 'rake', '~> 10.0'
    spec.add_development_dependency 'jose', '~> 1.1'
end
