//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Miguel Herrero on 7/2/15.
//  Copyright (c) 2015 Miguel Herrero. All rights reserved.
//

import Foundation
import CoreData

// Add Objective-C compatibility
@objc (FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData
    @NSManaged var thumbNail: NSData

}
