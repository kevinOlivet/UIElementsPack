//
//  FullScreenMessageErrorAnimated.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import Lottie
import UIKit

//swiftlint:disable function_default_parameter_at_end

public class FullScreenMessageErrorAnimated: UIView {
    public var animationView: AnimationView?
    var dismissAnimation: Bool = true

    public lazy var titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main_semiBoldFont(withSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.tag = 10_001
        label.textColor = UITheme.Style.Colors.GrisAzulado.level0
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "FullScreenMessageErrorAnimated.title"
        return label

    }()

    public lazy var messageLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main_normalFont(withSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.tag = 10_002
        label.textColor = UITheme.Style.Colors.GrisAzulado.level1
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "FullScreenMessageErrorAnimated.message"
        return label

    }()

    public lazy var animationHolder: UIView = {

        let animationHolder = UIView()
        animationHolder.backgroundColor = .white
        animationHolder.translatesAutoresizingMaskIntoConstraints = false
        animationHolder.contentMode = .scaleAspectFit
        animationHolder.tag = 10_003
        return animationHolder

    }()

    public lazy var messageBottomLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main_normalFont(withSize: 11)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UITheme.Style.Colors.GrisAzulado.level0
        label.tag = 10_004
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "FullScreenMessageErrorAnimated.bottomMessage"
        return label

    }()

    public lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    public lazy var stackViewElements: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    public convenience init(
        withTitle title: String,
        message: String,
        bottomText: String = "",
        animationView: AnimationView,
        buttonsTitles: [String] = [],
        buttonsActions: [Selector] = [],
        buttonsStyles: [UIButton.ButtonTypes] = [],
        buttonAligment: NSLayoutConstraint.Axis = .vertical,
        target: Any?,
        frame: CGRect = UIScreen.main.bounds) {

        self.init(frame: frame)
        self.animationView = animationView

        configureLayer()

        configureButtons(
            target: target,
            buttonsTitles: buttonsTitles,
            buttonsActions: buttonsActions,
            buttonsStyles: buttonsStyles
        )
        configureCenterElement(title: title, message: message, animationView: animationView)

        self.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }

    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            DispatchQueue.main.async {
                self.animationView?.play()
            }
        }
    }

    private func configureLayer() {
        //Very Important, this zPosition makes fullscreen wins over the controller
        self.layer.zPosition = WavezPosition.modal

        self.backgroundColor = UIColor.white
        self.layer.opacity = 1.0
    }

    private func configureCenterElement(
        title: String,
        message: String,
        animationView: AnimationView) {
        self.addSubview(self.stackViewElements)

        stackViewElements.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        stackViewElements.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        stackViewElements.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        stackViewElements.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        self.stackViewElements.addArrangedSubview(doSpacer(height: 20))

        self.animationHolder.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.animationHolder.addSubview(animationView)
        animationView.bindEdgesToSuperView()
        self.stackViewElements.addArrangedSubview(animationHolder)

        self.stackViewElements.addArrangedSubview(doSpacer(height: 20))

        self.titleLabel.text = title
        self.stackViewElements.addArrangedSubview(titleLabel)

        self.stackViewElements.addArrangedSubview(doSpacer(height: 10))

        self.messageLabel.text = message
        self.stackViewElements.addArrangedSubview(messageLabel)
    }

    private func doSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true //aspect fit respects height
        return spacer
    }

    private func configureBottomElement(bottomText: String = "") {
        if !bottomText.isEmpty {
            self.addSubview(self.messageBottomLabel)
            self.messageBottomLabel.text = bottomText
            self.messageBottomLabel.bottomAnchor.constraint(
                equalTo: self.stackView.topAnchor,
                constant: -20
            ).isActive = true
            self.messageBottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.messageBottomLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        }
    }

    private func configureButtons(
        target: Any?,
        buttonsTitles: [String] = [],
        buttonsActions: [Selector] = [],
        buttonsStyles: [UIButton.ButtonTypes] = [],
        buttonAligment: NSLayoutConstraint.Axis = .vertical) {
            let quantity = buttonsTitles.count
            self.stackView.axis = buttonAligment
            self.addSubview(self.stackView)
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

            var stackviewHeight: CGFloat = 0
            if buttonAligment == .vertical && quantity > 1 {
                stackviewHeight = CGFloat(Double(quantity) * Double(UIButton.buttonHeight) + Double(quantity - 1) * 5.0)
            } else {
                stackviewHeight = UIButton.buttonHeight
            }
            self.stackView.heightAnchor.constraint(equalToConstant: stackviewHeight).isActive = true

            for identifier in 0..<quantity {
                let button = UIButton()
                button.setTitle(buttonsTitles[identifier], for: .normal)
                button.isAccessibilityElement = true
                button.accessibilityIdentifier = buttonsTitles[identifier]
                button.addTarget(target, action: buttonsActions[identifier], for: .touchUpInside)
                self.stackView.addArrangedSubview(button)
                button.frame.height = UIButton.buttonHeight
                button.setStyle(buttonsStyles[identifier])
            }
    }

    public func removeFromSuperview(animated: Bool) {
        if animated,
            dismissAnimation {
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.alpha = 0
                }, completion: { _ in
                    super.removeFromSuperview()
                }
            )
        } else {
            super.removeFromSuperview()
        }
    }

    public func addAccesibilityIdentifierForAllElements(withIdentifier identifier: String) {

        titleLabel.accessibilityIdentifier = "\(identifier).FullScreenMessageErrorAnimated.TitleLabel"
        messageLabel.accessibilityIdentifier = "\(identifier).FullScreenMessageErrorAnimated.MessageLabel"
        animationHolder.accessibilityIdentifier = "\(identifier).FullScreenMessageErrorAnimated.ImageView"

        for (index, view) in stackView.arrangedSubviews.enumerated() {
            view.accessibilityIdentifier = "\(identifier).FullScreenMessageErrorAnimated.Button\(index)"
        }
    }
}
