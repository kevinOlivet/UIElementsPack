//
//  MainInspectableExtension.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import Foundation
import UIKit

//swiftlint:disable missing_docs
//swiftlint:disable unused_setter_value

// MARK: - AssociatedType

public protocol MainInspectableCompatible {
    associatedtype CompatibleType

    var main: MainInspectableExtension<CompatibleType> { get set }
}

public extension MainInspectableCompatible {
    var main: MainInspectableExtension<Self> {
        get { MainInspectableExtension(self) }
        set { }
    }
}

public class MainInspectableExtension<InspectableBase> {
    public let base: InspectableBase

    init(_ base: InspectableBase) {
        self.base = base
    }
}
extension UIView: MainInspectableCompatible { }

// MARK: - All IBInspectable for UIImageView.
public extension MainInspectableExtension where InspectableBase: UIImageView {
    var name: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.asetKey
            ) as? String }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.asetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            ) }
    }
}

public extension UIImageView {
    enum MainAssociatedKeys {
        static var asetKey = "\(type(of: self)).mainAssetKey"
    }

    @IBInspectable var assetKey: String? {
        get { main.name }
        set {
            if let value = newValue, !value.trimmedString.isEmpty {
                self.image = MainAsset.image(for: value)
            }
            main.name = newValue
        }
    }
}

// MARK: - All IBInspectable for UIButton
public extension MainInspectableExtension where InspectableBase: UIButton {
    var defaultName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.normalAssetKey
            ) as? String }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.normalAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            ) }
    }
    var highlightedName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.highlightedAssetKey
            ) as? String }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.highlightedAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            ) }
    }
    var selectedtName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.selectedAssetKey
            ) as? String }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.selectedAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            ) }
    }
    var disabledName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.disabledAssetKey
            ) as? String }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).MainAssociatedKeys.disabledAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            ) }
    }
}

public extension UIButton {

    enum MainAssociatedKeys {
        static var normalAssetKey = "\(type(of: self)).normalAssetKey"
        static var highlightedAssetKey = "\(type(of: self)).highlightedAssetKey"
        static var selectedAssetKey = "\(type(of: self)).selectedAssetKey"
        static var disabledAssetKey = "\(type(of: self)).disabledAssetKey"
    }

    @IBInspectable var normalAssetKey: String? {
        get { main.defaultName }
        set {
            if let value = newValue, !value.trimmedString.isEmpty {
                let image = MainAsset.image(for: value)
                self.setImage(image, for: .normal)
            }
            main.defaultName = newValue
        }
    }

    @IBInspectable var highlightedAssetKey: String? {
        get { main.highlightedName }
        set {
            if let value = newValue, !value.trimmedString.isEmpty {
                let image = MainAsset.image(for: value)
                self.setImage(image, for: .highlighted)
            }
            main.highlightedName = newValue
        }
    }

    @IBInspectable var selectedAssetKey: String? {
        get { main.selectedtName }
        set {
            if let value = newValue, !value.trimmedString.isEmpty {
                let image = MainAsset.image(for: value)
                self.setImage(image, for: .selected)
            }
            main.selectedtName = newValue
        }
    }

    @IBInspectable var disabledAssetKey: String? {
        get { main.disabledName }
        set {
            if let value = newValue, !value.trimmedString.isEmpty {
                let image = MainAsset.image(for: value)
                self.setImage(image, for: .disabled)
            }
            main.disabledName = newValue
        }
    }
}
