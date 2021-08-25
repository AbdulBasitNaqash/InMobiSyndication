//
//  InMobiSyndication.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 25/08/21.
//

import Foundation
import InMobiSDK

class InMobiSyndication {
    static func setSyndicationPubId(id: String) {
        
    }
    
    static func setInMobiAccountId(id: String) {
        IMSdk.initWithAccountID(id)
    }
}
