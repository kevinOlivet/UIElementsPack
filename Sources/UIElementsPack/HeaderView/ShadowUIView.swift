//
//  ShadowUIView.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

public class ShadowUIView: UIView {
    private var observer: NSKeyValueObservation?
    public var scrollObserver: UIScrollView? {
        didSet {
            setBottomShadow()
            self.observer = scrollObserver?.observe(
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

public class ShadowUIStackView: UIStackView {
    private var observer: NSKeyValueObservation?
    public var scrollObserver: UIScrollView? {
        didSet {
            setBottomShadow()
            clipsToBounds = false
            self.observer = scrollObserver?.observe(
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
