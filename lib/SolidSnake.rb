require 'thor'

module SolidSnake
    class CLI < Thor
        desc "generate TYPE NAME", "ex: generate Interactor Lorem"
        def generate type, name
            filename = "#{name.capitalize}#{type.capitalize}.swift"
            puts "#{filename} file generated"
        end
    end
end

