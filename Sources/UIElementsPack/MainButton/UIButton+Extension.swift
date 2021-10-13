//
//  UIButton+Extension.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

//swiftlint:disable cyclomatic_complexity

import BasicCommons
import Foundation

//swiftlint:disable missing_docs

extension UIButton {

    public static let buttonHeight: CGFloat = 48.0

    public enum ButtonTypes {
        case first
        case basic
        case disable
        case second
        case secondEnabled
        case cancel
        case alert
        case discard
        case whiteOutline
        case greenOutline
        case redOutline
        case white
        case delete
        case cancelDelete
        case cancelBlack
        case none
    }

    public func setStyle(_ type: UIButton.ButtonTypes) {
        switch type {
        case .first, .basic:
            setBasicStyle()
        case .disable:
            setDisableStyle()
        case .second:
            setSecondaryStyle()
        case .secondEnabled:
            setSecondaryEnabledStyle()
        case .cancel:
            setCancelStyle()
        case .alert:
            setAlertStyle()
        case .discard:
            setDismissStyle()
        case .whiteOutline:
            setWhiteOutline()
        case .greenOutline:
            setGreenOutline()
        case .white:
            setWhiteStyle()
        case .redOutline:
            setRedOutline()
        case .delete:
            setDeleteStyle()
        case .cancelDelete:
            setCancelDeleteStyle()
        case .cancelBlack:
            setCancelBlackStyle()
        case .none:
            setNoneStyle()
        }
    }

    public func setBasicStyle() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = UITheme.Style.Colors.Verde.level1
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A09
        self.setTitleColor(.white, for: .normal)
        self.alpha = 1
        sharedSetup()
    }

    public func setNoneStyle() {
        self.isUserInteractionEnabled = true
        self.titleLabel?.textColor = UITheme.Style.Colors.Azul.level0
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A08
        self.setTitleColor(UITheme.Style.Colors.Azul.level0, for: .normal)
        self.alpha = 1
    }

    public func setBasicDisabledStyle() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UITheme.Style.Colors.GrisAzulado.level3
        self.titleLabel?.textColor = UITheme.Style.Colors.GrisAzulado.level2
        self.setTitleColor(.white, for: UIControl.State.disabled)
        self.isEnabled = false
        sharedSetup()
    }

    public func setDisableStyle() {
        sharedSetup()
        self.backgroundColor = UITheme.Style.Colors.GrisAzulado.level3
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A09
        self.setTitleColor(UITheme.Style.Colors.GrisAzulado.level2, for: .normal)
        self.layer.borderColor = UITheme.Style.Colors.GrisAzulado.level3 .cgColor
        self.isUserInteractionEnabled = false
    }

    public func setAlertStyle() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = UITheme.Style.Colors.Rojo.level1
        self.titleLabel?.textColor = .white
        self.setTitleColor(.white, for: UIControl.State.normal)
        sharedSetup()
    }

    public func setSecondaryStyle() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = UITheme.Style.Colors.Verde.level2.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = UITheme.Style.Colors.Verde.level2
        self.setTitleColor(UITheme.Style.Colors.Verde.level2, for: UIControl.State.normal)
        sharedSetup()
    }

    public func setSecondaryEnabledStyle() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = UITheme.Style.Colors.Verde.level2.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = UITheme.Style.Colors.Verde.level2
        self.setTitleColor(UITheme.Style.Colors.Verde.level2, for: UIControl.State.normal)
        sharedSetup()
    }

    public func setDismissStyle() {

        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.titleLabel?.textColor = UITheme.Style.Colors.Verde.level1
        self.setTitleColor(UITheme.Style.Colors.Verde.level1, for: .normal)
        sharedSetup()
        self.layer.borderWidth = 1
        self.layer.borderColor = UITheme.Style.Colors.Verde.level1.cgColor
    }

    public func setCancelStyle() {

        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.titleLabel?.textColor = UITheme.Style.Colors.GrisAzulado.level1
        self.setTitleColor(UITheme.Style.Colors.GrisAzulado.level1, for: .normal)
        sharedSetup()
        self.layer.borderWidth = 1
        self.layer.borderColor = UITheme.Style.Colors.GrisAzulado.level1.cgColor
    }

    public func setDeleteStyle() {
        let redColor = UITheme.Style.Colors.Rojo.level1
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = redColor.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = redColor
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A09
        self.setTitleColor(redColor, for: .normal)
        self.alpha = 1
        sharedSetup()
    }

    public func setCancelDeleteStyle() {
        let grayColor = UITheme.Style.Colors.GrisAzulado.level1
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = grayColor.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = grayColor
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A09
        self.setTitleColor(grayColor, for: .normal)
        self.alpha = 1
        sharedSetup()
    }

    public func setCancelBlackStyle() {
        let blackColor = UITheme.Style.Colors.GrisAzulado.level0
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = blackColor.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = blackColor
        self.titleLabel?.font = UITheme.Style.TipoGrafia.A09
        self.setTitleColor(blackColor, for: .normal)
        self.alpha = 1
        sharedSetup()
    }

    // MARK: Shared setup

    func setWhiteOutline() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.white, for: .normal)
        sharedSetup()
    }

    // MARK: Green SetUp

    func setGreenOutline() {
        setSecondaryEnabledStyle()
        self.titleLabel?.font = UIFont.main_normalFont(withSize: 11.0)
    }

    func setWhiteStyle() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sharedSetup()
    }

    func setRedOutline() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.borderColor = UITheme.Style.Colors.Rojo.level0.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = UITheme.Style.Colors.Rojo.level0
        self.setTitleColor(UITheme.Style.Colors.Rojo.level0, for: UIControl.State.normal)
        sharedSetup()
    }

    private func sharedSetup() {
        self.addRoundedCorners(cornerRadius: 3)
        self.titleLabel?.font = UIFont.main_normalFont(withSize: 15)
        self.titleLabel?.textAlignment = .center
        self.setTitle(self.titleLabel?.text?.uppercased(), for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }

}
