import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    override func loadView() {
        var images: [(String, UIImage)] = []
        
        let original = UIImage(named: "original.jpg")!
        
        images.append(( "Original", original ))
        
        var zoomLevel: CGFloat = 1.5
        var centerOffset = CGPoint(x: -225, y: -435)
        
        images.append((
            "\(zoomLevel)x Zoom",
            original.imageByCropping(withZoom: zoomLevel, offset: centerOffset)
        ))
        
        zoomLevel = zoomLevel * 2
        centerOffset = centerOffset |> multiply(by: 2)

        images.append((
            "\(zoomLevel)x Zoom",
            original.imageByCropping(withZoom: zoomLevel, offset: centerOffset)
        ))

        zoomLevel = zoomLevel * 2
        centerOffset = centerOffset |> multiply(by: 2)

        images.append((
            "\(zoomLevel)x Zoom",
            original.imageByCropping(withZoom: zoomLevel, offset: centerOffset)
        ))

        zoomLevel = zoomLevel * 2
        centerOffset = centerOffset |> multiply(by: 2)

        images.append((
            "\(zoomLevel)x Zoom",
            original.imageByCropping(withZoom: zoomLevel, offset: centerOffset)
        ))

        let arbitraryFrame = CGRect(origin: CGPoint(x: 1000, y: 100), size: CGSize(width: 100, height: 820))

        images.append((
            "Arbitrary Crop",
            original.imageByCropping(toFrame: arbitraryFrame)
        ))
        
        let imageViews = images.reduce([], {
            (soFar, each) -> [UIView] in
            var soFar = soFar
            
            let view = UIImageView(image: each.1)
            view.contentMode = .scaleAspectFit
            view.backgroundColor = .gray
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1.0
            soFar.append(view)
            
            let label = UILabel()
            label.text = each.0
            label.textColor = .white
            soFar.append(label)
            
            return soFar
        })
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        self.view = stackView
    }
}

PlaygroundPage.current.liveView = ViewController()
