//
//  Post.swift
//  My Hood
//
//  Created by C Sinclair on 12/3/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import Foundation

//since this is set up so you can't make a post without passing in all three parameters, we don't need optionals on the class variables.  They will be assigned in the init.
class Post: NSObject, NSCoding {
    private var _imgPath: String!
    private var _title: String!
    private var _postDescription: String!
    
    var imagePath: String{
        return _imgPath
    }
    
    var title: String{
        return _title
    }
    
    var postDescription: String{
        return _postDescription
    }
    
    init(imgPath: String, title: String, postDescription: String){
        self._imgPath = imgPath
        self._title = title
        self._postDescription = postDescription
    }
    
    //following are required inits and func so data can properly be archived and unarchived
    override init(){}
    
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        self._imgPath = aDecoder.decodeObjectForKey("imgPath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDescription = aDecoder.decodeObjectForKey("postDescription") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imgPath, forKey: "imgPath")
        aCoder.encodeObject(self._title, forKey: "title")
        aCoder.encodeObject(self._postDescription, forKey: "postDescription") 
    }
}