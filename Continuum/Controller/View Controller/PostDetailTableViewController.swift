//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - properties
    var posts: Post? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = posts?.photo else { return }
        guard let caption = posts?.caption else { return }

        let activityController = UIActivityViewController(activityItems: [image, caption], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func addCommentButtonTapped(_ sender: UIButton) {
        guard let post = posts else { return }
        presentAddCommentAlert(post: post)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - Methods
    func updateViews() {
        guard let post = posts else { return }
        self.photoImageView.image = post.photo
        self.tableView.reloadData()
    }
    
    func presentAddCommentAlert(post: Post?) {
        let alertController = UIAlertController(title: "Add Comment", message: "add a new comment", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            
            textField.placeholder = "type your comment here"
            textField.autocorrectionType = .yes
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            guard let post = post else { return }
            PostController.shared.addComment(text: text, post: post) { (_) in
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let post = posts else { return 1 }
        return post.comments.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        guard let comments = posts?.comments[indexPath.row] else { return UITableViewCell()}
        cell.textLabel?.text = comments.text
        cell.detailTextLabel?.text = comments.timestamp.dateToString()

        return cell
    }
}
