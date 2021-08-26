//
//  InMobiSyndicationViewController.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 25/08/21.
//

import UIKit
import InMobiSDK

public class InMobiSyndicationViewController: UIViewController {
    
    //MARK: - Variables and Constants
    var interstitialAd: IMInterstitial?
    var placementId: Int64 = 0
    var cellIdentifier: String = "GamesCollectionViewCell"
    
    public var adFinishedLoading : (()->())?
    public var adErrorLoading: (()->())?
    
    var collectionView: UICollectionView!
    var games: [GamesListModel]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        interstitialAd = IMInterstitial(placementId: placementId)
        interstitialAd?.delegate = self
        //interstitialAd?.load()
        print("*** load called new one")
        getGamesList()
    }
    
    func setupCollectionView() {
        print("*** \(#function)")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.register(GamesCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
    }
    

   public func showInterstitialAd() {
        interstitialAd?.show(from: self, with: .coverVertical)
       print("*** show Interstital called")
    }
    
    public func setPlacementId(placementId: Int64) {
        self.placementId = placementId
        print("*** placement Id Setup")
    }
   
    
    func getGamesList() {
        APIManager.shared.getGamesListData { games in
            self.games = games
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func recordGameStartEvent(publisherId: Int, gameId: Int) {
        let timeStamp = UInt64((Date().timeIntervalSince1970) * 1000)
        
        APIManager.shared.recordGameStartEvent(publisherId: publisherId, gameId: gameId, timeStamp: timeStamp)
    }
}

//IMInterstitial delegate methods
extension InMobiSyndicationViewController: IMInterstitialDelegate {
    
    public func interstitialDidReceiveAd(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
    }
    
    public func interstitialDidFinishLoading(_ interstitial: IMInterstitial!) {
        print("*** \(#function)")
        adFinishedLoading?()
    }
    
    public func interstitial(_ interstitial: IMInterstitial!, didFailToLoadWithError error: IMRequestStatus!) {
        print("*** \(#function), error: \(error.localizedDescription)")
        adErrorLoading?()
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


extension InMobiSyndicationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("*** \(#function)")
        return games?.count ?? 0
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("*** \(#function)")

        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GamesCollectionViewCell
        
        cell.configure(labelText: self.games?[indexPath.row].name ?? "", imageURL: self.games?[indexPath.row].gameIcon ?? "")
        print("*** \(#function)")

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width / 3) - 20
        return CGSize(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("*** game selected: \(games?[indexPath.row].name)")
        
        let gameController = GameWebViewController()
        gameController.gameURL = URL(string: games?[indexPath.row].gamePath ?? "")
        self.present(gameController, animated: true) {
            if let id = self.games?[indexPath.row].id {
                self.recordGameStartEvent(publisherId: 13, gameId: id)
            }
        }
    }
    
}
