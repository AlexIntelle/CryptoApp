import UIKit

extension UIButton {
	
	func makeGreenButton(withLabel: String) {
		
		backgroundColor = .systemGreen
		layer.cornerRadius = 10
		layer.borderWidth = 1
		layer.borderColor = UIColor.black.cgColor
		setTitle("\(withLabel)", for: .normal)
		titleLabel?.font = .systemFont(ofSize: 25)
	}
	
	func makeRedButton(withLabel: String) {
		
		backgroundColor = .systemRed
		layer.cornerRadius = 10
		layer.borderWidth = 2
		layer.borderColor = UIColor.black.cgColor
		setTitle("\(withLabel)", for: .normal)
		titleLabel?.font = .systemFont(ofSize: 25)
	}
}
