//
//  SelectableButton.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import Foundation
import UIKit

open class SelectableButton: UIView {

    public static let sigleRowHeight: CGFloat = 35.0
    public static let detailRowHeight: CGFloat = 70.0

    @IBInspectable public var titleText: String? {
        didSet {
            titleLabel.text = titleText
            if titleText == nil {
                titleLabelWidthAnchor?.constant = 0
                titleLabelLeadingAnchor?.isActive = false
                titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
                titleLabelLeadingAnchor?.isActive = true
            } else {
                titleLabelLeadingAnchor?.isActive = false
                titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: 10
                )
                titleLabelLeadingAnchor?.isActive = true
                titleLabelWidthAnchor?.isActive = false
                titleLabelWidthAnchor = titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 41)
                titleLabelWidthAnchor?.isActive = true
                titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            }
        }
    }

    @IBInspectable var valueText: String?
    @IBInspectable var valueText2: String?
    @IBInspectable var valueText3: String?

    @IBInspectable public var buttonText: String? = "CHANGE".localized {
        didSet {
            changeLabel.text = buttonText?.capitalized
        }
    }

    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "SelectableButton.titleLabel"
        label.setStyle(font: MainLabelFonts.a03, color: MainLabelColors.gray)
        return label
    }()

    public private(set) lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "SelectableButton.valueLabel"
        label.setStyle(font: MainLabelFonts.a03, color: MainLabelColors.blue)
        return label
    }()

    public private(set) lazy var valueLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "SelectableButton.valueLabel2"
        label.setStyle(font: MainLabelFonts.a03, color: MainLabelColors.blue)
        return label
    }()

    public private(set) lazy var valueLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "SelectableButton.valueLabel3"
        label.setStyle(font: MainLabelFonts.a03, color: MainLabelColors.blue)
        return label
    }()

    public private(set) lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "SelectableButton.changeLabel"
        label.isHidden = true
        label.setStyle(font: MainLabelFonts.a03, color: MainLabelColors.blue)
        return label
    }()

    var titleLabelWidthAnchor: NSLayoutConstraint?
    var titleLabelLeadingAnchor: NSLayoutConstraint?
    var gesture: UITapGestureRecognizer?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout() {
        backgroundColor = UITheme.Style.Colors.GrisAzulado.level4
        layer.cornerRadius = 3
        layer.masksToBounds = true

        addSubview(titleLabel)
        titleLabel.text = titleText
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        _ = titleLabel.heightAnchor.constraint(equalToConstant: 15.0)

        if titleText != nil {
            titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10
            )
            titleLabelLeadingAnchor?.isActive = true
            titleLabelWidthAnchor = titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 41)
            titleLabelWidthAnchor?.isActive = true
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        } else {
            titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            titleLabelLeadingAnchor?.isActive = true
            titleLabelWidthAnchor = titleLabel.widthAnchor.constraint(equalToConstant: 0)
            titleLabelWidthAnchor?.isActive = true
        }

        addSubview(changeLabel)
        changeLabel.text = buttonText
        changeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        _ = changeLabel.heightAnchor.constraint(equalToConstant: 15.0)
        changeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        let cuarter = bounds.width / 4.0
        addSubview(valueLabel)
        valueLabel.text = valueText
        valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        _ = valueLabel.heightAnchor.constraint(equalToConstant: 15.0)
        valueLabel.trailingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: 0).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cuarter).isActive = true

        addSubview(valueLabel2)
        valueLabel2.text = valueText2 ?? ""
        valueLabel2.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 3.0).isActive = true
        _ = valueLabel2.heightAnchor.constraint(equalToConstant: 15.0)
        valueLabel2.trailingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: 0).isActive = true
        valueLabel2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cuarter).isActive = true

        addSubview(valueLabel3)
        valueLabel3.text = valueText3 ?? ""
        valueLabel3.topAnchor.constraint(equalTo: valueLabel2.bottomAnchor, constant: 2.0).isActive = true
        _ = valueLabel3.heightAnchor.constraint(equalToConstant: 15.0)
        valueLabel3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cuarter).isActive = true
    }

    public func setAction(target: Any?, action: Selector) {
        gesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(gesture!)
        changeLabel.isHidden = false
    }

    public func removeAction() {
        if let validGesture = gesture {
            changeLabel.isHidden = true
            removeGestureRecognizer(validGesture)
        }
    }
}
