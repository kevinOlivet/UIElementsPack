//
//  UIButton+Extensions.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

///public extension UIButton
public extension UIButton {
    /// addLightBlueStyle
    func addLightBlueStyle() {
        addBlueStyle()
        addLightTitleStyle()
    }

    /// addBlueStyle
    func addBlueStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UITheme.Style.Colors.Azul.level1.cgColor
        self.setTitleColor(UITheme.Style.Colors.Azul.level1, for: .normal)
        self.tintColor = UITheme.Style.Colors.Azul.level1
        self.layer.cornerRadius = 5
    }

    /// addLightTitleStyle
    func addLightTitleStyle() {
        self.titleLabel?.font = UIFont.main_normalFont(withSize: 12)
    }
}
