//
//  InMobiSyndication.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 25/08/21.
//

import Foundation
import InMobiSDK

public class InMobiSyndication {
   public  static func setSyndicationPubId(id: String) {
        
    }
    
    public static func setInMobiAccountId(id: String) {
        IMSdk.initWithAccountID(id)
    }
}
