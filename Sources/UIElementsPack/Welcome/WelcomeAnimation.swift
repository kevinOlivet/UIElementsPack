//
//  LoadingChancho.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import BasicCommons
import Foundation
import Lottie

public class WelcomeAnimation: MainAnimationView {
    public convenience init(width: CGFloat, height: CGFloat) {
        let animation = MainAnimation.welcome.lottieAnimationView
        self.init(animation)
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        animation.frame = self.frame
        self.addSubview(animation)
        animation.loopMode = .loop
        animation.play()
    }
}
