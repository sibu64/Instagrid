//
//  ShareImage.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 08/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

//protocol
protocol InstagridImageDelegate {
    func didSharedSuccess()
}

class InstagridImage {
    //Delegator
    var delegate: InstagridImageDelegate?
    
    // Definition of the share function + sucess alert
    func share(with image: UIImage, controller: UIViewController) {
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activity.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.delegate?.didSharedSuccess()
            }
        }
        
        controller.present(activity, animated: true, completion: nil)
    }
}
