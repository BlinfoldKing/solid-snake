
import Foundation

class LoginPresenter: LoginPresenterProtocol {

    var interactor: LoginInteractorProtocol!
    var isTrue: Bool = false

    func generateTrue() {
        self.isTrue = interactor.generateTrue()
    }
}
        
