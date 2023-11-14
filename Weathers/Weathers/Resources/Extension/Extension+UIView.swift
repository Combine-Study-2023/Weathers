//
//  Extension+UIView.swift
//  Weather-App
//
//  Created by yeonsu on 11/8/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
