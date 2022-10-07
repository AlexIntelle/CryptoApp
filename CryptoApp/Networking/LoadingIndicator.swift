import UIKit

final class LoadingIndicator {
	
	static func configureIndicator(in view: UIView) -> UIActivityIndicatorView {
		
		var indicator = UIActivityIndicatorView()
		
		indicator = UIActivityIndicatorView(
			frame: CGRect(x: 0, y: 0,
			width: view.frame.width,
			height: view.frame.height)
		)
		
		indicator.style = UIActivityIndicatorView.Style.large
		indicator.center = view.center
		view.addSubview(indicator)
		indicator.backgroundColor = UIColor.white
		indicator.hidesWhenStopped = true
		
		return indicator
	}
}
