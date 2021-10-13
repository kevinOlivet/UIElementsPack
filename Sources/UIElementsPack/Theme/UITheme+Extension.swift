//
//  UITheme+Extension.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

// swiftlint:disable uitheme_not_UIColor missing_docs nesting

import BasicCommons
import UIKit

public typealias ColorsPaletteRGB = [ColorAsRGB]
public struct ColorAsRGB: Decodable {

    public let name: String
    public let red: String
    public let green: String
    public let blue: String

    public enum CodingKeys: String, CodingKey {
        case name
        case red
        case green
        case blue
    }
}

public enum ColorHelper {

    internal static var colorsFromJSON: [ColorAsRGB] = {
        let path = Utils.pathForJSON(resourceName: "PaletaColoresRGB", fromClass: BaseViewController.self)
        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url),
            let colors = try? JSONDecoder().decode(ColorsPaletteRGB.self, from: data) else {
                assertionFailure("cant parse PaletaColoresRGB.json")
                return []
        }
        return colors
    }()

    public static func getColorsAsRGB() {
        debugPrint(colorsFromJSON)
    }

    public static func MainColor(name: String) -> UIColor {
        let colorAsRGB = colorsFromJSON.first { aColor -> Bool in
            aColor.name == name
        }!

        return UIColor(
            red: Int(colorAsRGB.red)!,
            green: Int(colorAsRGB.green)!,
            blue: Int(colorAsRGB.blue)!
        )
    }

    public static func MainColor(hexString: String) -> UIColor {
        UIColor(hexString: hexString)
    }

    public static func MainColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
    }
}

public enum MainColorType: String {

    case verdeLevel0 = "Verde Primario - 500"
    case verdeLevel1 = "Verde Secundario - 400" //
    case verdeLevel2 = "Verde Opcional - 300"
    case verdeLevel3 = "Verde Opcional - 200"
    case verdeLevel4 = "Verde Opcional - 100"

    case rojoLevel0 = "Rojo Primario - 500"
    case rojoLevel1 = "Rojo Secundario - 400" //F13D47
    case rojoLevel2 = "Rojo Opcional - 300"
    case rojoLevel3 = "Rojo Opcional - 200"
    case rojoLevel4 = "Rojo Opcional - 100"

    case azulLevel0 = "Azul Primario - 500" //2772CC
    case azulLevel1 = "Azul Secundario - 400"
    case azulLevel2 = "Azul Opcional - 300"
    case azulLevel3 = "Azul Opcional - 200"
    case azulLevel4 = "Azul Opcional - 100"

    case amarilloLevel0 = "Amarillo Primario - 500"
    case amarilloLevel1 = "Amarillo Secundario - 400"
    case amarilloLevel2 = "Amarillo Opcional - 300"
    case amarilloLevel3 = "Amarillo Opcional - 200"
    case amarilloLevel4 = "Amarillo Opcional - 100"

    case grisAzuladoLevel0 = "Gris Primario - 500" //37474F
    case grisAzuladoLevel1 = "Gris Secundario - 400" //546E7A
    case grisAzuladoLevel2 = "Gris Opcional - 300"
    case grisAzuladoLevel3 = "Gris Opcional - 200"
    case grisAzuladoLevel4 = "Gris Opcional - 100" //F6F7F8

    case negro = "Negro"
    case blanco = "Blanco"
}

public extension UITheme {
    enum Style {
        public enum Colors {
            public enum GrisAzulado {
                /// Este color (GrisAzulado.level0) SI se puede utilizar en tipografías (Negro)
                public static let level0: UIColor = { //2b1f46
                    ColorHelper.MainColor(name: MainColorType.grisAzuladoLevel0.rawValue)
                }()
                /// Este color (GrisAzulado.level1) SI se puede utilizar en tipografías (Gris)
                public static let level1: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.grisAzuladoLevel1.rawValue)
                }()
                public static let level2: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.grisAzuladoLevel2.rawValue)
                }()
                public static let level3: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.grisAzuladoLevel3.rawValue)
                }()
                public static let level4: UIColor = { //F6F7F8
                    ColorHelper.MainColor(name: MainColorType.grisAzuladoLevel4.rawValue)
                }()
            }

            public enum Verde {
                public static let level0: UIColor = { //39998e
                    ColorHelper.MainColor(name: MainColorType.verdeLevel0.rawValue)
                }()
                public static let level1: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.verdeLevel1.rawValue)
                }()
                public static let level2: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.verdeLevel2.rawValue)
                }()
                public static let level3: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.verdeLevel3.rawValue)
                }()
                public static let level4: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.verdeLevel4.rawValue)
                }()
            }

            public enum Rojo {
                /// Este color (Rojo.level0) SI se puede utilizar en tipografías
                public static let level0: UIColor = { //bf2742
                    ColorHelper.MainColor(name: MainColorType.rojoLevel0.rawValue)
                }()
                public static let level1: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.rojoLevel1.rawValue)
                }()
                public static let level2: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.rojoLevel2.rawValue)
                }()
                public static let level3: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.rojoLevel3.rawValue)
                }()
                public static let level4: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.rojoLevel4.rawValue)
                }()
            }

            public enum Azul {
                /// Este color (Azul.level0) SI se puede utilizar en tipografías
                public static let level0: UIColor = { //255d83
                    ColorHelper.MainColor(name: MainColorType.azulLevel0.rawValue)
                }()
                public static let level1: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.azulLevel1.rawValue)
                }()
                public static let level2: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.azulLevel2.rawValue)
                }()
                public static let level3: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.azulLevel3.rawValue)
                }()
                public static let level4: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.azulLevel4.rawValue)
                }()
            }

            /// No se utlizan para textos
            public enum Amarillo {
                public static let level0: UIColor = { //f0d06b
                    ColorHelper.MainColor(name: MainColorType.amarilloLevel0.rawValue)
                }()
                public static let level1: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.amarilloLevel1.rawValue)
                }()
                public static let level2: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.amarilloLevel2.rawValue)
                }()
                public static let level3: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.amarilloLevel3.rawValue)
                }()
                public static let level4: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.amarilloLevel4.rawValue)
                }()
            }

            public enum Blanco {
                public static let level0: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.blanco.rawValue)
                }()
            }

            /// No se utlizan para textos
            public enum Negro {
                public static let level0: UIColor = {
                    ColorHelper.MainColor(name: MainColorType.negro.rawValue)
                }()
            }

            /// No se utlizan para textos
            public enum Extras {
                public static let shadow: UIColor = {
                    ColorHelper.MainColor(red: 0, green: 0, blue: 0, alpha: 0.1)
                }()
                public static let shadowLevel0: UIColor = {
                    ColorHelper.MainColor(red: 0, green: 0, blue: 0, alpha: 0)
                }()
                public static let shadowLevel1: UIColor = {
                    ColorHelper.MainColor(red: 0, green: 0, blue: 0, alpha: 0.15)
                }()
                public static let shadowLevel2: UIColor = {
                    ColorHelper.MainColor(red: 0, green: 0, blue: 0, alpha: 0.2)
                }()
                public static let shadowLevel3: UIColor = {
                    ColorHelper.MainColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                }()
                public static let shadowLevel4: UIColor = {
                    ColorHelper.MainColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)
                }()
                public enum GrisAlternativo {
                    public static let tipo0: UIColor = {
                        ColorHelper.MainColor(red: 0.33, green: 0.43, blue: 0.48, alpha: 1)
                    }()
                }
            }
        }

        public enum TipoGrafia {
            public static let A14 = UIFont.main_boldFont(withSize: 34)
            public static let A13 = UIFont.main_boldFont(withSize: 28)
            public static let A12 = UIFont.main_boldFont(withSize: 20)
            public static let A11 = UIFont.main_semiBoldFont(withSize: 18)
            public static let A10 = UIFont.main_semiBoldFont(withSize: 16)
            public static let A09 = UIFont.main_normalFont(withSize: 15)
            public static let A08 = UIFont.main_boldFont(withSize: 14)
            public static let A07 = UIFont.main_LightFont(withSize: 14)
            public static let A06 = UIFont.main_boldFont(withSize: 13)
            public static let A05 = UIFont.main_normalFont(withSize: 13)
            public static let A04 = UIFont.main_LightFont(withSize: 13)
            public static let A03 = UIFont.main_semiBoldFont(withSize: 12)
            public static let A02 = UIFont.main_LightFont(withSize: 12)
            public static let A01 = UIFont.main_normalFont(withSize: 11)
            public static let A00 = UIFont.main_LightFont(withSize: 11)
        }
    }
}
