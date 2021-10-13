//
//  ShadowTabContainerUIView.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

public class ShadowTabContainerUIView: UIView {
    private var observer: NSKeyValueObservation?

    public var scrollTabContainerObserver: UIScrollView? {
        didSet {
            setBottomShadow(shadowColor: UITheme.Style.Colors.Extras.shadowLevel3)
            self.observer = scrollTabContainerObserver?.observe(
                \UIScrollView.contentOffset
            ) { object, _ in
                    self.doSomething(object)
            }
        }
    }

    func doSomething(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.y * 0.1
        self.layer.shadowOpacity = Float(value)
    }
}

public class ShadowTabContainerUIStackView: UIStackView {
    private var observer: NSKeyValueObservation?

    public var scrollTabContainerObserver: UIScrollView? {
        didSet {
            setBottomShadow(shadowColor: .black)
            clipsToBounds = false
            self.observer = scrollTabContainerObserver?.observe(
                \UIScrollView.contentOffset
            ) { object, _ in
                    self.doSomething(object)
            }
        }
    }

    func doSomething(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.y * 0.1
        self.layer.shadowOpacity = Float(value)
    }
}
