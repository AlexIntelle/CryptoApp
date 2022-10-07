import UIKit

final class CoinCell: UITableViewCell {
	
	static let id = "CoinCell"
	
	// MARK: - LABELS
	
	private let symbol: UILabel = {
		let l = UILabel()
		l.font = .systemFont(ofSize: 20, weight: .medium)
		return l
	}()
	
	private let price: UILabel = {
		let l = UILabel()
		l.font = .systemFont(ofSize: 20, weight: .semibold)
		l.textAlignment = .right
		l.textColor = .orange
		return l
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.addSubview(symbol)
		contentView.addSubview(price)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - LAYOUT
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		symbol.sizeToFit()
		price.sizeToFit()
		
		symbol.frame = CGRect(x: 10, y: (contentView.frame.size.height/2)-10, width: contentView.frame.size.width/2, height: (contentView.frame.size.height/2))
		price.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: (contentView.frame.size.width/2)-10, height: contentView.frame.size.height)
	}
	
	// MARK: - View Model
	
	func configure(by viewModel: CoinVM) {
		
		symbol.text = viewModel.symbol
		price.text = viewModel.price
	}
}
