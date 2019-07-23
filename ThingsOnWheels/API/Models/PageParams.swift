//
//  PageParams.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 24/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import Foundation

struct PageParams {
    let page: Int
    let pageSize: Int

    init(page: Int = 0, pageSize: Int = 15) {
        self.page = page
        self.pageSize = pageSize
    }
}
