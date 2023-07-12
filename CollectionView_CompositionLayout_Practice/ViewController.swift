//
//  ViewController.swift
//  CollectionView_CompositionLayout_Practice
//
//  Created by 황홍필 on 2023/07/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    private let images: [UIImage] = Array(1...10).map{ UIImage(named: String($0))! }
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionalLayout())
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupLayout()
        setupDelegate()
        registerCollectionView()
    }
    
    func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(0)
            make.top.equalTo(view.snp.top).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
    }
    
    func setupDelegate() {
        collectionView.dataSource = self
    }
    
    func registerCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }

    
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // Item: 각 Item의 크기를 정하는 영역
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        
        let verticalGroupItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        verticalGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        // Group이긴 하지만, Item 영역으로 취급될 특수한 Group이기 때문에 Item으로 취급하여 가로와 세로 길이를 정해줘야 한다.
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), repeatingSubitem: verticalGroupItem, count: 2)
        
        
        // Group: 각 Group의 크기를 정하는 영역
        // 현재 여기서는 하나의 Group이 가로 화면을 다 채우고, 세로 화면을 화면의 30%만 채우도록 하였다.
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), repeatingSubitem: item, count: 2)
        
        // 이 group은 이제 totalGroup 내의 Item이 되었으므로 Item으로 취급하여 .fractional을 조절해줘야 한다.
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [item, verticalGroup])
        
        
        let totalItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        
        
        let totalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [totalItem, group])
        
        
        // Section
        let section = NSCollectionLayoutSection(group: totalGroup)
        
        // return
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = images[indexPath.item]
        
        return cell
    }
    
    
}

