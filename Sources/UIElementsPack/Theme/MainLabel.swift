//
//  MainLabel.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

//swiftlint:disable cyclomatic_complexity
//swiftlint:disable missing_docs

import Foundation
import UIKit

public enum MainLabelType: String {
    case navHeader, navNormal, navSmall
    case titleHeader, mediumTitleHeader, largeTitleHeader
}

public enum MainLabelColors {
    case black
    case gray
    case blue
    case red
}

public enum MainLabelFonts {
    case a00
    case a01
    case a02
    case a03
    case a04
    case a05
    case a06
    case a07
    case a08
    case a09
    case a10
    case a11
    case a12
    case a13
    case a14
}

public class MainLabel: UILabel {

    @IBInspectable var isDebug: Bool = false {
        didSet {
            if isDebug {
                self.addBorder(color: .red, lineWidth: 1)
            }
        }
    }

    @IBInspectable var normalStyle: String? =  nil {
        didSet {
            if let style = normalStyle, let type = MainLabelType(rawValue: style) {
                self.setStyle(type: type)
            }
        }
    }

    @IBInspectable var localized: String? =  nil {
        didSet {
            guard let localized = localized else {
                return
            }
            self.text = localized.localized
        }
    }
}

extension UILabel {

    /// setStyle
    /// - Parameter type: type style
    public func setStyle(type: MainLabelType) {
        switch type {
        case .navHeader:
            self.setStyle(font: .a11, color: .black)
        case .navNormal:
            self.setStyle(font: .a08)
            // Este color no se debería utilizar, no es parte del guideline para textos estáticos.
            self.textColor = UITheme.Style.Colors.GrisAzulado.level2
        case .navSmall:
            self.setStyle(font: .a05)
        case .titleHeader:
            self.setStyle(font: .a10, color: .black)
        case .mediumTitleHeader:
            self.setStyle(font: .a08, color: .black)
        case .largeTitleHeader:
            self.setStyle(font: .a12, color: .black)
        }
    }

    /// Set or updates font and color of label
    ///
    /// - Parameters:
    ///   - (Optional) font: Font of label, only A00 to A14 fonts defined in guideline.
    ///   - (Optional) color: Color of label, only 4 color of theme: black, gray, red and blue.
    public func setStyle(font: MainLabelFonts? = nil, color: MainLabelColors? = nil) {
        if let font = font {
            self.font = getFont(from: font)
        }
        if let color = color {
            self.textColor = getColor(from: color)
        }
    }

    private func getFont(from: MainLabelFonts) -> UIFont {
        switch from {
        case .a00:
            return UITheme.Style.TipoGrafia.A00
        case .a01:
            return UITheme.Style.TipoGrafia.A01
        case .a02:
            return UITheme.Style.TipoGrafia.A02
        case .a03:
            return UITheme.Style.TipoGrafia.A03
        case .a04:
            return UITheme.Style.TipoGrafia.A04
        case .a05:
            return UITheme.Style.TipoGrafia.A05
        case .a06:
            return UITheme.Style.TipoGrafia.A06
        case .a07:
            return UITheme.Style.TipoGrafia.A07
        case .a08:
            return UITheme.Style.TipoGrafia.A08
        case .a09:
            return UITheme.Style.TipoGrafia.A09
        case .a10:
            return UITheme.Style.TipoGrafia.A10
        case .a11:
            return UITheme.Style.TipoGrafia.A11
        case .a12:
            return UITheme.Style.TipoGrafia.A12
        case .a13:
            return UITheme.Style.TipoGrafia.A13
        case .a14:
            return UITheme.Style.TipoGrafia.A14
        }
    }

    private func getColor(from: MainLabelColors) -> UIColor {
        switch from {
        case .gray:
            return UITheme.Style.Colors.GrisAzulado.level1
        case .red:
            return UITheme.Style.Colors.Rojo.level0
        case .blue:
            return UITheme.Style.Colors.Azul.level0
        case .black:
            return UITheme.Style.Colors.GrisAzulado.level0
        }
    }

    /// Set or updates color of label text. (Only special cases)
    ///
    /// - Parameters:
    ///   - type: Any color of guideline.
    public func setStyleColor(type: MainColorType) { // swiftlint:disable:this cyclomatic_complexity
        switch type {
        case .grisAzuladoLevel0:
            self.textColor = UITheme.Style.Colors.GrisAzulado.level0
        case .grisAzuladoLevel1:
            self.textColor = UITheme.Style.Colors.GrisAzulado.level1
        case .grisAzuladoLevel2:
            self.textColor = UITheme.Style.Colors.GrisAzulado.level2
        case .grisAzuladoLevel3:
            self.textColor = UITheme.Style.Colors.GrisAzulado.level3
        case .grisAzuladoLevel4:
            self.textColor = UITheme.Style.Colors.GrisAzulado.level4
        case .verdeLevel0:
            self.textColor = UITheme.Style.Colors.Verde.level0
        case .verdeLevel1:
            self.textColor = UITheme.Style.Colors.Verde.level1
        case .verdeLevel2:
            self.textColor = UITheme.Style.Colors.Verde.level2
        case .verdeLevel3:
            self.textColor = UITheme.Style.Colors.Verde.level3
        case .verdeLevel4:
            self.textColor = UITheme.Style.Colors.Verde.level4
        case .rojoLevel0:
            self.textColor = UITheme.Style.Colors.Rojo.level0
        case .rojoLevel1:
            self.textColor = UITheme.Style.Colors.Rojo.level1
        case .rojoLevel2:
            self.textColor = UITheme.Style.Colors.Rojo.level2
        case .rojoLevel3:
            self.textColor = UITheme.Style.Colors.Rojo.level3
        case .rojoLevel4:
            self.textColor = UITheme.Style.Colors.Rojo.level4
        case .azulLevel0:
            self.textColor = UITheme.Style.Colors.Azul.level0
        case .azulLevel1:
            self.textColor = UITheme.Style.Colors.Azul.level1
        case .azulLevel2:
            self.textColor = UITheme.Style.Colors.Azul.level2
        case .azulLevel3:
            self.textColor = UITheme.Style.Colors.Azul.level3
        case .azulLevel4:
            self.textColor = UITheme.Style.Colors.Azul.level4
        case .amarilloLevel0:
            self.textColor = UITheme.Style.Colors.Amarillo.level0
        case .amarilloLevel1:
            self.textColor = UITheme.Style.Colors.Amarillo.level1
        case .amarilloLevel2:
            self.textColor = UITheme.Style.Colors.Amarillo.level2
        case .amarilloLevel3:
            self.textColor = UITheme.Style.Colors.Amarillo.level3
        case .amarilloLevel4:
            self.textColor = UITheme.Style.Colors.Amarillo.level4
        case .negro:
            self.textColor = UITheme.Style.Colors.Negro.level0
        case .blanco:
            self.textColor = UITheme.Style.Colors.Blanco.level0
        }
    }
}
