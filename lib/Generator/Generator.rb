require 'fileutils'

module SolidSnake
    class Generator
        def interactor_protocol name
            %Q(
               import Foundation
           
               protocol #{name.Capitalize}InteractorProtocol {

               }
            )

            
        end

        def interactor_implmentation name
            %Q(
                import Foundation

                protocol #{name.Capitalize}Interactor: #{name.Capitalize}InteractorProtocol {

                }
            )
        end

        def presenter name
        end

        def interactor_test name
        end

        def presenter_test name
        end
    end
end