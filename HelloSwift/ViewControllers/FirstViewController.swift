import UIKit
import Alamofire
import MaterialComponents.MaterialList

class FirstViewController: UICollectionViewController {
    fileprivate var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let eventGateway = EventGateway(eventOrigin: "https://event.api.supporterz.jp")
        eventGateway.fetchEvents(completion: { (result: Result<[Event], AFError>) in
            switch(result) {
            case .success(let events):
                self.items = events.map {(e: Event) -> String in e.name}
                self.collectionView.reloadData()
            case .failure(let e):
                debugPrint(e)
            }
        })
        self.collectionView.backgroundColor = .white
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.register(
            MDCSelfSizingStereoCell.self,
            forCellWithReuseIdentifier: "EventCollectionViewCell")


        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = collectionView.bounds.height
        layout.minimumLineSpacing = 0
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension FirstViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! MDCSelfSizingStereoCell
        let text = items[indexPath.item]
        cell.titleLabel.text = text
        return cell
    }
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      let screenSize = UIScreen.main.bounds.size
      return CGSize(width: screenSize.width - 2, height: screenSize.width / 3.0)
  }
}
