//
//  PaginatedResponse.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 24/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import Foundation

struct PaginatedResponse<T> {
    let page: Int
    let pageSize: Int
    let totalPageCount: Int
    let items: [T]
}

extension PaginatedResponse: Decodable where T: APIResource {
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case items = "wkda"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try container.decode(Int.self, forKey: .page)
        self.pageSize = try container.decode(Int.self, forKey: .pageSize)
        self.totalPageCount = try container.decode(Int.self, forKey: .totalPageCount)

        let itemsDict = try container.decode([String: String].self, forKey: .items)
        self.items = itemsDict
                .sorted(by: { $0.key < $1.key })
                .map({ T(id: $0.key, name: $0.value) })
    }
}
