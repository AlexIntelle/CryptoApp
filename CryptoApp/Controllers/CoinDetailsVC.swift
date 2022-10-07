import UIKit

final class CoinDetailsVC: UIViewController {
	
	let exitButton = UIButton()
	let backButton = UIButton()
	
	var name = UILabel()
	var symbol = UILabel()
	var price = UILabel()
	var priceLast24 = UILabel()
	
	let api = API()
	let coin: CoinVM
	
	init(coinToShow: CoinVM) {
		self.coin = coinToShow
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .orange
		
		[exitButton, backButton, name, symbol, price, priceLast24].forEach {
			view.addSubview($0)
		}
		
		// MARK: конфигурация кнопок
		
		exitButton.constraintAsTopMostView(in: view)
		exitButton.makeRedButton(withLabel: "выйти")
		exitButton.addTarget(self, action: #selector(goToAuthenticationVC), for: .touchUpInside)
		
		backButton.constraintAsInnerView(to: exitButton, spacing: nil)
		backButton.makeGreenButton(withLabel: "< назад")
		backButton.addTarget(self, action: #selector(goBackToCoinsTableVC), for: .touchUpInside)
		
		// MARK: конфигурация лэйблов
		
		name.constraintAsInnerView(to: backButton, spacing: nil)
		name.coinDetail()
		symbol.constraintAsInnerView(to: name, spacing: 10)
		symbol.coinDetail()
		price.constraintAsInnerView(to: symbol, spacing: 10)
		price.coinDetail()
		priceLast24.constraintAsInnerView(to: price, spacing: 10)
		priceLast24.coinDetailPercent()
		
		showCoinDetails(of: self.coin)
	}
	
	func showCoinDetails(of coin: CoinVM) {
		
		name.text = "Название: \(coin.name)"
		symbol.text = "Символ: \(coin.symbol)"
		price.text = "Цена: \(coin.price)"
		priceLast24.text = "За сутки \(coin.priceLast24) %"
		
		if priceLast24.text!.contains("-") {
			priceLast24.backgroundColor = .systemRed
		}
	}
	
	// MARK: - Экшены кнопок
	
	@objc func goBackToCoinsTableVC() {
		
		let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
		sceneDelegate.switchRootControllerTo(CoinsTableVC(), logOut: false)
	}
	
	@objc func goToAuthenticationVC() {
		
		let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
		sceneDelegate.switchRootControllerTo(AuthenticationVC(), logOut: true)
	}
}
