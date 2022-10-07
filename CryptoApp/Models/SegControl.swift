import UIKit

final class SegControl {
	
	static let instantiate: UISegmentedControl = {
		
		let s = UISegmentedControl(items: ["Недорогие", "A-Z", "Дорогие"])
		s.backgroundColor = .systemGreen
		return s
	}()
}
