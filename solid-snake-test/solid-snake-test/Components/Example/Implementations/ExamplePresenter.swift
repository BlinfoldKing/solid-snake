
import Foundation

class ExamplePresenter: ExamplePresenterProtocol {

    var interactor: ExampleInteractorProtocol!
    var isTrue: Bool = false

    func generateTrue() {
        self.isTrue = interactor.generateTrue()
    }
}
        
