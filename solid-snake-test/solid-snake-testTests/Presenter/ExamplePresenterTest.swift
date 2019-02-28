
import XCTest

@testable import solid_snake_test
class ExamplePresenterTest: XCTestCase {

    var presenter: ExamplePresenter!

    override func setUp() {
        presenter = ExamplePresenter()
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
            
