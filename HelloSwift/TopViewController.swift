import UIKit

class TopViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let introductionImage = UIImage(named: "introduction")
        imageView.image = introductionImage
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            let ratio: CGFloat = {
                let size = imageView.image!.size
                return size.height / size.width
            }()
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(ratio)
        }
        
        self.view.backgroundColor = UIColor.white
        
        
    }
}

