//
//  AvatarImageView.swift
//  ContactBook
//
//  Created by Alex on 06.01.2022.
//

import UIKit

@IBDesignable class AvatarImageView: UIImageView {
    
    @IBInspectable var circleImage: Bool = false {
        didSet {
            guard circleImage else { layer.cornerRadius = 0; return}
            layer.cornerRadius = layer.frame.height / 2
        }
    }
    
}
