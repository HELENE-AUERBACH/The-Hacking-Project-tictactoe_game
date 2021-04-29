# lignes très pratiques qui appellent les gems du Gemfile. Cela évite juste les "require" partout
require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'views/application'

Application.new.perform
