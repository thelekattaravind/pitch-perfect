//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Aravind on 5/28/15.
//  Copyright (c) 2015 Aravind. All rights reserved.
//

import Foundation

class RecordedAudio : NSObject {
    var title : String!
    var filePathURL : NSURL!
    override init(){
        title = "undefined"
        filePathURL = nil
    }
}