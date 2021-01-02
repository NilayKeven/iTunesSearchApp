//
//  ItemDetailViewController.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 2.01.2021.
//

import UIKit
import SDWebImage

class ItemDetailViewController: UIViewController {
    
    public var viewModel: ItemDetailViewModel?
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemReleaseDateLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    private func setData() {
        guard let item = viewModel?.item else { return }
        itemImageView.sd_setImage(with: item.imageUrl, completed: nil)
        itemNameLabel.text = item.name
        itemReleaseDateLabel.text = item.releaseDate
        itemPriceLabel.text = String(item.price ?? 0) + " " + (item.currency ?? "")
        itemDescriptionLabel.text = item.description
    }
}
