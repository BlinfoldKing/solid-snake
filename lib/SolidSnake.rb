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


            implPath = "./#{mainGroup.path}/Components/#{componentName}/Implementations"
            FileUtils.mkdir_p implPath 
            interPath = "./#{mainGroup.path}/Components/#{componentName}/Interfaces"
            FileUtils.mkdir_p interPath

            interfaces = generatedGroup.new_group "Interfaces", "#{componentName}/Interfaces"
            implementations = generatedGroup.new_group "Implementations", "#{componentName}/Implementations"

            # Generate interator Files
            interactorProtocolPath = "#{interPath}/#{componentName}InteractorProtocol.swift" 
            interactorProtocolFile = File.open interactorProtocolPath, "w" 
            interactorProtocolFile.puts SolidSnake::Generator.interactor_protocol componentName
            interactorProtocolFile.close
            interfaces.new_file "#{componentName}InteractorProtocol.swift"

            interactorImplementationPath = "#{implPath}/#{componentName}Interactor.swift" 
            interactorImplementationFile = File.open interactorImplementationPath, "w" 
            interactorImplementationFile.puts SolidSnake::Generator.interactor_implmentation componentName
            interactorImplementationFile.close
            implementations.new_file "#{componentName}Interactor.swift"

            # Generate Presenter Files
            presenterProtocolPath = "#{interPath}/#{componentName}PresenterProtocol.swift" 
            presenterProtocolFile = File.open presenterProtocolPath, "w" 
            presenterProtocolFile.puts SolidSnake::Generator.presenter_protocol componentName
            presenterProtocolFile.close
            interfaces.new_file "#{componentName}PresenterProtocol.swift"

            presenterImplementationPath = "#{implPath}/#{componentName}Presenter.swift" 
            presenterImplementationFile = File.open presenterImplementationPath, "w" 
            presenterImplementationFile.puts SolidSnake::Generator.presenter_implementation componentName
            presenterImplementationFile.close
            implementations.new_file "#{componentName}Presenter.swift"

            # Generate Presenter Test
            interactorGroup = nil
            presenterGroup = nil
            for group in testGroup.groups
                if group.path == "Interactor"
                    interactorGroup = group
                    break
                end
            end

            for group in testGroup.groups
                if group.path == "Presenter"
                    presenterGroup = group
                    break
                end
            end
            
            interactorTestPath = "#{testGroup.path}/Interactor/#{componentName}InteractorTest.swift"
            interactorTestFile = File.open interactorTestPath, "w"
            interactorTestFile.puts SolidSnake::Generator.interactor_test componentName, mainGroup.path.to_s.gsub('-', '_')
            interactorTestFile.close
            interactorGroup.new_file "#{componentName}InteractorTest.swift"

            presenterTestPath = "#{testGroup.path}/Presenter/#{componentName}PresenterTest.swift"
            presenterTestFile = File.open presenterTestPath, "w"
            presenterTestFile.puts SolidSnake::Generator.presenter_test componentName, mainGroup.path.to_s.gsub('-', '_')
            presenterTestFile.close
            presenterGroup.new_file "#{componentName}PresenterTest.swift"

            puts "Components Created"
            project.save
        end

    end
end

