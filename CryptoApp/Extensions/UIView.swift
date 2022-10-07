import UIKit

extension UIView {
	
	func constraintAsInnerView(to overheadView: UIView, spacing: CGFloat?) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: overheadView.bottomAnchor, constant: spacing ?? 40),
			leadingAnchor.constraint(equalTo: overheadView.leadingAnchor),
			heightAnchor.constraint(equalToConstant: 50),
			widthAnchor.constraint(equalTo: overheadView.widthAnchor)
		])
	}
	
	func constraintAsTopMostView(in superView: UIView) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superView.topAnchor, constant: 100),
			leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 25),
			heightAnchor.constraint(equalToConstant: 50),
			widthAnchor.constraint(equalTo: superView.widthAnchor, constant: -40)
		])
	}
}
