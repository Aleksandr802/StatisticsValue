//
//  PostViewController.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 11.02.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var likersCollectionView: UICollectionView!
    @IBOutlet weak var comentatorsCollectionView: UICollectionView!
    @IBOutlet weak var repostersCollectionView: UICollectionView!
    @IBOutlet weak var mentionsCollectionView: UICollectionView!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var comentCountLabel: UILabel!
    @IBOutlet weak var repostCountLabel: UILabel!
    @IBOutlet weak var mentionCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    
    let statisticsManager = StatisticsManager()
    let postManager = PostManager()
    let apiLinks = ApiLinks()
    let postSlug = "O9b9hagz3NHG"
    let rowsCount = 4
    
    var ourPost: PostModel!  {
        didSet {
            DispatchQueue.main.async {
                self.takePostDetails()
                self.viewCountLabel.text = (" ⚪ Views: \(self.ourPost.views_count)")
            }
        }
    }
    
    var likers = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.likersCollectionView.reloadData()
                self.likesCountLabel.text = (" 🤍 Likes: \((self.likers.data.count))")
            }
        }
    }
    
    var comentators = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.comentatorsCollectionView.reloadData()
                self.comentCountLabel.text = (" 💬 Comments: \((self.comentators.data.count))")
            }
        }
    }
    
    var reposters = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.repostersCollectionView.reloadData()
                self.repostCountLabel.text = (" 📃 Reposts: \((self.reposters.data.count))")
            }
        }
    }
    
    var mentions = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.mentionCountLabel.text = (" 📎 Mentions: \((self.mentions.data.count) )")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postManager.performRequest (with: apiLinks.postLink, messageId: "?slug=\(postSlug)", completionHandler: {postModel in self.ourPost = postModel})
        
        likersCollectionView.delegate = self
        likersCollectionView.dataSource = self
        comentatorsCollectionView.delegate = self
        comentatorsCollectionView.dataSource = self
        repostersCollectionView.delegate = self
        repostersCollectionView.dataSource = self
        
        viewCountLabel.layer.cornerRadius = 10
        
        likersCollectionView.clipsToBounds = true
        likersCollectionView.layer.cornerRadius = likersCollectionView.frame.size.height / 10
        likersCollectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        likesCountLabel.clipsToBounds = true
        likesCountLabel.layer.cornerRadius = 10
        likesCountLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        comentatorsCollectionView.clipsToBounds = true
        comentatorsCollectionView.layer.cornerRadius = comentatorsCollectionView.frame.size.height / 10
        comentatorsCollectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        comentCountLabel.clipsToBounds = true
        comentCountLabel.layer.cornerRadius = 10
        comentCountLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        repostersCollectionView.clipsToBounds = true
        repostersCollectionView.layer.cornerRadius = repostersCollectionView.frame.size.height / 10
        repostersCollectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        repostCountLabel.clipsToBounds = true
        repostCountLabel.layer.cornerRadius = 10
        repostCountLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        mentionCountLabel.clipsToBounds = true
        mentionCountLabel.layer.cornerRadius = 10
        
    }
    
    func takePostDetails() {
        
        statisticsManager.performRequest (with: apiLinks.likersLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.likers = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.commentatorsLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.comentators = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.repostersLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.reposters = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.mentionsLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.mentions = statsModelArray})
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.likersCollectionView: return likers.data.count
        case self.comentatorsCollectionView: return  comentators.data.count
        case self.repostersCollectionView: return reposters.data.count
        case self.mentionsCollectionView: return mentions.data.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.likersCollectionView {
            
            guard let cellLikers = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCollectionViewCell
            else {fatalError("Unable to create collectionView cell")}
            
            cellLikers.likersNickname.text = likers.data[indexPath.row].nickname
            cellLikers.likersImage.load(urlString: likers.data[indexPath.row].avatar_image.url)
            
            return cellLikers
            
        } else if collectionView == comentatorsCollectionView {
            
            guard let cellComent = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCollectionViewCell
            else {fatalError("Unable to create collectionView cell")}
            
            cellComent.comentNickname.text = comentators.data[indexPath.row].nickname
            cellComent.comentImage.load(urlString: comentators.data[indexPath.row].avatar_image.url)
            
            return cellComent
            
        } else {
            
            guard let cellRepost = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCollectionViewCell
            else {fatalError("Unable to create collectionView cell")}
            
            cellRepost.reposterNikname.text = reposters.data[indexPath.row].nickname
            cellRepost.reposterImage.load(urlString: reposters.data[indexPath.row].avatar_image.url)
            
            return cellRepost
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height :70)
    }
}

