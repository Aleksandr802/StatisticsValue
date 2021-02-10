//
//  ViewController.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 10.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let statisticsManager = StatisticsManager()
    let postManager = PostManager()
    let apiLinks = ApiLinks()
    let postId = "14276"
    let postSlug = "O9b9hagz3NHG"
    let rowsCount = 4
    var ourPost = PostModel(id: 0, slug: "", likes_count: 0, comments_count: 0, reposts_count: 0, bookmarks_count: 0)  {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.takePostDetails()
                
            }
        }
    }
    var mentions = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var likers = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var comentators = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var reposters = StatModelResponse(data: Array()) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        
        postManager.performRequest (with: apiLinks.postLink, messageId: "?slug=\(postSlug)", completionHandler: {postModel in self.ourPost = postModel})
        
        super.viewDidLoad()
        
        
    }
    
    func takePostDetails() {
        
        statisticsManager.performRequest (with: apiLinks.likersLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.likers = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.commentatorsLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.comentators = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.repostersLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.reposters = statsModelArray})
        statisticsManager.performRequest(with: apiLinks.mentionsLink, messageId: "?id=\(ourPost.id)", completionHandler: {statsModelArray in self.mentions = statsModelArray})
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(likers.data.count)
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        
        else {fatalError("Unable to create explore tableview cell")}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
