import UIKit

final class AuthenticationVC: UIViewController, UITextFieldDelegate {
	
	var lable = UILabel()
	var login = UITextField()
	var password = UITextField()
	var OkButton = UIButton()
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .orange
		view.addSubview(lable)
		view.addSubview(login)
		view.addSubview(password)
		view.addSubview(OkButton)
		
		lable.constraintAsTopMostView(in: view)
		lable.authAdvice()
		
		login.constraintAsInnerView(to: lable, spacing: nil)
		login.authTextField(withPlaceholder: "Логин")
		login.delegate = self
		
		password.constraintAsInnerView(to: login, spacing: nil)
		password.authTextField(withPlaceholder: "Пароль")
		password.delegate = self
		
		OkButton.constraintAsInnerView(to: password, spacing: nil)
		OkButton.makeGreenButton(withLabel: "Войти")
		OkButton.addTarget(self, action: #selector(goToCoinsTableVC), for: .touchUpInside)
	}
	
	@objc func goToCoinsTableVC() {
		
		guard let loginTextCount = login.text?.count else {return}
		guard let passTextCount = password.text?.count else {return}
		
		if loginTextCount > 4 && passTextCount > 4 {
			
			let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
			sceneDelegate.switchRootControllerTo(CoinsTableVC(), logOut: false)
			
		} else {
			
			lable.text = "Логин или пароль должны содержать более 4-х символов"
			lable.backgroundColor = .systemFill
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		return true
	}
}
