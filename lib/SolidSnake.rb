require 'find'
require 'thor'
require 'fileutils'
require 'xcodeproj'

module SolidSnake
    class CLI < Thor
        desc "g NAME", "generate basic interactor and presenter, ex: g Login"
        def g name
            pwd = Dir.pwd
            Find.find(pwd) do |path|
               if path.include? ".xcodeproj"
                    @xcodeproj = path.to_s
                    puts "#{@xcodeproj} found"
                    Find.prune
               end
            end
            
            project = Xcodeproj::Project.open(@xcodeproj)
            mainGroup = project.groups[0]
            testGroup = project.groups[1]

            componentsGroup = nil
            for group in mainGroup.groups
                componentsGroup = group if group.path == "Components"
            end

            return if componentsGroup.nil?

            # generate root of component
            componentName = name.capitalize
            generatedPath = "./#{mainGroup.path}/Components/#{componentName}"
            FileUtils.mkdir_p generatedPath
            generatedGroup = componentsGroup.new_group componentName

            puts "Component Created"

            implPath = "./#{mainGroup.path}/Components/#{componentName}/Implementations"
            FileUtils.mkdir_p implPath 
            interPath = "./#{mainGroup.path}/Components/#{componentName}/Interfaces"
            FileUtils.mkdir_p interPath

            interfaces = generatedGroup.new_group "Interfaces", interPath
            implementations = generatedGroup.new_group "Implementations"

            project.save
        end

        def impl type, protocol, name
        end
    end
end

