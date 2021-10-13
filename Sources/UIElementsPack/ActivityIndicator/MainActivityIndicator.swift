//
//  MainActivityIndicator.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import BasicCommons
import Lottie
import UIKit

open class MainActivityIndicator: UIView {

    public private(set) var header: UIImageView?
    public private(set) var titleLabel: UILabel?
    public private(set) var descriptionLabel: UILabel?
    public private(set) var logoContainer: UIView?
    public private(set) var animationView: AnimationView?
    public var dismissAnimation = true

    public enum AnimationType {
        case `default`
    }

    public convenience init(
        title: String,
        detail: String,
        animationType: AnimationType = .default,
        showHeader: Bool = true) {

        self.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .white

        self.logoContainer = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 220, height: 220)))
        self.logoContainer?.backgroundColor = .white
        self.logoContainer?.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel = UILabel()
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont.main_semiBoldFont(withSize: 18)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = UITheme.Style.Colors.GrisAzulado.level0
        self.titleLabel?.text = title

        self.descriptionLabel = UILabel()
        self.descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel?.font = UIFont.main_LightFont(withSize: 13)
        self.descriptionLabel?.textColor = UITheme.Style.Colors.GrisAzulado.level1
        self.descriptionLabel?.numberOfLines = 0
        self.descriptionLabel?.textAlignment = .center
        self.descriptionLabel?.text = detail
        self.animationView = createAnimationView(animationType)

        self.header = UIImageView()

        self.header?.translatesAutoresizingMaskIntoConstraints = false

        addSubview(self.header!)
        addSubview(self.titleLabel!)
        addSubview(self.descriptionLabel!)
        addSubview(self.logoContainer!)
        self.logoContainer?.addSubview(self.animationView!)

        self.header?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.header?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.header?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        if showHeader {
            if #available(iOS 11.0, *), UIDevice.isIphoneXSeries() {
                self.header?.heightAnchor.constraint(equalToConstant: 55).isActive = true
            } else {
                self.header?.heightAnchor.constraint(equalToConstant: 35).isActive = true
            }
        } else {
            self.header?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        self.logoContainer?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        if showHeader {
            self.logoContainer?.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        } else {
            if UIDevice.isIphoneXSeries() {
                self.logoContainer?.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -75).isActive = true
            } else {
                self.logoContainer?.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -45).isActive = true
            }
        }

        self.logoContainer?.heightAnchor.constraint(equalToConstant: 220).isActive = true
        self.logoContainer?.widthAnchor.constraint(equalToConstant: 220).isActive = true

        self.animationView?.topAnchor.constraint(equalTo: (self.logoContainer?.topAnchor)!).isActive = true
        self.animationView?.trailingAnchor.constraint(equalTo: (self.logoContainer?.trailingAnchor)!).isActive = true
        self.animationView?.leadingAnchor.constraint(equalTo: (self.logoContainer?.leadingAnchor)!).isActive = true
        self.animationView?.bottomAnchor.constraint(equalTo: (self.logoContainer?.bottomAnchor)!).isActive = true

        self.titleLabel?.topAnchor.constraint(
            equalTo: (self.animationView?.bottomAnchor)!, constant: 20
        ).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true

        self.descriptionLabel?.topAnchor.constraint(
            equalTo: (self.titleLabel?.bottomAnchor)!, constant: 10
        ).isActive = true
        self.descriptionLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.descriptionLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true

        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newView)
        self.sendSubviewToBack(newView)
        newView.topAnchor.constraint(equalTo: (self.header?.bottomAnchor)!).isActive = true
        newView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        newView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        newView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newView.backgroundColor = .white
    }

    public func changeTitleLabel(text: String, animate: Bool = false) {
        if animate {
            let finalPlace = self.titleLabel?.frame.top
            let delta = (self.titleLabel?.frame.size.height)! / 2
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.titleLabel?.frame.origin.y += delta
                    self.titleLabel?.alpha = 0
                },
                completion: { [weak self] _ in
                    self?.titleLabel?.text = text
                        self?.titleLabel?.frame.origin.y = (finalPlace ?? 0) - delta
                    UIView.animate(
                        withDuration: 0.3,
                        animations: {
                            self?.titleLabel?.frame.origin.y = finalPlace ?? 0
                            self?.titleLabel?.alpha = 1
                        },
                        completion: { _ in
                            debugPrint("dissmiss animation completion")
                        }
                    )
                }
            )
        } else {
            self.titleLabel?.text = text
        }
    }

    public func changeDescriptionLabel(text: String) {
        self.descriptionLabel?.text = text
    }

    override open func removeFromSuperview() {
        animationView?.pause()
        let invalidParent = parentViewController == nil
        if !dismissAnimation || invalidParent {
            removeWithouAnimation()
            return
        }
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                self?.alpha = 0.0
            },
            completion: { [weak self] _ in
                if self?.superview != nil {
                    self?.callSuperRemoveFromSuperview()
                    self?.alpha = 1.0
                }
            }
        )
    }

    private func removeWithouAnimation() {
        alpha = 0.0
        super.removeFromSuperview()
        alpha = 1.0
    }

    // call super.removeFromSuperview() using weak self
    // in the removeFromSuperview method to avoid crash in tests
    // when view is release from memory
    private func callSuperRemoveFromSuperview() {
        super.removeFromSuperview()
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            DispatchQueue.main.async {
                self.animationView?.play()
            }
        }
    }

    open func createAnimationView(_ type: AnimationType) -> AnimationView {

        let animation: MainAnimation = {
            return MainAnimation.genericLoading
        }()

        let view = animation.lottieAnimationView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        view.loopMode = .loop
        return view
    }

    public func setAccessibilityIdentifiers(_ identifier: String) {
        titleLabel?.isAccessibilityElement = true
        descriptionLabel?.isAccessibilityElement = true
        titleLabel?.accessibilityIdentifier = "\(identifier).TitleLabel"
        descriptionLabel?.accessibilityIdentifier = "\(identifier).DescriptionLabel"
    }
}
