//
// Created by Ivan Chalov on 2019-07-24.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThingOnWheelsModelListViewModel: PaginatedViewModel<ThingOnWheelsModel> {

    let manufacturer: Manufacturer

    init(with manufacturer: Manufacturer) {
        self.manufacturer = manufacturer
    }

    override func request() -> Observable<Result<PaginatedResponse<ThingOnWheelsModel>, Error>> {
        let pageParams = PageParams(page: currentPage?.advanced(by: 1) ?? 0)
        return AppEnvironment.current.apiClient.fetchModels(for: manufacturer, page: pageParams)
    }

    func message(with selectedModel: ThingOnWheelsModel) -> String {
        return "Manufacturer: \(manufacturer.name)\nModel: \(selectedModel.name)"
    }

}
