//
//  Layout.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 11/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation

// association of the number of photos according of the layouts
struct Layout {
    enum LayoutGuideline {
        case layout(Int)
    }
    var layoutOne: LayoutGuideline = .layout(3)
    var layoutTwo: LayoutGuideline = .layout(3)
    var layoutThree: LayoutGuideline = .layout(4)
    var selectedLayout: LayoutGuideline?
}
