//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Miguel Herrero on 6/2/15.
//  Copyright (c) 2015 Miguel Herrero. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedArray: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let request = NSFetchRequest(entityName: "FeedItem")
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        // Make the request
        feedArray = context.executeFetchRequest(request, error: nil)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snapBarButtomItemTapped(sender: UIBarButtonItem) {
        
        // Is the Camera available? Else pick PhotoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraController = UIImagePickerController()
            
            // We'll be the delegates for the ImagePickerController
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            // Specifing a type of media we'll be collecting (images)
            let mediaTypes: [AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false // Don't allow editing photos inside Camera app
            
            // Present the instance of the CameraController on the screen
            self.presentViewController(cameraController, animated: true, completion: nil)

        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            var photoLibraryController = UIImagePickerController()
            
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes: [AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            
            self.presentViewController(photoLibraryController, animated: true, completion: nil)

        } else {
            
            // Let's manage errors by presenting an Alert view
            var alertController = UIAlertController(title: "Alert", message: "Your device does not support Camera or Photo Library", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UICollectionView

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FeedCell

        let thisItem = feedArray[indexPath.row] as FeedItem
        
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption

        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
}

// MARK: - UIImagePickerController

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // take the original UIImage (not cropped one…) from the Dictionary
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        // Converto to JPEG without compression
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        // Let's get the Context and get the entity from there
        let manageObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: manageObjectContext!) //Un-wrap it because we knoe that it exists
        
        // Let's create our item
        let feedItem = FeedItem(entity: entityDescription!, insertIntoManagedObjectContext: manageObjectContext)
        feedItem.image = imageData
        feedItem.caption = "test caption"
        
        // Save our feedItem
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        feedArray.append(feedItem)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView.reloadData()
    }
    
    // MARK: UINavigationControllerDelegate
}

