import UIKit
import PlaygroundSupport
import GPUImage

class ViewController : UIViewController {
    override func loadView() {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        let before = UIImageView(image: UIImage(named: "8388"))
        before.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(before)
        
        let after = UIImageView(image: UIImage(named: "8388"))
        after.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(after)
        
        self.view = stackView
        self.view.backgroundColor = UIColor.red
    }
}

PlaygroundPage.current.liveView = ViewController()
