# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

Bundler.require :default, ENV['RACK_ENV']

require 'sinatra'
require "sinatra/reloader" if development?
require 'sprockets'
require 'sprockets-helpers'
require 'coffee_script'
require 'eco'
require 'json'

require 'semver'

require './config/settings'
