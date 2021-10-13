//
//  MontoLabel.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

//swiftlint:disable identifier_name

import CommonsPack

open class MontoLabel: UILabel {

    public enum MontoLabelSize {
        case large
        case medium
        case small
    }

    public enum MontoLabelCurrency {
        case clp
        case usd
        case uf
    }

    public enum MontoLabelFontWeight {
        case light
        case regular
        case bold
    }

    private var _proportionalFontSize: CGFloat = 1.0

    /// proportionalFontSize - Between 0.0 and 1.0 proportional sizes
    public var proportionalFontSize: CGFloat {
        set(newValue) {
            _proportionalFontSize = min(max(newValue, 0.0), 1.0)
            formatText()
        }

        get {
            _proportionalFontSize
        }
    }

    public var defaultColor = UITheme.Style.Colors.GrisAzulado.level0 {
        didSet {
            formatText()
        }
    }
    public var size: MontoLabelSize = .small {
        didSet {
            formatText()
        }
    }

    public var currency: MontoLabelCurrency = .clp {
        didSet {
            formatText()
        }
    }

    public var fontWeight: MontoLabelFontWeight = .bold {
        didSet {
            formatText()
        }
    }

    public var monto: Double = 0.0 {
        didSet {
            formatText()
        }
    }
    public var precision: Int = 0 {
        didSet {
            formatText()
        }
    }
    public var highlightSign: Bool = false {
        didSet {
            formatText()
        }
    }
    public var positiveHighlightColor: UIColor? {
        didSet {
            formatText()
        }
    }
    public var negativeHighlightColor: UIColor? {
        didSet {
            formatText()
        }
    }
    public var zeroHighlightColor: UIColor? {
        didSet {
            formatText()
        }
    }

    /// Same as formatText method but with UF
    public func formatTextWithUFCurrency(_ monto: Double) {
        adjustsFontSizeToFitWidth = true
        let montoText = NSAttributedString(
            string: monto.displayAsUF(shouldShowSign: false),
            attributes: getMontoAttributes()
        )
        attributedText = montoText
    }

    func formatText() {
        adjustsFontSizeToFitWidth = true
        let montoText = NSMutableAttributedString()
        montoText.append(NSAttributedString(string: getSymbol(), attributes: getSymbolAttributes()))
        montoText.append(NSAttributedString(string: " ", attributes: getSeparatorAttributes()))
        montoText.append(NSAttributedString(string: getFormattedValue(), attributes: getMontoAttributes()))
        attributedText = montoText
    }

    private func getSymbol() -> String {
        var symbol = ""
        switch currency {
        case .clp:
            symbol = "$"
        case .usd:
            symbol = "US$"
        case .uf:
            symbol = "UF"
        }
        if monto < 0.0 {
            return "-" + symbol
        } else {
            return symbol
        }
    }

    private func getSymbolAttributes() -> [NSAttributedString.Key: Any] {
        var symbolFontColor = defaultColor
        if highlightSign {
            symbolFontColor = getFontColorBasedOnMontoSign()
        }
        switch self.size {
        case .small:
            return [
                NSAttributedString.Key.foregroundColor: symbolFontColor,
                NSAttributedString.Key.font: UIFont.main_LightFont(withSize: 9 * proportionalFontSize),
                NSAttributedString.Key.baselineOffset: 1
            ]
        case .medium:
            return [
                NSAttributedString.Key.foregroundColor: symbolFontColor,
                NSAttributedString.Key.font: UIFont.main_LightFont(withSize: 11 * proportionalFontSize),
                NSAttributedString.Key.baselineOffset: 2
            ]
        case .large:
            return [
                NSAttributedString.Key.foregroundColor: symbolFontColor,
                NSAttributedString.Key.font: UIFont.main_LightFont(withSize: 22 * proportionalFontSize),
                NSAttributedString.Key.baselineOffset: 3
            ]
        }
    }

    func getSeparatorAttributes() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: UIFont.main_LightFont(withSize: 10 * proportionalFontSize)]
    }

    private func getMontoAttributes() -> [NSAttributedString.Key: Any] {
        let montoFontColor = getFontColorBasedOnMontoSign()
        let montoSize = getMontoSize()

        switch self.fontWeight {
        case .light:
            return [
                NSAttributedString.Key.foregroundColor: montoFontColor,
                NSAttributedString.Key.font: UIFont.main_LightFont(withSize: montoSize)
            ]
        case .regular:
            return [
                NSAttributedString.Key.foregroundColor: montoFontColor,
                NSAttributedString.Key.font: UIFont.main_normalFont(withSize: montoSize)
            ]
        case .bold:
            return [
                NSAttributedString.Key.foregroundColor: montoFontColor,
                NSAttributedString.Key.font: UIFont.main_boldFont(withSize: montoSize)
            ]
        }
    }

    private func getMontoSize() -> CGFloat {
        switch self.size {
        case .small:
            return 13 * proportionalFontSize
        case .medium:
            return 20 * proportionalFontSize
        case .large:
            return 34 * proportionalFontSize
        }
    }

    private func getFontColorBasedOnMontoSign() -> UIColor {
        if positiveHighlightColor != nil && monto > 0.0 {
            return positiveHighlightColor!
        } else if negativeHighlightColor != nil && monto < 0.0 {
            return negativeHighlightColor!
        } else if zeroHighlightColor != nil && monto == 0.0 {
            return zeroHighlightColor!
        } else {
            return defaultColor
        }
    }

    private func getFormattedValue() -> String {
        let formatter = CommonNumberFormatter()
        formatter.minimumFractionDigits = precision
        formatter.maximumFractionDigits = precision
        guard let formattedAbsoluteValue = formatter.string(from: abs(monto) as NSNumber) else {
            return ""
        }
        return formattedAbsoluteValue
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
