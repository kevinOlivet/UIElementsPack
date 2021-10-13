//
//  LogInViewController.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

public enum ViewState: Int {
    case active
    case error
    case inactive
    case enabled
    case disabled
}

/// This enum contains all the styles like colors and fonts used in the app
/// First: it gets extended by UIThemeStyle.swift which contains the new styles.
/// Second: it gets extended by Colors.swift. This should be removed ASAP, prefering the new style file.
public enum UITheme { }

/// Change UIButton properties according to main theme
public extension UIButton {
    /// enable
    /// - Parameter animated: animated flag
    func enable(animated: Bool = true) {
        let disableClosure:() -> Void = {
            self.isEnabled = true
            self.backgroundColor = UITheme.Style.Colors.Verde.level1
            self.setTitleColor(UITheme.Style.Colors.Blanco.level0, for: .normal)
        }

        if animated {
            UIButton.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: disableClosure,
                completion: nil
            )
        } else {
            disableClosure()
        }
    }

    /// disable
    /// - Parameter animated: animated flag
    func disable(animated: Bool = true) {
        let disableClosure:() -> Void = {
            self.isEnabled = false
            self.backgroundColor = UITheme.Style.Colors.GrisAzulado.level3
            self.setTitleColor(
                UITheme.Style.Colors.GrisAzulado.level2,
                for: .normal
            )
        }

        if animated {
            UIButton.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: disableClosure,
                completion: nil
            )
        } else {
            disableClosure()
        }
    }
}

/// Change UILabel properties according to main theme
public extension UILabel {

    /// setCircularStyle
    func setCircularStyle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }

    /// setCircularStyleWithBorder
    func setCircularStyleWithBorder() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UITheme.Style.Colors.GrisAzulado.level2.cgColor
        self.layer.borderWidth = 1
    }

    /// setCircularStyleWithDashedBorder
    func setCircularStyleWithDashedBorder() {
        let shapeLayer = CAShapeLayer()
        let radius: CGFloat = self.frame.width / 2
        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius),
            cornerRadius: radius
            ).cgPath
        shapeLayer.position = CGPoint(x: self.frame.midX - radius, y: self.frame.midY - radius)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UITheme.Style.Colors.GrisAzulado.level2.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern =  [4, 2]
        self.layer.addSublayer(shapeLayer)
    }

    /// setActiveTextColor
    func setActiveTextColor() {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level1
    }

    /// setNumberOfItemsAtHeaderStyle
    func setNumberOfItemsAtHeaderStyle() {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level2
        self.font = UIFont(name: self.font.fontName, size: 15.0) // swiftlint:disable:this uitheme_not_UIFont
    }

    /// setActiveTextColorBold
    func setActiveTextColorBold() {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level1
        self.font = UIFont.boldSystemFont(ofSize: self.font.pointSize)
    }

    /// setSectionTitleColorAndSize
    func setSectionTitleColorAndSize() {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level1
        self.font = UIFont(name: self.font.fontName, size: 15.0) // swiftlint:disable:this uitheme_not_UIFont
    }

    /// setFontSize
    /// - Parameter newFontSize: newFontSize value
    func setFontSize(newFontSize: Double) {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level1
        self.font = UIFont(name: self.font.fontName, size: CGFloat(newFontSize)) // swiftlint:disable:this uitheme_not_UIFont line_length
    }

    /// setCollectionViewHeader
    func setCollectionViewHeader() {
        self.textColor = UITheme.Style.Colors.GrisAzulado.level0
        self.font = UIFont.main_semiBoldFont(withSize: 16)
    }
}

extension UIImageView {
    func setBorder() {
        self.layer.borderColor = UITheme.Style.Colors.GrisAzulado.level1.cgColor
        self.layer.borderWidth = 0.5
    }

    func setCircularStyle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

extension UICollectionViewCell {
    func setTopBorderWithInitialXPoint(frameX: CGFloat) {
        let topLine = CALayer()
        topLine.frame = CGRect(x: frameX, y: 0, width: self.frame.width, height: 0.5)
        topLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(topLine)
    }

    func setBottomBorderWithInitialXPoint(frameX: CGFloat) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: frameX, y: self.frame.height - 1, width: self.frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
    }
}
