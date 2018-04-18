import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    override func loadView() {
        let original = UIImage(named: "original.jpg")!
        let cropped = original.imageByCropping(toFrame: CGRect(x: 1000, y: 800, width: 200, height: 200))

        let imageViews: [UIImageView] = [original, cropped].map {
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
