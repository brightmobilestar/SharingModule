//
//  GlobData.swift
//  SharingModule
//
//  Created by User on 7/21/15.
//  Copyright (c) 2015 Steven. All rights reserved.
//

import UIKit

class GlobData: NSObject {
    
    var g_isAutherUser:Bool = true          // to dislay if current user is auther user or not
    var g_isSharingToMoment:Bool = true     // to display if sharing to moment or somebody
                                                    // true: to moment          false: to somebody
    
    static var instance:GlobData!
    static func getInstance() -> GlobData {
        if instance == nil {
            instance = GlobData.new()
        }
        return instance
    }
   
}
