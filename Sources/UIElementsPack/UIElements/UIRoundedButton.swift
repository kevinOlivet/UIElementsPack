//
//  UIRoundedButton.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

open class UIRoundedButton: UIButton {

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.layer.borderColor = UITheme.Style.Colors.Verde.level0.cgColor
        self.setTitleColor(UITheme.Style.Colors.Verde.level0, for: .normal)
    }
}
