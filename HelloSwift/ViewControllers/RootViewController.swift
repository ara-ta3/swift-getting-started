import SwiftUI

final class RootViewController: UIViewController {
    private lazy var container: UIView = {
        let view = UIView()
        let container = UILabel()
        let text = "Hello Hello World"
        container.text = text
        container.textColor = UIColor.black
        container.textAlignment = .center
        container.sizeToFit()
        view.addSubview(container)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Root"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(container)
        container.snp
    }
}
