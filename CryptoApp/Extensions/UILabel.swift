import UIKit

extension UILabel {
	
	func authAdvice() {
		
		numberOfLines = 2
		adjustsFontSizeToFitWidth = true
		textAlignment = .center
		textColor = .secondaryLabel
		
	}
	
	func coinDetail() {
		
		numberOfLines = 1
		adjustsFontSizeToFitWidth = true
		textAlignment = .center
		textColor = .black
		font = UIFont(name: "Menlo Regular", size: 20)
	}
	
	func coinDetailPercent() {
		
		numberOfLines = 2
		
		layer.borderWidth = 2.0
		layer.cornerRadius = 8
		backgroundColor = .systemGreen
		layer.masksToBounds = true
		
		adjustsFontSizeToFitWidth = true
		textAlignment = .center
		textColor = .black
		font = UIFont(name: "Menlo Regular", size: 25)
	}
}
