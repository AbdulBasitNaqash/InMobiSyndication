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
        
    }

    @IBAction func showAd(_ sender: UIButton) {
        controller = InMobiSyndicationViewController()

        controller?.setPlacementId(placementId: 1443100076943726)
        controller?.adFinishedLoading = {
            self.controller?.showInterstitialAd()
        }

        controller?.adErrorLoading = {
            print("Error here")
        }
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller ?? UIViewController(), animated: false, completion: nil)
        
    }
    
    
}


