//
//  ContainerView.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 03/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

//Protocol
protocol ContainerViewDelegate {
    func didAction(container: ContainerView)
}
// Creation of the object ContainerView
public class ContainerView: UIView {
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var imageView: UIImageView?
    
    // Delegator
    var delegate: ContainerViewDelegate?
    
    //Delegate
    @IBAction func showImagePicker(_ sender: UIButton) {
        delegate?.didAction(container: self)
    }
}
