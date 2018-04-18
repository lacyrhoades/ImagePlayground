import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    override func loadView() {
        var images: [UIImage] = []
        
        let original = UIImage(named: "original.jpg")!
        
        images.append( original )
        
        var zoomLevel: CGFloat = 2.0
        let contentOffset = CGPoint(x: -250, y: -600)
        
        images.append(
            original.imageByCropping(withZoom: zoomLevel, offset: contentOffset)
        )
        
        zoomLevel = zoomLevel * 2
        let contentOffset2 = contentOffset |> multiply(by: 2)
        
        images.append(
            original.imageByCropping(withZoom: zoomLevel, offset: contentOffset2)
        )
        
        let cropFrame = CGRect(origin: CGPoint(x: 1000, y: 770), size: CGSize(width: 100, height: 220))
        
        images.append(
            original.imageByCropping(toFrame: cropFrame)
        )

        let imageViews: [UIImageView] = images.map {
            let view = UIImageView(image: $0)
            view.contentMode = .scaleAspectFit
            view.backgroundColor = .gray
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1.0
            return view
        }
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        self.view = stackView
    }
}

PlaygroundPage.current.liveView = ViewController()

func multiply(by scalar: CGFloat?) -> (CGPoint) -> CGPoint {
    return {
        (
            $0.x * (scalar ?? 1),
            $0.y * (scalar ?? 1)
            ) |> CGPoint.init
    }
}
