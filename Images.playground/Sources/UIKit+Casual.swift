//
//  UIKit+Casual.swift
//  ImageEditing
//
//  Created by Lacy Rhoades on 4/18/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import UIKit

extension CGPoint {
    init(size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
}

extension CGRect {
    init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
}
