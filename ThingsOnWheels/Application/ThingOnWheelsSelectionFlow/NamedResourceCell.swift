//
//  NamedResourceCell.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 24/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import UIKit

class NamedResourceCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    var viewModel: NamedResourceCellViewModel! {
        didSet {
            name.text = viewModel.nameText
            backgroundColor = viewModel.backgroundColor
        }
    }

}

extension NamedResourceCell: NibLoadableView {}
