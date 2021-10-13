//
//  MainGradientView.swift
//  BasicUIElements
//
//  Copyright © Jon Olivet
//

//swiftlint:disable missing_docs

import Foundation
import UIKit

/// enum MainGradientView
public enum MainGradientView {
    case whiteToBlue
    case whiteToBlueShort
    case whiteOnly
    case blueOnly
    case clear

    /// gradientLayer
    ///
    /// :CAGradientLayer variable to handle the gradient
    public var gradientLayer: CAGradientLayer {

        let gradient = CAGradientLayer()
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [0, 1]

        switch self {
        case .whiteToBlue:
            gradient.colors = [
                UITheme.Style.Colors.Blanco.level0.cgColor,
                UITheme.Style.Colors.Azul.level4.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
            return gradient
        case .whiteToBlueShort:
            gradient.colors = [
                UITheme.Style.Colors.Blanco.level0.cgColor,
                UITheme.Style.Colors.Azul.level4.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            return gradient
        case .whiteOnly:
            gradient.colors = [
                UITheme.Style.Colors.Blanco.level0.cgColor,
                UITheme.Style.Colors.Blanco.level0.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
            return gradient
        case .blueOnly:
            gradient.colors = [
                UITheme.Style.Colors.Azul.level4.cgColor,
                UITheme.Style.Colors.Azul.level4.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
            return gradient
        case .clear:
            gradient.colors = [UIColor.clear.cgColor,
                               UIColor.clear.cgColor]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
            return gradient
        }
    }
}
