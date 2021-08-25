//
//  InMobiSyndicationViewController.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 25/08/21.
//

import UIKit
import InMobiSDK

//Protocol for communicating with Publisher app.
protocol InMobiSyndicationAdDelegate {
    func adFinishedLoading()
    func adFailedToLoad()
}

public class InMobiSyndicationViewController: UIViewController {
    
    //MARK: - Variables and Constants
    var interstitialAd: IMInterstitial?
    var placementId: Int64 = 0
    var delegate: InMobiSyndicationAdDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interstitialAd = IMInterstitial(placementId: placementId)
        interstitialAd?.load()
    }

    public func showInterstitialAd() {
        interstitialAd?.show(from: self, with: .coverVertical)
    }
}

//IMInterstitial delegate methods
extension InMobiSyndicationViewController: IMInterstitialDelegate {
    
    public func interstitialDidReceiveAd(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitialDidFinishLoading(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
        delegate?.adFinishedLoading()
    }
    
    public func interstitial(_ interstitial: IMInterstitial!, didFailToLoadWithError error: IMRequestStatus!) {
        print("*** \(#function), error: \(error.localizedDescription)")
        delegate?.adFailedToLoad()
    }
    
    public func interstitialWillPresent(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitialDidPresent(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitial(_ interstitial: IMInterstitial!, didFailToPresentWithError error: IMRequestStatus!) {
        print("*** \(#function), error: \(error.localizedDescription)")
    }
    
    public func interstitialWillDismiss(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitialDidDismiss(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitial(_ interstitial: IMInterstitial!, didInteractWithParams params: [AnyHashable : Any]!) {
        print("*** \(#function)")
    }
}
