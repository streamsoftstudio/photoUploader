//
//  ThemeManager.swift
//  Motto
//
//  Created by Dusan Juranovic on 19.10.21..
//

import Foundation
import UIKit

enum Theme: Int {
	
	case theme1, theme2
	
	//Customizing the Navigation Bar
	var barStyle: UIBarStyle {
		switch self {
			case .theme1:
				return .black
			case .theme2:
				return .default
				
		}
	}
	
	///TabBar Background color
	var tabBarTintColor: UIColor {
		switch self {
			case .theme1, .theme2:
				return mottoBackgroundDark
		}
	}
	///NavigationBar background color
	var navigationBarTintColor: UIColor {
		switch self {
			case .theme1, .theme2:
				return mottoBackgroundWhite
		}
	}
	
	//TabBar selected tab tint color
	var tabTintColor: UIColor {
		switch self {
			case .theme1, .theme2:
				return mottoSecondary700
		}
	}
	
	//TabBar unselected tab tint color
	var tabUnselectedTintColor: UIColor {
		switch self {
			case .theme1, .theme2:
				return mottoPrimary300
		}
	}
	
	var navigationTextColor: UIColor {
		switch self {
			case .theme1, .theme2:
				return .mottoTextLight
		}
	}
	
	var header:UIColor {
		switch self {
			case .theme1, .theme2:
				return .black
		}
	}
	
	var toastColor : UIColor {
		switch self {
			case .theme1, .theme2:
				return mottoWarning700
		}
	}
	
	var mottoPrimary700: UIColor {
		return UIColor(hex: "2969FF")
	}
	var mottoPrimary500: UIColor {
		return UIColor(hex:"C2D4FF")
	}
	var mottoPrimary300: UIColor {
		return UIColor(hex:"EBF1FF")
	}
	var mottoSecondary700: UIColor {
		return UIColor(hex:"00A997")
	}
	var mottoSecondary500: UIColor {
		return UIColor(hex:"2EDBC9")
	}
	var mottoSecondary300: UIColor {
		return UIColor(hex: "C0F4EF")
	}
	var mottoSuccess700: UIColor {
		return UIColor(hex: "00936E")
	}
	var mottoSuccess500: UIColor {
		return UIColor(hex: "A4E2B4")
	}
	var mottoSuccess300: UIColor {
		return UIColor(hex: "E0F5E5")
	}
	var mottoError700: UIColor {
		return UIColor(hex: "D53434")
	}
	var mottoError500: UIColor {
		return UIColor(hex: "F2C2C2")
	}
	var mottoError300: UIColor {
		return UIColor(hex: "FBEBEB")
	}
	var mottoWarning700: UIColor {
		return UIColor(hex: "FFD96A")
	}
	var mottoWarning500: UIColor {
		return UIColor(hex: "FFEC9F")
	}
	var mottoWarning300: UIColor {
		return UIColor(hex: "FFF8D1")
	}
	var mottoInfo700: UIColor {
		return UIColor(hex: "004BB9")
	}
	var mottoInfo500: UIColor {
		return UIColor(hex: "B9DEFA")
	}
	var mottoInfo300: UIColor {
		return UIColor(hex: "E5F2FF")
	}
	var mottoTextDarkBrand: UIColor {
		return UIColor(hex: "002954")
	}
	var mottoTextDark: UIColor {
		return UIColor(hex: "434A4F")
	}
	var mottoTextDisabled: UIColor {
		return UIColor(hex: "767F84")
	}
	var mottoTextLight: UIColor {
		return UIColor(hex: "FFFFFF")
	}
	var mottoBackgroundDark: UIColor {
		return UIColor(hex: "002954")
	}
	var mottoBackgroundLight: UIColor {
		return UIColor(hex: "F0F0F0")
	}
	var mottoBackgroundWhite: UIColor {
		return UIColor(hex: "FFFFFF")
	}
	var mottoGrayWhite: UIColor {
		return UIColor(hex: "FFFFFF")
	}
	var mottoGray100: UIColor {
		return UIColor(hex: "F0F0F0")
	}
	var mottoGray300: UIColor {
		return UIColor(hex: "E0E0E0")
	}
	var mottoGray700: UIColor {
		return UIColor(hex: "767F84")
	}
	var mottoGray900: UIColor {
		return UIColor(hex: "434A4F")
	}
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
class ThemeManager {
	
	// ThemeManager
	static func currentTheme() -> Theme {
		if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
			return Theme(rawValue: storedTheme)!
		} else {
			return .theme2
		}
	}
	
	static func applyTheme(theme: Theme)
	{
		// First persist the selected theme using NSUserDefaults.
		UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
		UserDefaults.standard.synchronize()
		
		
		UITabBar.appearance().barTintColor = theme.tabBarTintColor
		UITabBar.appearance().tintColor = theme.tabTintColor
		UITabBar.appearance().unselectedItemTintColor = theme.tabUnselectedTintColor
		UITabBar.appearance().isTranslucent = false
		
		UINavigationBar.appearance().barTintColor = theme.navigationBarTintColor
		UINavigationBar.appearance().tintColor = theme.navigationTextColor
		UINavigationBar.appearance().isTranslucent = false
		// UINavigationBar.appearance().prefersLargeTitles = true
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.navigationTextColor]
	}
	
}

