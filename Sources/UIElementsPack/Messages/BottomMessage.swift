//
//  BottomMessage.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

@objc
public protocol BottomMessageDelegate: AnyObject {
    @objc
    optional func bottomMessageDidClose(message: BottomMessage, button: UIButton)
    @objc
    optional func closedByIconOrBackground()
    @objc
    optional func closedByIconOrBackground(bottomMessage: BottomMessage)
}

//swiftlint:disable type_body_length
//swiftlint:disable private_outlet
//swiftlint:disable function_default_parameter_at_end

open class BottomMessage: UIView {
    enum ButtonLayout {
        case vertical
        case horizontal
    }

    // MARK: Outlets
    @IBOutlet public private(set) weak var headerView: UIView!
    @IBOutlet public private(set) weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet public private(set) weak var topButtonBackground: UIView!
    @IBOutlet public private(set) weak var background: UIView!
    @IBOutlet public private(set) weak var titleLabel: UILabel!
    @IBOutlet public private(set) weak var messageLabel: UILabel!
    @IBOutlet public private(set) weak var firstButton: UIButton!
    @IBOutlet public private(set) weak var secondButton: UIButton!
    @IBOutlet public private(set) weak var messageBox: UIView!
    @IBOutlet public private(set) weak var buttonsStack: UIStackView!
    @IBOutlet public private(set) weak var headerImageView: UIImageView!
    @IBOutlet public private(set) weak var headerCloseButton: UIButton!
    @IBOutlet public private(set) weak var viewMessageBoxBackground: UIView!
    @IBOutlet public private(set) weak var bottomMessageBoxConstraint: NSLayoutConstraint!

    public var dismissAnimation = true
    public weak var delegate: BottomMessageDelegate?

    public var elementsAlignment = NSTextAlignment.left {
        didSet {
            setElementsAlignment(alignment: elementsAlignment)
        }
    }

    // MARK: - Init methods
    // This replaces setupView() which doesn't work with SPM
    override init(frame: CGRect) {
        super.init(frame: frame) // calls designated initializer
        let bottom = Bundle.module.loadNibNamed("BottomMessage", owner: self, options: nil)?.first as? UIView
        self.addSubview(bottom!)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Create bottom error view

    public convenience init(
        withTitle title: String,
        andMessage message: String,
        buttonText: String,
        style: UIButton.ButtonTypes,
        headerImage: UIImage = UIImage(),
        action: Selector?,
        _ target: Any,
        isDismissable: Bool = true,
        showHeaderCloseButton: Bool = false
        ) {
        let attributedMessage = NSAttributedString(string: message)
        self.init(
            withTitle: title,
            andMessage: attributedMessage,
            buttonText: buttonText,
            style: style,
            headerImage: headerImage,
            action: action,
            target,
            isDismissable: isDismissable,
            showHeaderCloseButton: showHeaderCloseButton
        )
    }

    public convenience init(
        withTitle title: String,
        andMessage message: NSAttributedString,
        buttonText: String,
        style: UIButton.ButtonTypes,
        headerImage: UIImage = UIImage(),
        action: Selector?,
        _ target: Any,
        isDismissable: Bool = true,
        showHeaderCloseButton: Bool = false
        ) {

        self.init(frame: UIScreen.main.bounds)
//        setupView() // Now replaced with regular inits

        //tells the alert, to be display infront of the wavy as a modal! duu!
        self.layer.zPosition = WavezPosition.modal

        titleLabel.text = title
        messageLabel.attributedText = message

        if headerImage.size != CGSize.zero {
            self.headerImageView.image = headerImage
            self.titleLabel.textAlignment = .center
            self.messageLabel.textAlignment = .center
        } else {
            self.headerView.isHidden = true
            self.headerHeightConstraint.constant = 0
        }

        if isDismissable {
            topButtonBackground.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.closeBottomMessage)
                )
            )
        }

        var secondButtonTitle = "CLOSE".localized
        var secondButtonStyle: UIButton.ButtonTypes = .cancel

        if !buttonText.isEmpty {
            setDataTo(
                button: firstButton,
                withText: buttonText,
                style: style,
                target: target,
                selector: action
            )
        } else {
            firstButton.removeFromSuperview()
            secondButtonTitle = "UNDERSTOOD".localized
            secondButtonStyle = .basic
        }

        if showHeaderCloseButton {
            setDataTo(
                button: secondButton,
                withText: secondButtonTitle,
                style: secondButtonStyle,
                target: self,
                selector: #selector(self.closeBottomMessage)
            )
        } else {
            secondButton.removeFromSuperview()
        }

        let boxMovement = messageBox.bounds.height
        messageBox.layer.position.y += boxMovement

        background.backgroundColor = .clear
        messageBox.alpha = 0
        bottomMessageBoxConstraint.constant = -viewMessageBoxBackground.bounds.height
        viewMessageBoxBackground.alpha = 0
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.layoutIfNeeded()
            },
            completion: { _ in
                self.animateBackground()
            }
        )

        self.accessibilityElements = [
            self.titleLabel as Any,
            self.messageLabel as Any,
            self.firstButton as Any,
            self.secondButton as Any,
            self.messageBox as Any,
            self.headerImageView as Any
        ]
        addAccesibilityIdentifierForAllElements(withIdentifier: "")
    }

    func animateBackground(_ UIView: UIView.Type = UIView.self) {
        viewMessageBoxBackground.alpha = 1
        viewMessageBoxBackground.roundCorners(corners: [.topLeft, .topRight], radius: 6.0)
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.background.backgroundColor = UITheme.Style.Colors.Extras.shadowLevel3
                self.bottomMessageBoxConstraint.constant = 0
                self.layoutIfNeeded()
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.messageBox.alpha = 1
                    self.layoutIfNeeded()
                }
            }
        )

    }

    // MARK: Create bottom error view with one button, uses attributed string to bold text.
    public convenience init(
        withTitle title: String,
        andAttributedMessage message: NSMutableAttributedString,
        buttonText: String,
        style: UIButton.ButtonTypes,
        headerImage: UIImage = UIImage(),
        action: Selector?,
        _ target: Any,
        isDismissable: Bool = true,
        showHeaderCloseButton: Bool = true
        ) {
        self.init(
            withTitle: title,
            andMessage: "",
            buttonText: buttonText,
            style: style,
            headerImage: headerImage,
            action: action,
            target,
            isDismissable: isDismissable,
            showHeaderCloseButton: showHeaderCloseButton
        )

        messageLabel.attributedText = message
    }

    public func addButton(_ button: UIButton, withType type: UIButton.ButtonTypes) {
        button.setStyle(type)
        buttonsStack.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: UIButton.buttonHeight).isActive = true
        button.layer.cornerRadius = UIButton.buttonHeight * 0.5
    }
    //This method, will remove spacing between buttons,
    //will make each item not to be equal to each other,
    //and will remove posible margins.
    //Finally you can add a costumview, inserted at a position
    //using addView(_ view: UIView, at stackIndex: Int)
    public func resetButtonsStackSpacingMarginDynamicHeight() {
        buttonsStack.spacing = 0
        buttonsStack.distribution = .fill
        buttonsStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        buttonsStack.isLayoutMarginsRelativeArrangement = true
    }

    public func insertCustomViewInsideButtonsStack(_ view: UIView, at stackIndex: Int) {
        buttonsStack.insertArrangedSubview(view, at: stackIndex)
    }

    @objc
    public func closeBottomMessage() {
        self.delegate?.closedByIconOrBackground?()
        self.delegate?.closedByIconOrBackground?(bottomMessage: self)
        self.removeFromSuperview()
    }

    public func addAccesibilityIdentifierForAllElements(withIdentifier identifier: String) {

        titleLabel.accessibilityIdentifier = "\(identifier).BottomMessage.TitleLab"
        messageLabel.accessibilityIdentifier = "\(identifier).BottomMessage.MessageLabel"
        firstButton.accessibilityIdentifier = "\(identifier).BottomMessage.FirstButton"
        secondButton.accessibilityIdentifier = "\(identifier).BottomMessage.SecondButton"
        messageBox.accessibilityIdentifier = "\(identifier).BottomMessage.MessageBox"
        headerImageView.accessibilityIdentifier = "\(identifier).BottomMessage.HeaderImageView"
    }

    func setElementsAlignment(alignment: NSTextAlignment) {
        titleLabel.textAlignment = alignment
        messageLabel.textAlignment = alignment
    }

    // MARK: Setup methods
    private func setDataTo(
        button: UIButton,
        withText text: String,
        style: UIButton.ButtonTypes,
        target: Any,
        selector: Selector?) {

        if let selector = selector {
            button.addTarget(target, action: selector, for: .touchUpInside)
        } else {
            button.addTarget(
                self, action: #selector(removeFromSuperview), for: .touchUpInside
            )
        }

        button.setStyle(style)

        button.setTitle(text.uppercased(), for: .normal) /*+" 👍"*/
        button.titleLabel?.text = text.uppercased()
        button.reloadInputViews()
    }

    // MARK: Override dismiss action
    override open func removeFromSuperview() {
        if !dismissAnimation {
            removeWithoutAnimation()
            return
        }

        animateViewMessageBoxBackgroundRemove()

    }

    func animateViewMessageBoxBackgroundRemove(_ UIView: UIView.Type = UIView.self) {
        bottomMessageBoxConstraint.constant = -viewMessageBoxBackground.frame.height
        UIView.animate(
            withDuration: 0.3,
            animations: {
            self.background.backgroundColor = .clear
            self.layoutIfNeeded()
            },
            completion: { completed in
                if completed {
                    self.dismissAction()
                }
            }
        )
    }

    private func dismissAction() {
        self.delegate?.bottomMessageDidClose?(message: self, button: self.firstButton)
        super.removeFromSuperview()
    }

    public func removeWithoutAnimation() {
        alpha = 0.0
        super.removeFromSuperview()
        alpha = 1.0
    }

    @IBAction private func pressClose(_ sender: Any) {
        self.closeBottomMessage()
    }
}
