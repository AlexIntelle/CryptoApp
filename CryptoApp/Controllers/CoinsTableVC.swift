import UIKit

final class CoinsTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var logoutButton = UIButton()
	let reloadButton = UIButton()
	let table = UITableView()
	let segControl = SegControl.instantiate
	
	let api = API()
	let group = DispatchGroup()
	lazy var spinner = LoadingIndicator.configureIndicator(in: self.view)
	
	// data source
	var viewModels = [CoinVM]()
	let coinNames = CoinName.allCases
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .orange
		view.addSubview(logoutButton)
		view.addSubview(reloadButton)
		view.addSubview(table)
		
		logoutButton.constraintAsTopMostView(in: view)
		logoutButton.makeRedButton(withLabel: "выйти")
		logoutButton.addTarget(self, action: #selector(goToAuthenticationVC), for: .touchUpInside)
		
		reloadButton.constraintAsInnerView(to: logoutButton, spacing: nil)
		reloadButton.makeGreenButton(withLabel: "обновить")
		reloadButton.addTarget(self, action: #selector(loadTable), for: .touchUpInside)
		
		table.dataSource = self
		table.delegate = self
		table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.id)
		
		layoutTable()
		loadTable()
	}
	
	// MARK: - API
	
	func addCoinToViewModels(named: CoinName) {
		
		group.enter()
		
		api.fetchCoin(withName: named.rawValue) { [weak self] result in
			
			switch result {
			
			case .success(let coin):
				// наполним data source
				self?.viewModels.append(CoinVM.init(coin: coin))
				
				DispatchQueue.main.async {
					self?.table.reloadData()
				}
				
			case .failure(let error):
				print("Error: \(error)")
				
			}
			
			self?.group.leave()
		}
	}
	
	// MARK: - TABLE
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return viewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		group.wait()
		
		let cell = table.dequeueReusableCell(withIdentifier: CoinCell.id, for: indexPath) as? CoinCell
		
		cell?.configure(by: viewModels[indexPath.row])
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		// MARK: остановка спиннера
		
		guard let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last else {return}
		lastVisibleIndexPath != indexPath ? spinner.stopAnimating() : ()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// MARK: передача вью модели монеты в новый контроллер
		
		let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
		sceneDelegate.switchRootControllerTo(CoinDetailsVC(coinToShow: viewModels[indexPath.row]), logOut: false)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		// MARK: хедер с сортировкой(SegmentedControl)
		
		let header = UIView()
		header.addSubview(segControl)
		
		segControl.translatesAutoresizingMaskIntoConstraints = false
		segControl.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
		segControl.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
		segControl.addTarget(self, action: #selector(sortTable), for: .valueChanged)
		
		return header
	}
	
	// MARK: - LAYOUT
	
	func layoutTable() {
		
		table.translatesAutoresizingMaskIntoConstraints = false
		table.topAnchor.constraint(equalTo: reloadButton.bottomAnchor, constant: 25).isActive = true
		table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		table.backgroundColor = .orange
	}
	
	// MARK: - Экшены
	
	@objc func goToAuthenticationVC() {
		let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
		sceneDelegate.switchRootControllerTo(AuthenticationVC(), logOut: true)
	}
	
	@objc func loadTable() {
		
		// заполнить таблицу, только если data source пустой
		
		!viewModels.isEmpty ? viewModels = [] : ()
		spinner.startAnimating()
		
		(0...coinNames.count - 1).forEach { name in
			
			addCoinToViewModels(named: coinNames[name])
		}
	}
	
	@objc func sortTable() {
		
		if segControl.selectedSegmentIndex == 0 {
			self.viewModels.sort {$0.price.localizedStandardCompare($1.price) == .orderedAscending }
		}
		
		if segControl.selectedSegmentIndex == 1 {
			self.viewModels.sort { $0.symbol < $1.symbol }
		}
		
		if segControl.selectedSegmentIndex == 2 {
			self.viewModels.sort {$0.price.localizedStandardCompare($1.price) == .orderedDescending }
		}
		
		table.reloadData()
	}
}
