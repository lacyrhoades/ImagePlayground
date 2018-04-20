//import UIKit
//
///**
// Item quick-edit
//
// The item is editable. The aspect ratio of the image is not editable, but among the editable parameters are both "what is the center" of the image, and "how zoomed in" is the image.
//
// These are stored as:
//
// 1) A floating point number for the "zoom level" where 1 is not zoomed at all.
// 2) A pair of floating point numbers ( a point ) expressing how offset the center of the image is.
// Center is defined as 0,0. 1,1 is the lower-right corner.
//
// For example:
//*/
//

import UIKit

// User parameters from the UI, scrollView, pinch and zoom etc.

// How "zoomed in" is the scrollView?
let zoomScale: CGFloat = 4

// Offset of the scrollView (top left offset) (in Screen Coordinates)
// Also known as content offset of a scrollView
let originOffset = CGPoint(x: 300, y: 300)

// Size of the scrollView's bounds (in Screen Coordinates)
let windowSize = CGSize(width: 100, height: 100)

func toNormalized(_ windowSize: CGSize, _ zoomScale: CGFloat, _ originOffset: CGPoint) -> CGPoint {
    let windowCenter = windowSize |> CGPoint.init |> divide(by: 2)
    let nativeSize = windowSize |> CGPoint.init |> multiply(by: zoomScale)
    let nativeCenter = nativeSize |> divide(by: 2)
    return windowCenter |> add(originOffset) |> subtract(nativeCenter) |> divide(by: nativeCenter)
}

// The fractional "center" of the crop window (where 0,0 is center)
let normalizedOffset = toNormalized(windowSize, zoomScale, originOffset)

// Size of the original
let nativeResolution = CGSize(width: 2000, height: 2000)

// The actual pixel point "center" of the crop
// In terms of the native resolution
// This can be applied along with the zoom value
// Via the relevant "cropping" method on UIImage
let pixelCenter = normalizedOffset |> multiply(by: nativeResolution)
