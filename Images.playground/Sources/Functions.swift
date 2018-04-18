//
//  Functions.swift
//  ImageEditing
//
//  Created by Lacy Rhoades on 4/18/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import UIKit

func subtract(_ size: CGSize) -> (CGSize) -> CGSize {
    return {
        (
            $0.width - size.width,
            $0.height - size.height
            ) |> CGSize.init
    }
}

func multiply(by scalar: CGFloat?) -> (CGSize) -> CGSize {
    return {
        (
            $0.width * (scalar ?? 1),
            $0.height * (scalar ?? 1)
            ) |> CGSize.init
    }
}

func divide(by scalar: CGFloat?) -> (CGSize) -> CGSize {
    return {
        (
            $0.width / (scalar ?? 1),
            $0.height / (scalar ?? 1)
            ) |> CGSize.init
    }
}

func multiply(by scalar: CGFloat?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x * (scalar ?? 1),
            $0.y * (scalar ?? 1)
            ) |> CGPoint.init
    }
}

func offset(by distance: CGPoint?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x + (distance?.x ?? 0),
            $0.y + (distance?.y ?? 0)
            ) |> CGPoint.init
    }
}

func invert() -> (CGSize) -> CGSize {
    return {
        $0 |> multiply(by: -1)
    }
}

func invert() -> (CGPoint) -> CGPoint {
    return {
        $0 |> multiply(by: -1)
    }
}

func half() -> (CGSize) -> CGSize {
    return {
        $0 |> divide(by: 2)
    }
}

func zoom(by scalar: CGFloat?) -> (CGRect) -> CGRect {
    return {
        (
            $0.size
                |> multiply(by: scalar)
                |> subtract($0.size)
                |> invert()
                |> half()
                |> CGPoint.init,
            $0.size
                |> multiply(by: scalar)
        ) |> CGRect.init
    }
}

func offset(by distance: CGPoint?) -> (CGRect) -> CGRect {
    return {
        (
            $0.origin |> offset(by: distance),
            $0.size
            ) |> CGRect.init
    }
}

