import Foundation

final class API {
	
	public func fetchCoin(withName: String, completion: @escaping (Result<CoinModel, Error>) -> Void) {
		
		guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(withName)/metrics") else {return}

		URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
			
			guard let data = data, error == nil else {return}
			
			do {
				
				let coins = try JSONDecoder().decode(CoinModel.self, from: data)
				completion(.success(coins))
				
			} catch {
				
				completion(.failure(error))
			}
			
		}).resume()
	}
}
