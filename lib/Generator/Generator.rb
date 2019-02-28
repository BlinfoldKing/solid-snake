require 'fileutils'

module SolidSnake
    class Generator
        def self.interactor_protocol name
            %Q(
import Foundation

protocol #{name.capitalize}InteractorProtocol {
    func generateTrue() -> bool
}
            )
        end

        def self.interactor_implmentation name
            %Q(
import Foundation

class #{name.capitalize}Interactor: #{name.capitalize}InteractorProtocol {
    override func generateTrue() -> bool {
        return true
    }
}
            )
        end
        
        def self.interactor_test name, projectName
            %Q(
import XCTest

@testable import #{projectName}
class #{name.capitalize}InteractorTest: XCTestCase {
    override func setUp() {

    }

    override func tearDown() {

    }
}
            )
        end
        
        def self.presenter_protocol name
            %Q(
import Foundation

protocol #{name.capitalize}PresenterProtocol {
    func generateTrue()
}
        )
        end

        def self.presenter_implementation name
            %Q(
import Foundation

class #{name.capitalize}Presenter: #{name.capitalize}PresenterProtocol {

    var interactor: #{name.capitalize}InteractorProtocol!
    var isTrue: bool

    override func generateTrue() {
        self.isTrue = interactor.generateTrue()
    }
}
        )
        end
 
        def presenter_test name
        end
    end
end