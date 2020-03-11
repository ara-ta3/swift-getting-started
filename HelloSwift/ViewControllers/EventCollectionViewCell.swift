//
//  EventCollectionViewCell.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/11.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.size.width - 2,
            height: UIScreen.main.bounds.size.width / 3.0
        )
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 5
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.addSubview(label)
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.black.cgColor

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
