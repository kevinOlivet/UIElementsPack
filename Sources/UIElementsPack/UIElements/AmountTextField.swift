//
//  AmountTextField.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import BasicCommons
import UIKit

 public protocol AmountTextFieldDelegate: UITextFieldDelegate {
    func didPassErrorCheck(_ pass: Bool)
}

public enum AmountTextFieldErrorKey: String {
    case badFormat       = "BadFormat"
    case belowMinimum    = "BelowMinimum"
    case overMaximum     = "OverMaximum"
    case overAvailable   = "OverAvailable"
}

open class AmountTextField: UITextField {

    public var maximum: Double?
    public var minimum: Double?
    public var available: Double?
    public var errorMessages: [AmountTextFieldErrorKey: String] = [:]
    public var noErrorMessage = "" {
        didSet {
            if !hasError {
                errorLabel?.text = noErrorMessage
            }
        }
    }
    public var isNational = true
    public private(set) var errorLabel: UILabel?
    var changed: Bool = false
    var hasError = false
    lazy var border: UIView = {
        let thickness = CGFloat(1.0)
        let newFrame = CGRect(
            x: 0,
            y: self.frame.height + 10,
            width: UIScreen.main.bounds.size.width - 40,
            height: thickness
        )
        let newBorder = UIView(frame: newFrame)
        newBorder.backgroundColor = UITheme.Style.Colors.GrisAzulado.level3
        return newBorder
    }()
    public weak var atDelegate: AmountTextFieldDelegate?
    override open var text: String? {
        didSet {
            let length = text!.distance(from: text!.startIndex, to: text!.endIndex)
            if length > 18 {
                super.text = String(text![..<text!.index(text!.startIndex, offsetBy: 18)])
            } else {
                super.text = text!
            }
        }
    }

    var isOverMaximum: Bool {
        errorLabel?.text = ""
        guard let max = maximum else {
            return false
        }
        if let number = self.cleanNumber() {
            if number > max {
                return true
            }
        } else {
            let number = Double(self.text!.replacingOccurrences(of: ".", with: ""))
            if number != nil && number! > Double(Int.max) {
                return true
            }
        }
        return false
    }

    var isBelowMinimum: Bool {
            guard let min = minimum, let number = self.cleanNumber() else {
                return false
            }

            if number < min {
                return true
            }

            return false
    }

    var hasBadFormat: Bool {
        guard self.text != nil else {
            return true
        }
        let newText = self.text!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "")
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]*$", options: [])
            let range = NSRange(location: 0, length: newText.utf16.count)
            return regex.firstMatch(in: newText, options: [], range: range) == nil
        } catch {
            debugPrint("regular expresion went bananas", error)
            return true
        }
    }

    var isOverAvailable: Bool {
        guard let available = available, let number = self.cleanNumber() else {
            return false
        }

        if number > available {
            return true
        }
        return false
    }

    public func toAmountStyle() {

        guard !changed else {
            return
        }
        changed = true
        //Set Styles
        self.font = UIFont.main_boldFont(withSize: 34)
        self.textColor = UITheme.Style.Colors.GrisAzulado.level0
        self.keyboardType = (isNational) ? .numberPad : .decimalPad
        self.backgroundColor = .clear
        self.borderStyle = .none

        //Set Border
        self.addSubview(border)

        //Set left image
        self.leftViewMode = .always
        let leftLabelFrame = CGRect(x: 0, y: 0, width: (isNational) ? 28 : 45, height: self.frame.height)
        let leftLabel = UILabel(frame: leftLabelFrame)
        leftLabel.minimumScaleFactor = 0.5
        leftLabel.font = UIFont.main_LightFont(withSize: 22)
        leftLabel.text = (isNational) ? "$" : "US$"
        leftLabel.textColor = UITheme.Style.Colors.GrisAzulado.level0
        leftLabel.textAlignment = .left
        self.leftView = leftLabel

        //Set error label
        errorLabel = UILabel()
        errorLabel!.textColor = UITheme.Style.Colors.GrisAzulado.level1
        errorLabel!.font = UIFont.main_LightFont(withSize: 12)
        errorLabel!.frame = CGRect(x: 0, y: border.frame.y + 5, width: self.frame.width, height: 14)
        errorLabel?.adjustsFontSizeToFitWidth = true
        errorLabel?.minimumScaleFactor = 0.5
        self.addSubview(errorLabel!)

    }

    public func cleanNumber() -> Double? {

        guard self.text != nil else {
            return nil
        }

        let text = self.text?
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: "USD", with: "")

        if let finalText = text, let number = Double(finalText) {
            return number
        }

        return nil
    }

    public func cleanErrors() {
        guard let error = errorLabel else {
            return
        }

        error.text = ""
        border.backgroundColor = UITheme.Style.Colors.GrisAzulado.level3
        var borderFrame = border.frame
        borderFrame.size.height = 1
        border.frame = borderFrame
        hasError = false
        errorLabel!.textColor = UITheme.Style.Colors.GrisAzulado.level1
    }

    open func checkErrors() {
        guard let error = errorLabel else {
            return
        }

        if hasBadFormat {
            error.text = "TF_INVALID_FORMAT".localized
            hasError = true
        } else if isBelowMinimum {
            error.text = "TF_BELOW_MINIMUM".localized + Double(minimum!).displayAsClp(shouldShowSign: false)
            hasError = true
        } else if isOverMaximum {
            error.text = "TF_OVER_MAXIMUM".localized + Double(maximum!).displayAsClp(shouldShowSign: false)
            hasError = true
        } else if isOverAvailable {
            error.text = "TF_OVER_AVAIALBE".localized
            hasError = true
        } else {
            error.text = ""
            hasError = false
        }

        border.backgroundColor = hasError ? UITheme.Style.Colors.Rojo.level1 :
            UITheme.Style.Colors.GrisAzulado.level3
        atDelegate?.didPassErrorCheck(!hasError)
    }

    func setErrorMessage(message: String) {
        guard let error = errorLabel else {
            return
        }
        error.text = message
        hasError = !message.isEmpty // If message is empty, then there is no error
        border.backgroundColor = hasError ? UITheme.Style.Colors.Rojo.level1 :
            UITheme.Style.Colors.Azul.level0
        errorLabel!.textColor = hasError ? UITheme.Style.Colors.Rojo.level1 :
            UITheme.Style.Colors.GrisAzulado.level1

        var borderFrame = border.frame
        borderFrame.size.height = 2
        border.frame = borderFrame
        atDelegate?.didPassErrorCheck(!hasError && (cleanNumber() ?? 0.0) > 0.0)
    }
}

public class AmountTextFieldWithCustomError: AmountTextField {
    override public func checkErrors() {
        var errorMessage = ""
        if hasBadFormat {
            let defaultError = "TF_INVALID_FORMAT".localized
            errorMessage = errorMessages[.badFormat] ?? defaultError
        } else if isBelowMinimum {
            let defaultError = "TF_BELOW_MINIMUM".localized + Double(minimum!).displayAsClp(shouldShowSign: false)
            errorMessage = errorMessages[.belowMinimum] ?? defaultError
        } else if isOverMaximum {
            let defaultError = "TF_OVER_MAXIMUM".localized + Double(maximum!).displayAsClp(shouldShowSign: false)
            errorMessage = errorMessages[.overMaximum] ?? defaultError
        } else if isOverAvailable {
            let defaultError = "TF_OVER_AVAIALBE".localized
            errorMessage = errorMessages[.overAvailable] ?? defaultError
        } else {
            errorMessage = ""
        }
        setErrorMessage(message: errorMessage)
    }
}
