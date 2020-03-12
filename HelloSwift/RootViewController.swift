import SwiftUI
import SnapKit
import UIKit
import ReSwift
import MaterialComponents.MaterialAppBar

final class RootViewController: UITabBarController {
    let topView: TopViewController = {
        
        let view = TopViewController()

        view.tabBarItem = UITabBarItem(
            tabBarSystemItem: UITabBarItem.SystemItem.mostRecent,
            tag: 1
        )
        return view
    }()
        
    let eventListView: EventListViewController = {
        let view = EventListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.tabBarItem = UITabBarItem(
            tabBarSystemItem: UITabBarItem.SystemItem.search,
            tag: 2
        )
        return view
    }()

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

        self.setViewControllers(
            [
                topView,
                eventListView
            ],
            animated: true
        )

        navigationItem.title = "サポーターズ"
        self.view.backgroundColor = .white

        view.addSubview(appBarViewController.view)
        appBarViewController.didMove(toParent: self)
    }
}
