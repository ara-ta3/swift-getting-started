import UIKit
import Alamofire

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let eventGateway = EventGateway(eventOrigin: "https://event.api.supporterz.jp")
        eventGateway.fetchEvents(completion: { (result: Result<[Event], AFError>) in
            switch(result) {
            case .success(let events):
                debugPrint(events)
            case .failure(let e):
                debugPrint(e)
            }
        })
        self.view.backgroundColor = UIColor.blue
    }
}
