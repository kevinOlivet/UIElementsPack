//
//  ComponentInitializer.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

public class ComponentInitializer: UIView {

    var viewToInitialize: UIView?
    open var nibName: String?

    func xibSetup() {
        viewToInitialize = loadViewFromNib()
        viewToInitialize?.frame = bounds
        viewToInitialize?.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(viewToInitialize!)
    }

    func loadViewFromNib() -> UIView {
        guard let nibName = nibName else {
            return UIView()
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            assertionFailure("cant instantiate nib from ComponentInitializer")
            return UIView()
        }
        return view
    }
}
