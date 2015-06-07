//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Justin Wong on 06/06/2015.
//  Copyright (c) 2015 Justin Wong. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init (filepath: NSURL, tits: String){
        self.title = tits
        self.filePathUrl = filepath
    }
}

