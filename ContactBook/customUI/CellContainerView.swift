//
//  ContainerCell.swift
//  ContactBook
//
//  Created by Alex on 05.01.2022.
//

import UIKit

@IBDesignable class CellContainerView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
