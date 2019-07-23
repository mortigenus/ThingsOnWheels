//
//  NamedResourceCellViewModel.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 24/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NamedResourceCellViewModel {
    let nameText: String
    let backgroundColor: UIColor

    init(_ resource: APIResource, _ row: Int) {
        self.nameText = resource.name
        self.backgroundColor = row.isMultiple(of: 2) ? .lightGray : .white
    }

}
