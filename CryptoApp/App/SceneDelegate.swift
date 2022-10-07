import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	let defaults = UserDefaults.standard
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		// выбор контроллера при запуске
		let controller: UIViewController = {
			
			var vc: UIViewController?

			let str = defaults.string(forKey: "state")
			let state = UserState(rawValue: str ?? UserState.firstRun.rawValue)
			
			if state?.rawValue == UserState.loggedIn.rawValue {
				vc = CoinsTableVC()
			} else {
				vc = AuthenticationVC()
			}
			
			return vc!
		}()
		
		guard let windowScene = (scene as? UIWindowScene) else {return}
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = controller
		window?.makeKeyAndVisible()
	}
	
	// смена контроллера, сохранение стэйта
	func switchRootControllerTo(_ controller: UIViewController, logOut: Bool) {
		
		logOut ? defaults.set(UserState.loggedOut.rawValue, forKey: "state")
			: defaults.set(UserState.loggedIn.rawValue, forKey: "state")
		
		window?.rootViewController = controller
		window?.makeKeyAndVisible()
		
		guard let w = window else {return}
		UIView.transition(with: w,
						duration: 0.3,
						options: .transitionFlipFromRight,
						animations: nil,
						completion: nil)
	}
}
