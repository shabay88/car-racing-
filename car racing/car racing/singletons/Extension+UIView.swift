//
//  Extension+UIView.swift
//  car racing
//
//  Created by Роман Шабаев on 29.09.2021.
//

import UIKit

extension UIView {
    
    func setRoundedCorners(with radius: CGFloat = 30) {
        layer.cornerRadius = min(radius, min(frame.width / 2, frame.height / 2))
    }
        
}
