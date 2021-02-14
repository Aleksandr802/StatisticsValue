//
//  PostCollectionViewCell.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 12.02.2021.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var likersImage: UIImageView!
    @IBOutlet weak var likersNickname: UILabel!
    @IBOutlet weak var comentImage: UIImageView!
    @IBOutlet weak var comentNickname: UILabel!
    @IBOutlet weak var reposterImage: UIImageView!
    @IBOutlet weak var reposterNikname: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        self?.image = image
                    }
                }
            }
        }
    }
}

