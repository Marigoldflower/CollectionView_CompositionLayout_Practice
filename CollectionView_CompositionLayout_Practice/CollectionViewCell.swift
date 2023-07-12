//
//  CollectionViewCell.swift
//  CollectionView_CompositionLayout_Practice
//
//  Created by 황홍필 on 2023/07/12.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        setupLayout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
    }
    
}
