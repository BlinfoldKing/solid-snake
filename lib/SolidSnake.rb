require 'find'
require 'thor'
require 'fileutils'
require 'xcodeproj'
require 'Generator/Generator'

module SolidSnake
    class CLI < Thor
        desc "g NAME", "generate basic interactor and presenter, ex: g Login"
        def g name
            pwd = Dir.pwd
            Find.find pwd do |path|
               if path.include? ".xcodeproj"
                    @xcodeproj = path.to_s
                    puts "#{@xcodeproj} found"
                    Find.prune
               end
            end
            
            project = Xcodeproj::Project.open @xcodeproj
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
            implementations = generatedGroup.new_group "Implementations", implPath

            # Generate interator Files
            interactorProtocolPath = "#{interPath}/#{componentName}InteractorProtocol.swift" 
            interactorProtocolFile = File.open interactorProtocolPath, "w" 
            interactorProtocolFile.puts SolidSnake::Generator.interactor_protocol componentName
            interactorProtocolFile.close
            interfaces.new_file interactorProtocolPath

            interactorImplementationPath = "#{implPath}/#{componentName}Interactor.swift" 
            interactorImplementationFile = File.open interactorImplementationPath, "w" 
            interactorImplementationFile.puts SolidSnake::Generator.interactor_implmentation componentName
            interactorImplementationFile.close
            implementations.new_file interactorImplementationPath

            # Generate Presenter Files
            presenterProtocolPath = "#{interPath}/#{componentName}PresenterProtocol.swift" 
            presenterProtocolFile = File.open presenterProtocolPath, "w" 
            presenterProtocolFile.puts SolidSnake::Generator.presenter_protocol componentName
            presenterProtocolFile.close
            interfaces.new_file presenterProtocolPath

            presenterImplementationPath = "#{implPath}/#{componentName}Presenter.swift" 
            presenterImplementationFile = File.open presenterImplementationPath, "w" 
            presenterImplementationFile.puts SolidSnake::Generator.presenter_implementation componentName
            presenterImplementationFile.close
            implementations.new_file presenterImplementationPath

            project.save
        end

    end
end

