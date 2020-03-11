import SwiftUI
import SnapKit
import UIKit

final class RootViewController: UITabBarController {
    var firstView: FirstViewController!
    var secondView: SecondViewController!
    
    private lazy var container: UIView = {
        let container = UILabel()
        let text = "Hello Hello World"
        container.text = text
        container.textColor = UIColor.black
        container.textAlignment = .center
        container.sizeToFit()
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = FirstViewController()
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

        navigationItem.title = "Root"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(container)
        container.snp.makeConstraints {make in
            make.center.equalToSuperview()
        }
    }
}
