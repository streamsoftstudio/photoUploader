//
//  NavigationBar.swift
//  Motto
//
//  Created by Dusan Juranovic on 22.10.21..
//

import UIKit

protocol NavigationBarDelegate {
	func didSelectMenu()
}
class NavigationBar: UIView {

	private static let NIB_NAME = "NavigationBar"
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var menuButton: UIButton!
	@IBOutlet var view: UIView!
	var delegate: NavigationBarDelegate!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initWithNib()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initWithNib()
	}
	
	private func initWithNib() {
		Bundle.main.loadNibNamed(NavigationBar.NIB_NAME, owner: self, options: nil)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		setupUI()
	}
	
	private func setupUI() {
		//logo
		logoImageView.image = UIImage(named: "mottologo")
		
		//menu button
		let image = UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysTemplate)
		menuButton.setImage(image, for: .normal)
		menuButton.tintColor = .mottoBackgroundDark.withAlphaComponent(0.8)
		menuButton.layer.borderColor = UIColor.mottoBackgroundDark.withAlphaComponent(0.3).cgColor
		menuButton.layer.borderWidth = 1.0
		menuButton.layer.cornerRadius = 3.0
		
		//view
		view.backgroundColor = UIColor(hex: "4B82FF")
		NSLayoutConstraint.activate(
			[
				view.topAnchor.constraint(equalTo: topAnchor),
				view.leadingAnchor.constraint(equalTo: leadingAnchor),
				view.bottomAnchor.constraint(equalTo: bottomAnchor),
				view.trailingAnchor.constraint(equalTo: trailingAnchor),
			]
		)
	}
	
	@IBAction func menuBUttonTapped(_ sender: UIButton) {
		self.delegate.didSelectMenu()
	}
	
}
