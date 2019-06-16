//
//  PhotoCount.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 03/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class PhotoCount {
    var collection = [UIImage]()
    //add images to a collection
    func add(_ image: UIImage) {
        self.collection.append(image)
    }
    // selection of the right layout according to the number of photos
    func isValid(with selectedLayout: Layout.LayoutGuideline?) ->Bool {
        guard let layout = selectedLayout else { return false }
        switch layout {
        case let .layout(number) where number == 3:
            return self.collection.count >= 3
        case let .layout(number) where number == 4:
            return self.collection.count == 4
        default: return false
        }
    }
}
