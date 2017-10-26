//
//  CollectionViewController.swift
//  BugTest
//
//  Created by bong on 2017/10/23.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

struct MusicModel {
    let title: String
    let URL: URL
}

class CollectionViewController: UICollectionViewController {

    var modelArray = [MusicModel]()
    let urls = [
                "https://i.entertech.cn/ipic/95vfz.png",
                "https://i.entertech.cn/ipic/2j6qv.jpeg",
                "https://i.entertech.cn/ipic/283nr.jpeg",
                "https://i.entertech.cn/ipic/i1oxs.jpg",
                "https://i.entertech.cn/ipic/zgqlz.jpeg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (i, strURL) in urls.enumerated() {
            if let url = URL(string: strURL) {
                addModelItem("\(i)", url: url)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // 某个数据源更新，需要刷新
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.collectionView?.reloadData()
        }
    }
    
    func addModelItem(_ title: String , url: URL) {
        let modelItem = MusicModel(title: title, URL: url)
        modelArray.append(modelItem)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("cell is nil")
        }
        let item = modelArray[indexPath.row]
        cell.configure(item, for: indexPath)
        
        /**
         刷新前
         
         indexPath = [0, 0], cell = 0x10360acf0
         indexPath = [0, 1], cell = 0x103613080
         indexPath = [0, 2], cell = 0x1036141f0
         indexPath = [0, 3], cell = 0x103614930
         
         // 刷新后
         indexPath = [0, 3], cell = 0x10360acf0
         indexPath = [0, 2], cell = 0x103613080
         indexPath = [0, 1], cell = 0x1036141f0
         indexPath = [0, 0], cell = 0x103614930
         
         **/
        
        print(indexPath, cell)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
