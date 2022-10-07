import UIKit

extension UITextField {
	
	func authTextField(withPlaceholder: String) {
		
		backgroundColor = UIColor.init(red: 213.0/255.0, green: 207.0/255.0, blue: 207.0/255.0, alpha: 1)
		layer.cornerRadius = 10
		placeholder = "   \(withPlaceholder)"
		isSecureTextEntry = true
		font = .systemFont(ofSize: 30)
	}
}
