//
//  ItemCell.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 1.01.2021.
//

import UIKit
import SDWebImage

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemReleaseDateLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var item: ItemData? {
        didSet {
            setData(item: item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setData(item: ItemData?) {
        itemNameLabel.text = item?.name
        itemReleaseDateLabel.text = item?.releaseDate
        itemPriceLabel.text = String(item?.price ?? 0) + " " + (item?.currency ?? "")
        itemImageView.sd_setImage(with: item?.imageUrl, completed: nil)
    }
    
    private func setupCell() {
        itemImageView.contentMode = .scaleAspectFit
    }
}
