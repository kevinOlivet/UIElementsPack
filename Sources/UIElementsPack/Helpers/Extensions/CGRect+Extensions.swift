//
//  CGRect+Extensions.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import CoreGraphics

// swiftlint:disable identifier_name
// swiftlint:disable missing_docs

public extension CGRect {

    var x: CGFloat {
        get {
            self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.minY, width: self.width, height: self.height)
        }
    }

    var y: CGFloat {
        get {
            self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }

    var width: CGFloat {
        get {
            self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.width, width: newValue, height: self.height)
        }
    }

    var height: CGFloat {
        get {
            self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.minY, width: self.width, height: newValue)
        }
    }

    var top: CGFloat {
        get {
            self.origin.y
        }
        set {
            y = newValue
        }
    }

    var bottom: CGFloat {
        get {
            self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }

    var left: CGFloat {
        get {
            self.origin.x
        }
        set {
            self.x = newValue
        }
    }

    var right: CGFloat {
        get {
            x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }

    internal var midX: CGFloat {
        get {
            self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }

    internal var midY: CGFloat {
        get {
            self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }

    internal var center: CGPoint {
        get {
            CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
}
