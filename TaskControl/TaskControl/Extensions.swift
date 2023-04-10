//
//  Extensions.swift
//  TaskControl
//
//  Created by user on 29.03.23.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(shadowColor: UIColor = .gray,shadowOffset: CGSize = CGSize(width: 4, height: 4),shadowOpacity: Float = 0.8,shadowRadius: Double = 2 ) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
    
    func translatesAutoresizingMaskIntoSubviews() {
        subviews.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
