require 'thor'
require 'fileutils'

module SolidSnake
    class CLI < Thor
        desc "generate TYPE NAME", "ex: generate Interactor Lorem"
        def generate type, name
            @name = name.capitalize
            @type = type.capitalize
            filename = "#{@name}#{@type}.swift"
            dir = File.dirname "./components/#{@name}/#{@type}"
            if File.directory? dir
                FileUtils.mkdir_p "./components/#{@name}/#{@type}"
            end

            puts "#{filename} file generated"
        end
    end
end

