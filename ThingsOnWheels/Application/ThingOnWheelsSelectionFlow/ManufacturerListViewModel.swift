//
// Created by Ivan Chalov on 2019-07-24.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManufacturerListViewModel: PaginatedViewModel<Manufacturer> {

    override func request() -> Observable<Result<PaginatedResponse<Manufacturer>, Error>> {
        let pageParams = PageParams(page: currentPage?.advanced(by: 1) ?? 0)
        return AppEnvironment.current.apiClient.fetchManufacturers(page: pageParams)
    }

}
