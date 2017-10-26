//
//  CollectionViewCell.swift
//  BugTest
//
//  Created by bong on 2017/10/23.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private let downloadQueue = DispatchQueue(label: "ImageQueue")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ model: MusicModel, for indexPath: IndexPath) {
        if indexPath.row == 0 {
            imageView.image = UIImage.init(named: "local")
            titleLabel.text = "本地图片"
        } else {
            titleLabel.text = model.title
            
            downloadQueue.async {
                let imageData = NSData(contentsOf: model.URL)
                guard let imgData = imageData else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imgData as Data)
                }
            }
        }
    }
}
