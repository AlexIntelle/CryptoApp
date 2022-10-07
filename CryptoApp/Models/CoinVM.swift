import Foundation

struct CoinVM {
	
	let name: String
	let symbol: String
	let price: String
	let priceLast24: String
	
	private let formatter = PriceFormatter.instantiate
	
	init(coin: CoinModel) {
		
		let priceStr = formatter.string(from: NSNumber(value: coin.data?.price?.usd ?? 0))
		
		name = coin.data?.name ?? "нет данных"
		symbol = coin.data?.symbol ?? "нет данных"
		price = priceStr ?? "нет данных"
		priceLast24 = String(format: "%.1f", coin.data?.price?.priceLast24 ?? "нет данных")
	}
}
