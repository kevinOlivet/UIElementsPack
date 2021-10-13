//
//  ErrorViewAnimated.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import CommonsPack
import Lottie
import UIKit

protocol ErrorViewAnimatedProtocol: AnyObject {
    func errorViewAnimatedDidClose()
}

public class ErrorViewAnimated: UIView {

    var header: UIImageView?
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var loadingViewContainer: UIView?
    public private(set) var logoContainer: UIView?
    var animationView: AnimationView?
    public private(set) var closeButton: UIButton?
    var dismissAnimation = true

    weak var delegate: ErrorViewAnimatedProtocol?

    public convenience init(title: String, detail: String, lottieJsonFileName: String, showButton: Bool = true) {
        self.init(frame: UIScreen.main.bounds)

        self.backgroundColor = .white

        self.logoContainer = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 160, height: 160)))
        self.logoContainer?.backgroundColor = .white
        self.logoContainer?.translatesAutoresizingMaskIntoConstraints = false
        self.logoContainer?.addTapAction(target: self, action: #selector(removeFromSuperview))
        self.logoContainer?.accessibilityIdentifier = "ErrorViewAnimated.logoContainer"

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

        self.animationView = AnimationView(name: lottieJsonFileName)
        self.animationView?.translatesAutoresizingMaskIntoConstraints = false
        self.animationView?.contentMode = .scaleAspectFit
        self.animationView?.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        self.animationView?.loopMode = .loop

        self.header = UIImageView(image: UIImage(named: "waves-header-gray"))
        self.header?.translatesAutoresizingMaskIntoConstraints = false

        if showButton {
            self.closeButton = UIButton()
            self.closeButton?.translatesAutoresizingMaskIntoConstraints = false
            self.closeButton?.setBasicStyle()
            self.closeButton?.addRoundedCorners(cornerRadius: 24)
            self.closeButton?.addTarget(self, action: #selector(removeFromSuperview), for: .touchUpInside)
            self.closeButton?.setTitle("CLOSE".localized, for: .normal)
            self.closeButton?.accessibilityIdentifier = "ErrorViewAnimated.closeButton"
            addSubview(self.closeButton!)
        }

        addSubview(self.header!)
        addSubview(self.titleLabel!)
        addSubview(self.descriptionLabel!)
        addSubview(self.logoContainer!)
        self.logoContainer?.addSubview(self.animationView!)

        self.header?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.header?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.header?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.header?.heightAnchor.constraint(equalToConstant: 34).isActive = true

        self.logoContainer?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.logoContainer?.topAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
        self.logoContainer?.heightAnchor.constraint(equalToConstant: 160).isActive = true
        self.logoContainer?.widthAnchor.constraint(equalToConstant: 160).isActive = true

        self.animationView?.topAnchor.constraint(equalTo: (self.logoContainer?.topAnchor)!).isActive = true
        self.animationView?.trailingAnchor.constraint(equalTo: (self.logoContainer?.trailingAnchor)!).isActive = true
        self.animationView?.leadingAnchor.constraint(equalTo: (self.logoContainer?.leadingAnchor)!).isActive = true
        self.animationView?.bottomAnchor.constraint(equalTo: (self.logoContainer?.bottomAnchor)!).isActive = true

        self.titleLabel?.topAnchor.constraint(
            equalTo: (self.animationView?.bottomAnchor)!, constant: 20
        ).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true

        self.descriptionLabel?.topAnchor.constraint(
            equalTo: (self.titleLabel?.bottomAnchor)!, constant: 10
        ).isActive = true
        self.descriptionLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        self.descriptionLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true

        if showButton {
            self.closeButton?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
            self.closeButton?.heightAnchor.constraint(equalToConstant: 48).isActive = true
            self.closeButton?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            self.closeButton?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        }
    }

    override public func removeFromSuperview() {
        animationView?.pause()
        if !dismissAnimation {
            removeWithoutAnimation()
            return
        }
        UIView.animate(
            withDuration: 3,
            animations: {
                self.alpha = 0.0
            },
            completion: { [weak self] _ in
                self?.callSuperRemoveFromSuperview()
                self?.alpha = 1.0
                self?.delegate?.errorViewAnimatedDidClose()
            }
        )
    }

    private func removeWithoutAnimation() {
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

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            DispatchQueue.main.async {
                self.animationView?.play()
            }
        }
    }
}
