//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    
    //MARK: - Variables
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: Methods
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        postCaptionLabel.text = post.caption
        //postCommentsCountLabel.text = post.comments.count
    }
}
