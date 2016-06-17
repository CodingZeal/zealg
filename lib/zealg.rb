require 'thor'
require 'git'
require_relative "zealg/version"
require_relative 'zealg/boilerplate'

module Zealg
  class Base < Thor
    desc "boilerplate", "install base react boilerplate into rails project"
    def boilerplate
      Zealg::Boilerplate.new.install
    end
  end
end
