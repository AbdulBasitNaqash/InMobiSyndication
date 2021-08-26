//
//  GamesCollectionViewCell.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 26/08/21.
//

import UIKit
import SDWebImage

class GamesCollectionViewCell: UICollectionViewCell {
    var nameLabel: UILabel!
    var icon : UIImageView!
    var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        icon.removeFromSuperview()
        stackView.removeFromSuperview()
        nameLabel.removeFromSuperview()
    }
    
    func configure(labelText: String, imageURL: String) {
       
        nameLabel  = UILabel()
        icon = UIImageView()
        stackView = UIStackView(frame: frame)
        
        icon.frame = CGRect(x:0, y:0, width: stackView.frame.size.width - 20, height: stackView.frame.size.height - 20)
        
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(nameLabel)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.frame = contentView.frame
        contentView.addSubview(stackView)

        nameLabel.text = labelText
        
        icon.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "game_placeholder"))
    }

}
