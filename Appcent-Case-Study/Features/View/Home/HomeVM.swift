import Foundation
import RxSwift
import RxCocoa

class HomeVM {
    let disposeBag = DisposeBag()
    let allGenre = BehaviorRelay<[Genre]>(value:  [])
    let loading = BehaviorRelay<Bool>(value: false)
    
    init() {
        fetchAllCategories()
    }
    
    private func fetchAllCategories() {
        loading.accept(true)
        DeezerService.shared.request(path: DeezerServicePath.GENREPATH.rawValue) { [weak self] (response: Genres) in
            self?.allGenre.accept(response.data)
            self?.loading.accept(false)
        } onFail: { [weak self] error in
            print("fetchAllCategories Error: \(error)")
            self?.loading.accept(false)
        }

    }
}
