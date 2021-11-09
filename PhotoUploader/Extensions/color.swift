//
//  color.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/24/21.
//

import Foundation
import UIKit
extension UIColor
{
    public convenience init(hex: String) {
        var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0, a: CGFloat = 0

        let start = hex.index(hex.startIndex, offsetBy:  hex.hasPrefix("#") ? 1 : 0)
        var hexColor = String(hex[start...])

        if hexColor.count == 6 {
            hexColor += "FF"
        }
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

            }
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
        
        return
    }
}

extension UIColor {
	///Blue
	static var mottoPrimary700: UIColor {
		return ThemeManager.currentTheme().mottoPrimary700
	}
	///Blue
	static var mottoPrimary500: UIColor {
		return ThemeManager.currentTheme().mottoPrimary500
	}
	///Blue
	static var mottoPrimary300: UIColor {
		return ThemeManager.currentTheme().mottoPrimary300
	}
	///Aqua
	static var mottoSecondary700: UIColor {
		return ThemeManager.currentTheme().mottoSecondary700
	}
	///Aqua
	static var mottoSecondary500: UIColor {
		return ThemeManager.currentTheme().mottoSecondary500
	}
	///Aqua
	static var mottoSecondary300: UIColor {
		return ThemeManager.currentTheme().mottoSecondary300
	}
	///Green
	static var mottoSuccess700: UIColor {
		return ThemeManager.currentTheme().mottoSuccess700
	}
	///Green
	static var mottoSuccess500: UIColor {
		return ThemeManager.currentTheme().mottoSuccess500
	}
	///Green
	static var mottoSuccess300: UIColor {
		return ThemeManager.currentTheme().mottoSuccess300
	}
	///Red
	static var mottoError700: UIColor {
		return ThemeManager.currentTheme().mottoError700
	}
	///Red
	static var mottoError500: UIColor {
		return ThemeManager.currentTheme().mottoError500
	}
	///Red
	static var mottoError300: UIColor {
		return ThemeManager.currentTheme().mottoError300
	}
	///Yellow
	static var mottoWarning700: UIColor {
		return ThemeManager.currentTheme().mottoWarning700
	}
	///Yellow
	static var mottoWarning500: UIColor {
		return ThemeManager.currentTheme().mottoWarning500
	}
	///Yellow
	static var mottoWarning300: UIColor {
		return ThemeManager.currentTheme().mottoWarning300
	}
	///Blue
	static var mottoInfo700: UIColor {
		return ThemeManager.currentTheme().mottoInfo700
	}
	///Blue
	static var mottoInfo500: UIColor {
		return ThemeManager.currentTheme().mottoInfo500
	}
	///Blue
	static var mottoInfo300: UIColor {
		return ThemeManager.currentTheme().mottoInfo300
	}
	static var mottoTextDarkBrand: UIColor {
		return ThemeManager.currentTheme().mottoTextDarkBrand
	}
	static var mottoTextDark: UIColor {
		return ThemeManager.currentTheme().mottoTextDark
	}
	static var mottoTextDisabled: UIColor {
		return ThemeManager.currentTheme().mottoTextDisabled
	}
	static var mottoTextLight: UIColor {
		return ThemeManager.currentTheme().mottoTextLight
	}
	static var mottoBackgroundDark: UIColor {
		return ThemeManager.currentTheme().mottoBackgroundDark
	}
	static var mottoBackgroundLight: UIColor {
		return ThemeManager.currentTheme().mottoBackgroundLight
	}
	static var mottoBackgroundWhite: UIColor {
		return ThemeManager.currentTheme().mottoBackgroundWhite
	}
	static var mottoGrayWhite: UIColor {
		return ThemeManager.currentTheme().mottoGrayWhite
	}
	static var mottoGray100: UIColor {
		return ThemeManager.currentTheme().mottoGray100
	}
	static var mottoGray300: UIColor {
		return ThemeManager.currentTheme().mottoGray300
	}
	static var mottoGray700: UIColor {
		return ThemeManager.currentTheme().mottoGray700
	}
	static var mottoGray900: UIColor {
		return ThemeManager.currentTheme().mottoGray900
	}
}
