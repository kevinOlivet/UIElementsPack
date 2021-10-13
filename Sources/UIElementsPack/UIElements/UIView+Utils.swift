//
//  UIView+Utils.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

extension UIView {
    /// UIView as circle
    public func asCircle() {
        layer.cornerRadius = self.frame.width / 2
        layer.masksToBounds = true
    }

    /// Add rounded corners to uiview
    ///
    /// - Parameter cornerRadius: corner radius to apply
    public func addRoundedCorners(cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }

    /// Add shadow to uiview bounds
    ///
    /// - Parameter color: shadow color to apply
    /// - Parameter offset: shadow offset to apply
    /// - Parameter opacity: shadow opacity to apply
    /// - Parameter radius: shadow radius to apply
    public func addShadow(color: UIColor = UIColor.black,
                          offset: CGSize = CGSize.zero,
                          opacity: Float = 0.0,
                          radius: CGFloat = 3.0) {
        backgroundColor = UIColor.clear
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    /// Add border to uiview
    ///
    /// - Parameter color: line color to apply
    /// - Parameter width: line width to apply
    public func addBorder(color: UIColor, lineWidth: CGFloat) {
        self.addBorder(color: color.cgColor, width: lineWidth)
    }

    /// addBorder
    /// - Parameter color: color value
    /// - Parameter width: width value
    public func addBorder(color: CGColor, width: CGFloat) {
        layer.borderColor = color
        layer.borderWidth = width
    }

    /// roundCorners
    /// - Parameter corners: corners description
    /// - Parameter radius: radius description
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }

    func subviewsRecursive() -> [UIView] {
        subviews + subviews.flatMap { $0.subviewsRecursive() }
    }

    func getAccessibilityLabels() -> [String] {
        let allViews = self.subviewsRecursive()
        let labels = allViews.compactMap { $0.accessibilityIdentifier }
        return labels
    }
    func getAccessibilityLabelComponents() -> [Any] {
        let allViews = self.subviewsRecursive()
        let components = allViews.compactMap { view -> (Any?) in
            if view.accessibilityIdentifier != nil {
               return view
            }
            return nil
        }
        return components
    }

    /// parentViewController - Get the parent controler of an UIView 🌶
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    func takeScreenshot() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if image != nil {
            return image!
        }
        return UIImage()
    }
}
