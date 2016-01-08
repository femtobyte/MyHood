//
//  DataService.swift
//  My Hood
//
//  Created by C Sinclair on 12/4/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

//  Singleton - there is one instance of it in memory, and it's globally accessible to everyone. To
//  make this class a singleton, we set up a static constant, in this case instance.  Static makes it
//  so there is only ever one instance.  Need to use singeton's carefully, they never shut down, always
//  exist in memory, for the lifetime of the application.

//  This singleton handles saving and loading the posts and the images.  When we save an image, we get
//  a file path. We will store the path to the image, not the image itself.  Later, when we load the
//  image, we use the path so we can load the image from the file structure of the device.

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post]{
        return _loadedPosts
    }
    
    func savePosts(){
        //  turns the text of posts into data, and saves them in standard user defaults, and syncronize actually saves them to the disc 
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts(){
         if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData{
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post]{
                _loadedPosts = postsArray
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        //  turns image into data (png)
        //  gives image unique name based on time
        //  sends image name to function that accesses the document directory where images are stored
        //  image is written to the path that was accessed
        //  returns the data path so the path can be saved.
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post){
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    // It's ok to not understand this, this function gets the path to the image.  Images are saved in the user documents directory, not in standard user defaults.
    // Just know that this is the way to get the path to the image.
    func documentsPathForFileName(name: String) -> String {
        //  first line gets an array that has paths to the user's document directory
        //  second line gets the first element of that array, and casts it as an NSString because NSString has a function we need
        //  third line calls the function in NSString.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
}