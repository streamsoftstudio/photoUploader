//
//  LoginViewController.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import UIKit

class LoginViewController: UIViewController, StoryboardInitializable {
	var networkServices: NetworkServices!
	@IBOutlet weak var usernameTextField: BorderedTextField!
	@IBOutlet weak var usernameErrorLabel: UILabel!
	@IBOutlet weak var passwordTextField: BorderedTextField!
	@IBOutlet weak var passwordErrorLabel: UILabel!
	@IBOutlet weak var officesTextField: BorderedTextField!
	@IBOutlet weak var officesErrorLabel: UILabel!
	var officePicker: UIPickerView!
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var scrollView: UIScrollView!
	
	var offices: [Office] = [Office(code: "100", name: "Hundred's Office"),
							 Office(code: "200", name: "Two Hundred's Office"),
							 Office(code: "300", name: "Three Hundred's Office"),
							 Office(code: "400", name: "Four Hundred's Office"),
							 Office(code: "500", name: "Five Hundred's Office"),
							 Office(code: "600", name: "Six Hundred's Office"),
							 Office(code: "700", name: "Seven Hundred's Office"),
							 Office(code: "800", name: "Eight Hundred's Office"),
							 Office(code: "900", name: "Nine Hundred's Office")]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		networkServices = NetworkServices()
		
		fetchOffices()
		
		officesTextField.delegate = self
		passwordTextField.passwordToggle = true
		passwordTextField.enablePasswordToggle(.always)
		
		officesTextField.enableRightImage(UIImage(systemName: "arrow.up.and.down.square")!, color: .mottoGray900)

        registerForKeyboardNotifications()
		dismissKeyboardOnViewTap()
		setupPicker()
		setupUI()
    }
	
	private func fetchOffices() {
		activityIndicator.startAnimating()
		networkServices.getOffices { result in
			switch result {
				case .failure(let error): print(error)
				case .success(let officeResponse):
					print(officeResponse.offices)
					self.offices = officeResponse.offices
					self.officePicker.reloadAllComponents()
					self.activityIndicator.stopAnimating()
					self.officesTextField.text = self.offices[0].name
			}
		}
	}
	
	private func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}
	
	@objc func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
			return
		}
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			bottomConstraint.constant = 20
		} else {
			bottomConstraint.constant = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
		}
		
		scrollView.keyboardDismissMode = .interactive
		scrollView.verticalScrollIndicatorInsets.bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
		scrollView.scrollRectToVisible(self.loginButton.frame, animated: true)
	}
	
	private func dismissKeyboardOnViewTap() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	private func setupPicker() {
		officePicker = UIPickerView()
		officePicker.delegate = self
		officePicker.dataSource = self
		officesTextField.inputView = officePicker
	}
	
	private func setupUI() {
		usernameErrorLabel.text = "Username is required"
		usernameErrorLabel.isHidden = true
		passwordErrorLabel.text = "Password is required"
		passwordErrorLabel.isHidden = true
		officesErrorLabel.text = "Office is required"
		officesErrorLabel.isHidden = true
	}

	@IBAction func loginButtonAction(_ sender: UIButton) {
		self.navigate() //temp call
		usernameErrorLabel.isHidden = usernameTextField.validate != nil
		passwordErrorLabel.isHidden = passwordTextField.validate != nil
		officesErrorLabel.isHidden = officesTextField.validate != nil
		
		guard let username = usernameTextField.validate,
			  let password = passwordTextField.validate,
			  let office = officesTextField.validate else {
				  print("Enter all fields")
				  return
			  }
		authenticate(username: username, password: password, office: office)
	}
	
	func authenticate(username: String, password: String, office: String) {
		self.networkServices.auth(username: username, password: password, office: office) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Successfully authenticated")
			}
		}
	}
	
	private func navigate() {
		let vc = TodaysAppointmentsViewController.initFromStoryboard()
		vc.modalPresentationStyle = .fullScreen
		vc.patients = [User(userName: "Dusan", facilityCode: "3700", token: "13054591-0"),
					   User(userName: "Milan", facilityCode: "3701", token: "12354629-0"),
					   User(userName: "Marko", facilityCode: "3702", token: "13042471-0"),
					   User(userName: "Slobodan", facilityCode: "3703", token: "1237832-0")]
		present(vc, animated: true, completion: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
}

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return offices.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return offices[row].name
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.officesTextField.text = self.offices[row].name
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == self.officesTextField {
			return false
		}
		return true
	}
}
