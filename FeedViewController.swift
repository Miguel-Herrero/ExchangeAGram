//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Miguel Herrero on 6/2/15.
//  Copyright (c) 2015 Miguel Herrero. All rights reserved.
//

import UIKit
import MobileCoreServices

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snapBarButtomItemTapped(sender: UIBarButtonItem) {
        
        // Is the Camera available?
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraController = UIImagePickerController()
            
            // We'll be the delegates for the ImagePickerController
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            //Specifing a type of media we'll be collecting (images)
            let mediaTypes: [AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false //Dont allow editing photos inside Camera app
            
            // Present the instance of the CameraController on the screen
            self.presentViewController(cameraController, animated: true, completion: nil)
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
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    // MARK: UICollectionViewDelegate
    
}

// MARK: - UIImagePickerController

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: UIImagePickerControllerDelegate
    
    // MARK: UINavigationControllerDelegate
}

