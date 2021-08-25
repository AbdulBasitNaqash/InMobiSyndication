//
//  ViewController.swift
//  Publisher
//
//  Created by Aryan Gupta on 25/08/21.
//

import UIKit
import InMobiSyndication

class ViewController: UIViewController {

    var controller: InMobiSyndicationViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        controller = InMobiSyndicationViewController();
        controller?.setPlacementId(placementId: 2000000000001351)
        controller?.adFinishedLoading = {
                self.controller?.showInterstitialAd()
        }

        controller?.adErrorLoading = {
            print("Error here")
        }
        
    }

    @IBAction func showAd(_ sender: UIButton) {
        
        controller?.view.backgroundColor = .orange
       
        self.present(controller ?? UIViewController(), animated: false, completion: nil)
        
    }
    
    
}


