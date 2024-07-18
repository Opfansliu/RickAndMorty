//
//  Extension.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
