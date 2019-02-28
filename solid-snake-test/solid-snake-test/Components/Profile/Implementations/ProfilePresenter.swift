
import Foundation

class ProfilePresenter: ProfilePresenterProtocol {

    var interactor: ProfileInteractorProtocol!
    var isTrue: bool

    override func generateTrue() {
        self.isTrue = interactor.generateTrue()
    }
}
        
