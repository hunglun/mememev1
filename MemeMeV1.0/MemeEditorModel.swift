//
//  MemeEditorModel.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/28/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText : String
    let bottomText : String
    let image : UIImage
    let memedImage : UIImage
    
    func save(){
        UIImageWriteToSavedPhotosAlbum(memedImage, nil,nil,nil)
    }
}