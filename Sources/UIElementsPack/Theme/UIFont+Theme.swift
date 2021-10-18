//
//  UIFont+Theme.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

private class MyDummyClass {}

extension UIFont {

     private static func loadFontWith(name: String) {
        let frameworkBundle = Bundle(for: MyDummyClass.self)
        let resourceBundle = Bundle(url: frameworkBundle.bundleURL)
        let pathForResourceString = resourceBundle?.path(forResource: name, ofType: "otf")
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>?

        if !CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) {
            debugPrint(
                """
Failed to register font.
Register graphics font failed.
This font may have already been registered in the main bundle.
"""
            )
        }
    }

    private static func mainFont(name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) { // swiftlint:disable:this uitheme_not_UIFont
            return font
        } else {
            loadFontWith(name: name)
            return UIFont(name: name, size: size)! // swiftlint:disable:this uitheme_not_UIFont
        }
    }
    /// Return the default font type used in the app
    ///
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_normalFont(withSize size: CGFloat) -> UIFont {
        mainFont(name: "overpass-regular", size: size)
    }

    /// Return the default bold font type
    ///
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_boldFont(withSize: CGFloat, weight: CGFloat = UIFont.Weight.bold.rawValue) -> UIFont {
        UIFont.systemFont(ofSize: withSize, weight: UIFont.Weight(rawValue: weight))
    }

    /// Return the default  bold type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_boldFont(withSize size: CGFloat) -> UIFont {
        mainFont(name: "overpass-bold", size: size)
    }

    /// Return the default semi bold type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_semiBoldFont(withSize size: CGFloat) -> UIFont {
        mainFont(name: "overpass-semibold", size: size)
    }

    /// Return the default semi bold type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_italicFont(withSize size: CGFloat) -> UIFont {
        mainFont(name: "overpass-italic", size: size)
    }

    /// Return the default light type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_LightFont(withSize size: CGFloat) -> UIFont {
        mainFont(name: "overpass-light", size: size)
    }

    /// Return the default medium type
    ///
    /// - Parameters:
    /// - Parameter withSize: The font size
    /// - Returns: An instance of UIFont
    public static func main_mediumFont(withSize: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: withSize, weight: UIFont.Weight.medium)
    }

    /// setupMainFonts
    /// - Parameter fonts: fonts to setup
    public static func setupMainFonts(fonts: [String]) {
        fonts.forEach { name in
            loadFontWith(name: name)
        }
    }
}

/// Returns NSMutableAttributedString according to Main fonts
public extension NSMutableAttributedString {
    /// main_normal
    /// - Parameter text: text to handle
    /// - Parameter size: size value
    @discardableResult
    func main_normal(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        self.append(
            NSMutableAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.font: UIFont.main_normalFont(withSize: size)
                ]
            )
        )
        return self
    }

    /// main_bold
    /// - Parameter text: text to handle
    /// - Parameter size: size value
    @discardableResult
    func main_bold(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        self.append(
            NSMutableAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.font: UIFont.main_boldFont(withSize: size)
                ]
            )
        )
        return self
    }

    /// main_semiBold
    /// - Parameter text: text to handle
    /// - Parameter size: size value
    @discardableResult
    func main_semiBold(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        self.append(
            NSMutableAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.font: UIFont.main_semiBoldFont(withSize: size)
                ]
            )
        )
        return self
    }

    /// main_light
    /// - Parameter text: text to handle
    /// - Parameter size: size value
    @discardableResult
    func main_light(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        self.append(
            NSMutableAttributedString(
                string: text,
                attributes: [NSAttributedString.Key.font: UIFont.main_LightFont(withSize: size)]
            )
        )
        return self
    }

    /// main_medium
    /// - Parameter text: text to handle
    /// - Parameter size: size value
    @discardableResult
    func main_medium(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        self.append(
            NSMutableAttributedString(
                string: text,
                attributes: [NSAttributedString.Key.font: UIFont.main_mediumFont(withSize: size)]
            )
        )
        return self
    }
}
