//
//  APIClient.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 24/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    private let urlBuilder = URLBuilder(baseURL: Config.baseURL)
    private let urlSession: URLSession

    init() {
        let config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
    }

    func fetchManufacturers(
            page: PageParams
    ) -> Observable<Result<PaginatedResponse<Manufacturer>, Error>> {
        return fetch(urlBuilder.manufacturerListURL(for: page))
    }

    func fetchModels(
            for manufacturer: Manufacturer, page: PageParams
    ) -> Observable<Result<PaginatedResponse<ThingOnWheelsModel>, Error>> {
        return fetch(urlBuilder.modelListURL(for: manufacturer.id, page: page))
    }

    private func fetch<T: APIResource>(_ url: URL) -> Observable<Result<PaginatedResponse<T>, Error>> {
        let urlRequest = URLRequest(url: url)
        return urlSession.rx.data(request: urlRequest)
                .map({ data in
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PaginatedResponse<T>.self, from: data)
                    return .success(result)
                })
                .observeOn(MainScheduler.asyncInstance)
    }

}
