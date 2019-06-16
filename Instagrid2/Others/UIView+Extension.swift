//
//  TransformImage.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 08/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

// Transformation of UIView to UIImage
extension UIView {
    var toImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}

// Setting up the alerts 
extension UIViewController {
    func presentAlert(title: String = "Important message!", message: String) {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let button = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
        })
        controller.addAction(button)
        self.present(controller, animated: true, completion: nil)
    }
}
