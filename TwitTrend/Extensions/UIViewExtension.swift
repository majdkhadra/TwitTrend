//
//  UIViewExtension.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import UIKit

extension UIView {
    func addConstraints(constraints: [String], metrics: [String : CGFloat], views: [String: UIView] ) {
        for view in views {
            views[view.key]?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for constraint in constraints {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: metrics, views: views))
        }
    }
    
    func addSubviews(subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
}
