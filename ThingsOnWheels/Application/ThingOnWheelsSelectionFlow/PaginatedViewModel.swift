//
// Created by Ivan Chalov on 2019-07-24.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PaginatedViewModel<T> {
    let disposeBag = DisposeBag()

    var items: BehaviorRelay<[T]> = BehaviorRelay(value: [])

    var currentPage: Int?
    var totalPages: Int?
    var isLoading = false
    var shouldLoadNextPage: Bool {
        guard isLoading == false else {
            return false
        }

        if let current = currentPage,
           let total = totalPages {
            return current < total - 1
        } else {
            return true
        }
    }

    func request() -> Observable<Result<PaginatedResponse<T>, Error>> {
        fatalError("Must be overridden in subclass")
    }

    func loadItems() {
        if shouldLoadNextPage == false {
            return
        }
        isLoading = true
        request()
                .subscribe(onNext: { [weak self] result in
                    if case(.success(let res)) = result {
                        guard let `self` = self else { return }
                        self.items.accept(self.items.value + res.items)
                        self.currentPage = res.page
                        self.totalPages = res.totalPageCount
                    }
                }, onDisposed: { [weak self] in
                    self?.isLoading = false
                })
                .disposed(by: disposeBag)
    }

}
