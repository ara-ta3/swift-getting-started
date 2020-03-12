import SwiftUI
import SnapKit
import UIKit
import ReSwift
import MaterialComponents.MaterialAppBar

final class RootViewController: UITabBarController {
    var firstView: EventListViewController!
    var secondView: SecondViewController!
    private let appBarViewController = { () -> MDCAppBarViewController in
        let viewController = MDCAppBarViewController()
        viewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        viewController.navigationBar.backgroundColor = .black
        return viewController
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addChild(appBarViewController)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstView = EventListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        firstView.tabBarItem = UITabBarItem(
            tabBarSystemItem: UITabBarItem.SystemItem.featured,
            tag: 1
        )
        secondView = SecondViewController()
        secondView.tabBarItem = UITabBarItem(
            tabBarSystemItem: UITabBarItem.SystemItem.recents,
            tag: 2 
        )

        self.setViewControllers(
            [
                firstView,
                secondView
            ],
            animated: false
        )

        navigationItem.title = "サポーターズ"
        self.view.backgroundColor = .white

        view.addSubview(appBarViewController.view)
        appBarViewController.didMove(toParent: self)
    }
}
