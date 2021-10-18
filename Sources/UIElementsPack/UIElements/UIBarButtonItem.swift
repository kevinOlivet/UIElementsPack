//
//  UIBarButtonItem.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

/// public extension UIBarButtonItem
public extension UIBarButtonItem {
    /// customItem
    /// - Parameter image: image button
    /// - Parameter target: target button
    /// - Parameter action: action button
    class func customItem(image: UIImage, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    /// grayBackButton
    /// - Parameter target: target button
    /// - Parameter action: action button
    static func grayBackButton(target: Any?, action: Selector) -> UIBarButtonItem {
        UIBarButtonItem.customItem(image: MainAsset.iconBack.image, target: target, action: action)
    }
}
