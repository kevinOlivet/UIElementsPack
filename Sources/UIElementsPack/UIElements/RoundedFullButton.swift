//
//  RoundedFullButton.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import BasicCommons

open class RoundedFullButton: UIButton {

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 24
        self.backgroundColor = UITheme.Style.Colors.Verde.level0
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.main_normalFont(withSize: 15)
    }
}
