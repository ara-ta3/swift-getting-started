import UIKit
import Alamofire
import MaterialComponents.MaterialList
import MaterialComponents.MaterialActivityIndicator
import ReSwift

class EventListViewController: UICollectionViewController, StoreSubscriber {
    fileprivate var items: [String] = []
    
    fileprivate let refreshCtl = UIRefreshControl()
    
    private let activityIndicator: MDCActivityIndicator = {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        return activityIndicator
    }()
    
    private var sender: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStore.subscribe(self)
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = collectionView.bounds.height
        
        self.collectionView.refreshControl = refreshCtl
        refreshCtl.addTarget(
            self,
            action: #selector(refresh(sender:)),
            for: .valueChanged
        )
        self.collectionView.backgroundColor = .white
        
        self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 8, bottom: 8, right: 8)
        self.collectionView.register(
            MDCSelfSizingStereoCell.self,
            forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchEvents(store: mainStore, eventGateway: eventGateway)
    }
    
    func newState(state: AppState) {
        if (state.loading) {
            self.items = []
            activityIndicator.startAnimating()
        } else {
            self.items = state.events.map {(e: Event) -> String in e.name}
            activityIndicator.stopAnimating()
            self.sender?.endRefreshing()
        }
        
        self.collectionView.reloadData()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        self.sender = sender
        fetchEvents(store: mainStore, eventGateway: eventGateway)
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
