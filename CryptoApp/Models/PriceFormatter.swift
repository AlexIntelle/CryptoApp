import Foundation

final class PriceFormatter {
	
	static let instantiate: NumberFormatter = {
		
		let f = NumberFormatter()
		f.locale = .current
		f.allowsFloats = true
		f.numberStyle = NumberFormatter.Style.decimal
		f.formatterBehavior = .default
		f.maximumFractionDigits = 6
		f.decimalSeparator = "."
		f.groupingSeparator = "."
		return f
	}()
}
