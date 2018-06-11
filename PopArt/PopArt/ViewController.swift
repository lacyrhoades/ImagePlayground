//
//  ViewController.swift
//  PopArt
//
//  Created by Lacy Rhoades on 6/11/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {

    override func loadView() {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        let before = UIImage(named: "20180323.jpg")!
        let imageView1 = UIImageView(image: before)
        imageView1.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView1)
        
        var filteredImages: [UIImage] = []
        
        
        let colors = [
            UIColor((224, 41, 59)),
            UIColor((165, 210, 153)),
            
            UIColor((50, 56, 168)),
            UIColor((171, 171, 207)),
            
            UIColor((138, 75, 146)),
            UIColor((232, 223, 122)),
            
            UIColor((15, 4, 8)),
            UIColor((233, 73, 119))
        ]
        
        filteredImages.append(before.popArtFiltered(colors[0], colors[1]))
        filteredImages.append(before.popArtFiltered(colors[2], colors[3]))
        filteredImages.append(before.popArtFiltered(colors[4], colors[5]))
        filteredImages.append(before.popArtFiltered(colors[6], colors[7]))
        
        let after = UIImage.imageByTilingImages(filteredImages, intoSize: before.size)
        
        let imageView2 = UIImageView(image: after)
        imageView2.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView2)
        
        if let data = UIImageJPEGRepresentation(after, 1.0) {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let url = urls[0].appendingPathComponent("output.jpg")
            try? data.write(to: url)
        }
        
        self.view = stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension GPUVector4 {
    init(_ color: UIColor) {
        let vals = color.rgb
        self.init(one: GLfloat(vals.0), two: GLfloat(vals.1), three: GLfloat(vals.2), four: GLfloat(1.0))
    }
}

extension UIColor {
    var rgb: (CGFloat, CGFloat, CGFloat) {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            return (fRed, fGreen, fBlue)
        } else {
            return (0, 0, 0)
        }
    }
}

extension UIImage {
    func popArtFiltered(_ color1: UIColor, _ color2: UIColor) -> UIImage {
        let filter = GPUImageSaturationFilter()
        filter.saturation = 0.0
        
        let filtered = filter.image(byFilteringImage: self)
        
        let gradientMap = GPUImageFalseColorFilter()
        gradientMap.firstColor = GPUVector4(color1)
        gradientMap.secondColor = GPUVector4(color2)
        
        return gradientMap.image(byFilteringImage: filtered)
    }
    
    static func image(from: [UIImage]) -> UIImage {
        return UIImage()
    }
}

extension UIImage {
    static func imageByTilingImages(_ inputImages: [UIImage], intoSize size: CGSize) -> UIImage {
        let ratio = Float(size.width) / Float(size.height)
        
        guard inputImages.count > 0 else {
            assert(false, "Cannot tile empty array")
            return UIImage()
        }
        
        guard inputImages.count >= 4 else {
            return inputImages[0].centerCroppedTo(ratio: ratio)
        }
        
        let images = UIImage.pickSelects(count: 4, fromImages: inputImages)
        let img1 = images[0].centerCroppedTo(ratio: ratio)
        let img2 = images[1].centerCroppedTo(ratio: ratio)
        let img3 = images[2].centerCroppedTo(ratio: ratio)
        let img4 = images[3].centerCroppedTo(ratio: ratio)
        
        UIGraphicsBeginImageContextWithOptions(size, false, img1.scale);
        
        let halfWidth = ceil(size.width / 2.0)
        let halfHeight = ceil(size.height / 2.0)
        
        let corner1 = CGRect(x: 0, y: 0, width: halfWidth, height: halfHeight)
        img1.draw(in: corner1)
        let corner2 = CGRect(x: halfWidth, y: 0, width: halfWidth, height: halfHeight)
        img2.draw(in: corner2)
        let corner3 = CGRect(x: 0, y: halfHeight, width: halfWidth, height: halfHeight)
        img3.draw(in: corner3)
        let corner4 = CGRect(x: halfWidth, y: halfHeight, width: halfWidth, height: halfHeight)
        img4.draw(in: corner4)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return img!
    }
    
    func centerCroppedTo(ratio: Float) -> UIImage {
        var height: CGFloat
        var width: CGFloat
        
        let naturalRatio = self.size.width / self.size.height
        let cropRatio = CGFloat(ratio)
        
        if cropRatio >= naturalRatio {
            // fit width
            width = self.size.width
            height = ceil(width / cropRatio)
        } else {
            // fit height
            height = self.size.height
            width = ceil(height * cropRatio)
        }
        
        let xOffset: CGFloat = -1 * (abs(width - self.size.width) / 2.0)
        let yOffset: CGFloat = -1 * (abs(height - self.size.height) / 2.0)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, self.scale);
        
        self.draw(in: CGRect(x: xOffset, y: yOffset, width: self.size.width, height: self.size.height))
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return croppedImage!
    }
    
    static func pickSelects(count: Int, fromImages images: [UIImage]) -> [UIImage] {
        if images.count < count {
            return images
        }
        
        let idealStep: Int = images.count / count
        
        if images.count < idealStep * count {
            return Array(images.prefix(count))
        }
        
        var results: [UIImage] = []
        for i in 0...(count - 1) {
            results.append(images[i * idealStep])
        }
        return results
    }
}

extension UIColor {
    convenience init(_ vals: (Int, Int, Int)) {
        self.init(red: CGFloat(vals.0) / 255, green: CGFloat(vals.1) / 255, blue: CGFloat(vals.2) / 255, alpha: 1.0)
    }
}
