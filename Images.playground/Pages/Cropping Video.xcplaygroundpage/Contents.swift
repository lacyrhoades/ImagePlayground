import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    override func loadView() {
        let original = Bundle.main.path(forResource: "original.mp4", ofType: nil)
        
        print(original)
        
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        self.view = stackView
    }
}

PlaygroundPage.current.liveView = ViewController()
