require 'fileutils'

module SolidSnake
    class Generator
        def self.interactor_protocol name
            %Q(
import Foundation

protocol #{name.capitalize}InteractorProtocol {
    func generateTrue() -> Bool
}
            )
        end

        def self.interactor_implmentation name
            %Q(
import Foundation

class #{name.capitalize}Interactor: #{name.capitalize}InteractorProtocol {
    func generateTrue() -> Bool {
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

    var interactor: #{name.capitalize}InteractorProtocol!

    override func setUp() {
        interactor = #{name.capitalize}Interactor()
    }

    func testGenerateTrue() {
        // given
        var x = false

        // when
        x = interactor.generateTrue()

        // then
        XCTAssert(x)
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
    var isTrue: Bool = false

    func generateTrue() {
        self.isTrue = interactor.generateTrue()
    }
}
        )
        end
 
        def self.presenter_test name, projectName
            %Q(
import XCTest

@testable import #{projectName}
class #{name.capitalize}PresenterTest: XCTestCase {

    var presenter: #{name.capitalize}PresenterProtocol!

    override func setUp() {
        presenter = #{name.capitalize}Presenter()
    }

    func testGenerateTrue() {
        // given
        var x = false

        // when
        presenter.generateTrue()
        x = presenter.isTrue

        // then
        XCTAssert(x)
    }

    override func tearDown() {

    }
}
            )
        end
    end
end