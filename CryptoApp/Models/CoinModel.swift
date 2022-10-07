

struct CoinModel: Decodable {
	
	let data: Data?
}

struct Data: Decodable {
	
	let name: String?
	let symbol: String?
	let price: Price?
	
	enum CodingKeys: String, CodingKey {
		
		case name
		case symbol
		case price = "market_data"
	}
}

struct Price: Decodable {
	
	let usd: Double?
	let priceLast24: Double?
	
	enum CodingKeys: String, CodingKey {
		
		case usd = "price_usd"
		case priceLast24 = "percent_change_usd_last_24_hours"
	}
}
