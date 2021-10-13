//
//  ToastView.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import UIKit

public protocol ToastViewDelegate: NSObjectProtocol {
    func toastViewDidClose(_ view: ToastView)
}

public class ToastView: UIView {

    // MARK: - Outlets

    @IBOutlet private weak var bottomBackground: UIView!
    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var messageBox: UIView!
    @IBOutlet private weak var checkMarkImageView: UIImageView!

    // MARK: - Attrs

    public weak var delegate: ToastViewDelegate?
    public var dismissAnimationTime = 3.0
    public var isAutoRemove = true

    // MARK: - Test Attributes

    var title: String? {
        titleLabel.text
    }

    var message: String? {
        messageLabel.text
    }

    // MARK: - Init methods

    public convenience init(
        withTitle title: String,
        andMessage message: String,
        autoRemove: Bool = true,
        checkImageHidden: Bool = false,
        dimissAnimationTime time: Double = 3
        ) {

        self.init(frame: UIScreen.main.bounds)
        setupView()

        checkMarkImageView.isHidden = checkImageHidden
        titleLabel.text = title
        messageLabel.text = message

        titleLabel.setStyle(font: MainLabelFonts.a10, color: MainLabelColors.black)
        messageLabel.setStyle(font: MainLabelFonts.a05, color: MainLabelColors.gray)

        dismissAnimationTime = time
        isAutoRemove = autoRemove

        setupUI()
    }

    public convenience init(
        withAttributedTitle title: NSAttributedString,
        andAttributedMessage message: NSAttributedString,
        autoRemove: Bool = true,
        checkImageHidden: Bool = false,
        dimissAnimationTime time: Double = 3
        ) {

        self.init(frame: UIScreen.main.bounds)
        setupView()

        checkMarkImageView.isHidden = checkImageHidden
        titleLabel.attributedText = title
        messageLabel.attributedText = message

        dismissAnimationTime = time
        isAutoRemove = autoRemove

        setupUI()
    }

    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }

    public func hide() {
        if !isAutoRemove {
            removeWithoutAnimation()
            return
        }

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.background.backgroundColor = .clear
                self.messageBox.layer.position.y -= self.messageBox.bounds.size.height
            },
            completion: { _ in
                self.delegate?.toastViewDidClose(self)
                super.removeFromSuperview()
            }
        )
    }

    // MARK: - Lifecycle

    // MARK: - Private methods

    func removeWithoutAnimation() {
        alpha = 0.0
        super.removeFromSuperview()
    }

    func setupUI() {
        let tapRemove = UITapGestureRecognizer(
            target: self, action: #selector(removeFromSuperview)
        )
        bottomBackground.addGestureRecognizer(tapRemove)

        let tapRemove2 = UITapGestureRecognizer(
            target: self, action: #selector(removeFromSuperview)
        )
        background.addGestureRecognizer(tapRemove2)

        background.backgroundColor = .clear

        let boxMovement = messageBox.bounds.size.height
        messageBox.layer.position.y -= boxMovement

        UIView.animate(withDuration: 0.3) {
            self.background.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.messageBox.layer.position.y += boxMovement
        }

        if isAutoRemove {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + dismissAnimationTime
            ) {
                self.hide()
            }
        }
    }

}
