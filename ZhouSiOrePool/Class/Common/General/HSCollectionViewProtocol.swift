//
//  HSCollectionViewProtocol.swift
//  GMG
//
//  Created by 永芯 on 2019/12/12.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

public protocol HSCollectionViewProtocol { }

public extension HSCollectionViewProtocol {
    
    private func configIdentifier(_ identifier: inout String) -> String {
        var index = identifier.firstIndex(of: ".")
        guard index != nil else { return identifier }
        index = identifier.index(index!, offsetBy: 1)
        identifier = String(identifier[index! ..< identifier.endIndex])
        return identifier
    }
    
    func registerCell(_ collectionView: UICollectionView, _ cellCls: AnyClass) {
        var identifier = NSStringFromClass(cellCls)
        identifier = configIdentifier(&identifier)
        collectionView.register(cellCls, forCellWithReuseIdentifier: identifier)
    }
    
    func registerNibCell(_ collectionView: UICollectionView, _ cellCls: AnyClass) {
        var identifier = NSStringFromClass(cellCls)
        identifier = configIdentifier(&identifier)
        collectionView.register(UINib.init(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func cellWithCollectionView<T: UICollectionViewCell>(_ collectionView: UICollectionView, indexPath: IndexPath) -> T {
        var identifier = NSStringFromClass(T.self)
        identifier = configIdentifier(&identifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell as! T
    }
    
    func collectionViewConfig(_ frame: CGRect ,_ delegate: UICollectionViewDelegate, _ dataSource: UICollectionViewDataSource) -> UICollectionView  {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
}
