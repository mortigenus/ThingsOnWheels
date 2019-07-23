//
// Created by Ivan Chalov on 2019-07-25.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import UIKit

extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
}


