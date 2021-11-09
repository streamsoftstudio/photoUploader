//
//  string.swift
//  Sony 360 RA
//
//  Created by Dusan Juranovic on 17.9.21..
//

import UIKit

extension String {
	
	/// Creates a localized string, with a clickable portion of text
	/// - Parameter url: URL string we wish to navigate to
	/// - Note: Use `<a>` and `</a>` tags in your `.strings` file, to surround desired, clickable text
	func localizedStringWithUrl(_ url: [String], color: UIColor, font: UIFont = UIFont(name: "Roboto-Medium", size: 12)!) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self.localized)
		attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.string.count))
		attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.string.count))
		
		let regex = try! NSRegularExpression(pattern: #"(<)(/?a)(>)"#, options: .caseInsensitive)
		let matches = regex.matches(in: attributedString.string, options: [], range: NSRange(location: 0, length: attributedString.string.count))
		var urlCounter = 0
		//find range for hyperlink between tags, if no tags provided return nil
		for i in 0..<matches.count where i % 2 == 0 {
			let start = matches[i].range.upperBound
			let end = matches[i+1].range.lowerBound
			//get substring between tags
			let substring = attributedString.string[start..<end]
			
			//get range of substring
			let foundRange = attributedString.mutableString.range(of: substring)
			
			attributedString.addAttributes(
				[
					NSAttributedString.Key.link: url[urlCounter],
					NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
				], range: foundRange)
			
			urlCounter += 1
		}
		//cleanup tags
		attributedString.mutableString.replaceOccurrences(of: "<a>",
														  with: "",
														  options: .caseInsensitive,
														  range: NSRange(location: 0, length: attributedString.string.count))
		
		attributedString.mutableString.replaceOccurrences(of: "</a>",
														  with: "",
														  options: .caseInsensitive,
														  range: NSRange(location: 0, length: attributedString.string.count))
		
		
		return attributedString
	}
	
	/// Creates a localized string, with customized portions of text
	/// - Note: Use `<u>` and `</u>` tags in your `.strings` file, to surround desired, customizable text.
	func localizedStringCustomRanges(_ color: UIColor, font: UIFont = UIFont(name: "Roboto-Regular", size: 14)!, underline: Bool = true) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self.localized)
		attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.string.count))
		
		let regex = try! NSRegularExpression(pattern: #"(<)(/?u)(>)"#, options: .caseInsensitive)
		let matches = regex.matches(in: attributedString.string, options: [], range: NSRange(location: 0, length: attributedString.string.count))
		var urlCounter = 0
		//find range for hyperlink between tags, if no tags provided return nil
		for i in 0..<matches.count where i % 2 == 0 {
			let start = matches[i].range.upperBound
			let end = matches[i+1].range.lowerBound
			//get substring between tags
			let substring = attributedString.string[start..<end]
			
			//get range of substring
			let foundRange = attributedString.mutableString.range(of: substring)
			
			if underline {
				attributedString.addAttributes(
					[
						NSAttributedString.Key.foregroundColor: color,
						NSAttributedString.Key.underlineColor: color,
						NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
					], range: foundRange)
			} else {
				attributedString.addAttributes(
					[
						NSAttributedString.Key.foregroundColor: color,
					], range: foundRange)
			}
			
			urlCounter += 1
		}
		//cleanup tags
		attributedString.mutableString.replaceOccurrences(of: "<u>",
														  with: "",
														  options: .caseInsensitive,
														  range: NSRange(location: 0, length: attributedString.string.count))
		
		attributedString.mutableString.replaceOccurrences(of: "</u>",
														  with: "",
														  options: .caseInsensitive,
														  range: NSRange(location: 0, length: attributedString.string.count))
		
		
		return attributedString
	}
	
	/// Creates a localized string with image
	/// - Parameter image: UIImage to be inserted in the text
	/// - Note: Use `<i>`  tag in your `.strings` file, to mark the place where image should be inserted
	func localizedStringWithImage(_ image: UIImage = UIImage()) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self.localized)
		//Find placeholder where image should be inserted, if none, localized string is returned without the image
		//Only "<" is used to determine Index - entire tag "<i>" is for explicatory purposes
		guard let mark = attributedString.string.firstIndex(of: "<") else {return attributedString}
		
		//Index where image will be inserted
		let index = attributedString.string[..<mark].count
		
		//remove tag
		attributedString.mutableString.replaceOccurrences(of: "<i>",
														  with: "",
														  options: .caseInsensitive,
														  range: NSRange(location: 0, length: attributedString.string.count))
		
		//Create image attachemnt string
		let imageAttachment = NSTextAttachment()
		imageAttachment.image = image
		let imageString = NSAttributedString(attachment: imageAttachment)
		
		//Add image to attributed text
		attributedString.insert(imageString, at: index)
		
		return attributedString
	}
}


extension String {
	subscript (bounds: CountableClosedRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start...end])
	}

	subscript (bounds: CountableRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start..<end])
	}
}

extension String {
	func underline(ignoringPrefix: Int = 0) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		let attr = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]

		attributedString.addAttributes(attr, range: NSRange(location: ignoringPrefix, length: self.count - ignoringPrefix))
		
		return attributedString
	}
}

extension String {
	var camelcased: String {
		let firstLetter = self.first!.lowercased()
		return firstLetter + self.dropFirst(1)
	}
}
