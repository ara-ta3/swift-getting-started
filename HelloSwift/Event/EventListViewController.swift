import UIKit
import Alamofire
import MaterialComponents.MaterialList
import MaterialComponents.MaterialActivityIndicator
import ReSwift

class EventListViewController: UICollectionViewController, StoreSubscriber {
    fileprivate var items: [String] = []
    
    private let activityIndicator: MDCActivityIndicator = {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStore.subscribe(self)
        
        self.collectionView.backgroundColor = .white
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 8, bottom: 8, right: 8)
        collectionView.register(
            MDCSelfSizingStereoCell.self,
            forCellWithReuseIdentifier: "EventCollectionViewCell")


        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = collectionView.bounds.height
        layout.minimumLineSpacing = 0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        collectionView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {make in
            make.center.equalToSuperview()
        }
        
        fetchEvents(store: mainStore, eventGateway: eventGateway)
    }
    
    func newState(state: AppState) {
        if (state.loading) {
            activityIndicator.startAnimating()
        } else {
            self.items = state.events.map {(e: Event) -> String in e.name}
            activityIndicator.stopAnimating()
        }
        
        self.collectionView.reloadData()

    }
}

extension EventListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! MDCSelfSizingStereoCell
        let text = items[indexPath.item]
        cell.titleLabel.font = UIFont.systemFont(ofSize: 18)
        cell.titleLabel.text = text

        return cell
    }
}

extension EventListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      let screenSize = UIScreen.main.bounds.size
      return CGSize(width: screenSize.width - 2, height: screenSize.width / 3.0)
  }
}
