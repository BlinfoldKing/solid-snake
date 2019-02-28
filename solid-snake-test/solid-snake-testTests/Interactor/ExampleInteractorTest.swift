
import XCTest

@testable import solid_snake_test
class ExampleInteractorTest: XCTestCase {

    var interactor: ExampleInteractorProtocol!

    override func setUp() {
        interactor = ExampleInteractor()
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
            
