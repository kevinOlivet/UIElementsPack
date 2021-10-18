//
//  RoundedButton.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import CommonsPack
import UIKit

open class RoundedButton: UIButton {
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView() {
        self.layer.cornerRadius = 0.0
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}
