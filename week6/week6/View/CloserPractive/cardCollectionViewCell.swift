//
//  cardCollectionViewCell.swift
//  week6
//
//  Created by useok on 2022/08/09.
//

import UIKit

class cardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: cardView!
    
    //변경되지않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        cardView.cardLabel.text = "A"
        
        
    }
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageVIew.backgroundColor = .lightGray
        cardView.posterImageVIew.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
    
}
