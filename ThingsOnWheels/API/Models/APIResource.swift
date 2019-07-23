//
// Created by Ivan Chalov on 2019-07-24.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import Foundation

protocol APIResource {
    var id: String { get }
    var name: String { get }
    init(id: String, name: String)
}
