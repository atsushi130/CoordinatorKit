<p align="center">
    <h1 align="center">CoordinatorKit</h1>
</p1>

<p align="center"><i>Coordinator and RoutableViewController</i></p>

<p align="center">
    <a href=".license-mit"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a> 
    <img src="https://img.shields.io/badge/Swift-4.2-ffac45.svg">
</p>

## Installation
**Install via [Carthage](https://github.com/Carthage/Carthage)**  
```
github "atsushi130/CoordinatorKit"
```

## Usage
Conform to Coordinator:
```swift
struct LoginCoordinator: Coordinator {

    weak var viewController: UIViewController?

    enum Route {
        case .login(email: String, password: String)
        case .forgetPassword
    }

    func transition(to route: Route) {
        switch route {
        case let .login(email. password):
            let user = User(email: email, password: password)
            let homeViewController = HomeViewController.instantiate(with: user)
            self.viewController?.present(homeViewController, animated: true)
        case .forgetPassword:
            let forgetPasswordViewController = ForgetPasswordViewController.instantiate()
            self.viewController?.present(forgetPasswordViewController, animated: true)
        }
    }
}
```

and conform to RoutableViewController and create Configurator:
```swift
final class HomeViewController: RoutableViewController {
    
    typealias ViewControllerConfigurator = HomeConfigurator
    typealias Dependency = User
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct HomeConfigurator: Configurator {
    typealias VC = HomeViewController
    static func configure(with vc: VC, dependency: VC.Dependency) {
        let coordinator = HomeCoordinator()
        vc.viewModel = HomeViewModel(coordinator: coordinator, user: dependency)
    }
}
```

## License
CoordinatorKit is available under the MIT license. See the [LICENSE file](https://github.com/atsushi130/CoordinatorKit/blob/master/license-mit).
