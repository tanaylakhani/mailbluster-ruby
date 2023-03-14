require "digest/md5"

module Mailbluster
  module Utils
    def self.md5(string)
      Digest::MD5.hexdigest(string)
    end

    def self.underscore(string)
      string.gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze).
        gsub(/([a-z\d])([A-Z])/, '\1_\2'.freeze).
        tr("-".freeze, "_".freeze).downcase
    end

    def self.camelize(string)
      # camelize string but don't capitalize the first letter
      string.split("_").map(&:capitalize).join.sub(/^./, &:downcase)
    end
  end
end
