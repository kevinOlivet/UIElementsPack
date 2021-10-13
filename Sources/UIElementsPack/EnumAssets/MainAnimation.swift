//
//  MainAnimation.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import CommonsPack
import Foundation
import Lottie

public enum MainAnimation: String, CaseIterable {
    case genericLoading = "generic_loading"
    case welcome = "welcome"
    case internetError = "internet_error"
    case serviceError = "service_error"
    case successCheckMark = "success_check_mark"
    case iconCheck = "icon_check"

    public var lottieAnimationView: AnimationView {
        AnimationView(
            name: self.rawValue,
            bundle: Utils.bundle(forClass: BundleAnimationToken.self)!
        )
    }
}

private final class BundleAnimationToken {}

public class MainAnimationView: UIView {
    public var animationView: AnimationView?

    public convenience init(_ animation: AnimationView) {
        self.init()
        animationView = animation
    }

    public func setAnimation(_ animation: AnimationView) {
        animationView = animation
    }

    public func getAnimation() -> AnimationView {
        animationView!
    }

    public func play() {
        animationView?.play()
    }

    public func stop() {
        animationView?.stop()
    }

    public func pause() {
        animationView?.pause()
    }
}
