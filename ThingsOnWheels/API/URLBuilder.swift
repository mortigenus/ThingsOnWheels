//
// Created by Ivan Chalov on 2019-07-24.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import Foundation

struct URLBuilder {
    let baseURL: URL

    func manufacturerListURL(for page: PageParams) -> URL {
        let url = baseURL.appendingPathComponent(Config.Endpoints.manufacturer)
        return build(url: url, for: page).url!
    }

    func modelListURL(for manufacturerId: String, page: PageParams) -> URL {
        let url = baseURL.appendingPathComponent(Config.Endpoints.model)
        let urlComponents = build(url: url, for: page, ["manufacturer": manufacturerId])
        return urlComponents.url!
    }

    private func build(url: URL, for page: PageParams, _ additionalParams: [String: String] = [:]) -> URLComponents {
        var listURLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let commonParams = [
            "page": "\(page.page)",
            "pageSize": "\(page.pageSize)",
            Config.Secret.key: Config.Secret.value
        ]
        let finalDict = additionalParams.merging(commonParams, uniquingKeysWith: { $1 })
        listURLComponents.queryItems = finalDict.map({ URLQueryItem(name: $0.key, value: $0.value) })
        return listURLComponents
    }

}
