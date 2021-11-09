//
//  Identifiable.swift
//  Motto
//
//  Created by Dusan Juranovic on 28.10.21..
//

import Foundation

protocol Identifiable {}

extension Identifiable {
	static var className: String {
		return String(describing: Self.self)
	}
	static var identifier: String {
		return String(describing: Self.self).camelcased
	}
}
