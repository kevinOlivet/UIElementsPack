//
//  UIView+Extension.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

//swiftlint:disable function_default_parameter_at_end

import Foundation

/// Utils for UIView
public extension UIView {

    /// setShadow - deprecated
    @available(*, unavailable, message: "Use setBottomShadow instead of setShadow")
    func setShadow() {
        self.layer.shadowColor = UITheme.Style.Colors.Extras.shadowLevel2.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0.4)
    }

    /// setBottomShadow
    /// - Parameter shadowColor: shadowColor value
    func setBottomShadow(shadowColor: UIColor = UITheme.Style.Colors.Extras.shadow) {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: self.bounds.origin.x, y: self.frame.size.height - 6.0))
        shadowPath.addLine(to: CGPoint(x: self.bounds.origin.x, y: self.bounds.height ))
        shadowPath.addLine(to: CGPoint(x: 414, y: self.bounds.height ))
        shadowPath.addLine(to: CGPoint(x: 414, y: self.bounds.height - 6.0))
        shadowPath.close()
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowPath = shadowPath.cgPath
    }

    /// setGradient
    /// - Parameter startColor: startColor color
    /// - Parameter endColor: endColor color
    /// - Parameter hasSubviews: hasSubviews flag
    /// - Parameter frame: frame to apply
    func setGradient(
        fromColor startColor: UIColor,
        toColor endColor: UIColor,
        hasSubviews: Bool = true,
        withFrame frame: CGRect = CGRect.zero) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        if frame == CGRect.zero {
            gradientLayer.frame = self.bounds
        } else {
            gradientLayer.frame = frame
        }
        self.layer.addSublayer(gradientLayer)
        if hasSubviews {
            for view in self.subviews {
                self.bringSubviewToFront(view)
            }
        }
    }

    /// addOverlay - Add overlay to view
    ///
    /// - Parameter frame: Frame to left without the overlay color
    /// - Parameter overlayLayer: Layer reference to remove the layer later
    func addOverlay(
        overlayFrame: CGRect? = nil,
        withSpace frame: CGRect,
        overlayLayer: inout CAShapeLayer) {

        let layerFrame: CGRect = (overlayFrame == nil) ? self.frame : overlayFrame!

        //// Color Declarations, Overlay color
        let layerColor = UITheme.Style.Colors.GrisAzulado.level4.withAlphaComponent(0.7)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: layerFrame.maxY))
        bezierPath.addLine(to: CGPoint(x: layerFrame.size.width, y: layerFrame.maxY))
        bezierPath.addLine(to: CGPoint(x: layerFrame.size.width, y: frame.maxY))
        bezierPath.addLine(to: CGPoint(x: 0, y: frame.maxY))
        bezierPath.addLine(to: CGPoint(x: 0, y: frame.origin.y))
        bezierPath.addLine(to: CGPoint(x: layerFrame.size.width, y: frame.origin.y))
        bezierPath.addLine(to: CGPoint(x: layerFrame.size.width, y: layerFrame.origin.y))
        bezierPath.addLine(to: CGPoint(x: 0, y: layerFrame.origin.y))
        layerColor.setFill()
        bezierPath.fill()

        overlayLayer.path = bezierPath.cgPath
        overlayLayer.fillColor = layerColor.cgColor
        overlayLayer.fillRule = CAShapeLayerFillRule.nonZero
        overlayLayer.lineCap = CAShapeLayerLineCap.butt
        overlayLayer.lineDashPattern = nil
        overlayLayer.lineDashPhase = 0.0
        overlayLayer.lineJoin = CAShapeLayerLineJoin.miter
        overlayLayer.lineWidth = 1.0
        overlayLayer.miterLimit = 10.0
        overlayLayer.strokeColor = layerColor.cgColor

        self.layer.addSublayer(overlayLayer)
    }

    /// bindEdgesToSuperView - Add constraint to all edges of the super view
    func bindEdgesToSuperView() {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }

    /// allSubviews - Get all child views recursively
    ///
    /// - Returns: Array of all subviews
    func allSubviews() -> [UIView] {
        subviews.flatMap { [$0] + $0.allSubviews() }
    }

    /// bintToKeyboard - bind to keyboard
    func bintToKeyboard() {
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillChange(_:)),
        name: UIResponder.keyboardWillChangeFrameNotification,
        object: nil
        )
    }

    /// keyboardWillChange
    ///
    /// - Parameter notification: notification
    @objc
    func keyboardWillChange(_ notification: NSNotification) {
        if let noty = notification.userInfo {
            guard let duration = noty[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                let curve = noty[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
                let curFrame = noty[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
                let targetFrame = noty[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                    return
            }

            let deltaY = targetFrame.cgRectValue.origin.y - curFrame.cgRectValue.origin.y

            UIView.animateKeyframes(
                withDuration: duration,
                delay: 0.0,
                options: UIView.KeyframeAnimationOptions(rawValue: curve),
                animations: { self.frame.origin.y += deltaY },
                completion: nil
            )
        }
    }
}
