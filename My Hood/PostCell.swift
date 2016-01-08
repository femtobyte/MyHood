//
//  PostCell.swift
//  My Hood
//
//  Created by C Sinclair on 12/3/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//
//  If you are not writing custom classes on your views frequently, you probably aren't doing it the best way.

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImg.layer.cornerRadius = 15.0
        postImg.clipsToBounds = true
    }
    
    //loads the items from created posts
    func configureCell(post: Post){
        titleLbl.text = post.title
        descLbl.text = post.postDescription
        postImg.image = DataService.instance.imageForPath(post.imagePath)
    }

}
