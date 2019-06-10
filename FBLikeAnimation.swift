//
//  FBLikeAnimation.swift
//  FBStreamAnimation
//
//  Created by Kamal on 10/06/19.
//  Copyright © 2019 Lets Build That App. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func loadAnimation() {
        (0...30).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    fileprivate func generateAnimatedViews() {
        let image = #imageLiteral(resourceName: "thumbs_up")//drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        UIApplication.getTopViewController()?.view.addSubview(imageView)
    }
    
    fileprivate  func customPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        let xValue = CGFloat(drand48()) * UIScreen.main.bounds.width
        path.move(to: CGPoint(x:  xValue, y: UIScreen.main.bounds.height))
        
        let endPoint = CGPoint(x: CGFloat(drand48()) * UIScreen.main.bounds.width, y: -50)
        
        let randomXShift = CGFloat(drand48() * 400)
        let cp1 = CGPoint(x: randomXShift, y: UIScreen.main.bounds.size.height / 3)
        let cp2 = CGPoint(x:  randomXShift, y: UIScreen.main.bounds.size.height * 2 / 3)
        
        print(randomXShift)
        
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
}


extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

