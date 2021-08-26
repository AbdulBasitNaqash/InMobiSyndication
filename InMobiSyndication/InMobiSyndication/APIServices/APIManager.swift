//
//  APIManager.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 26/08/21.
//

import Foundation

class APIManager {
    static let shared = APIManager()

    //MARK: - Get Games list data...
    func getGamesListData(onComplete: @escaping ([GamesListModel]?)->Void) {
        JSONFetcher.shared.fetchJSONData(url: GAMES_LIST_URL, method: .GET, bodyData: nil, headerValues: nil) {(data, error) in
             DispatchQueue.global(qos: .background).async {
                if let json = data {
                    do {
                        let decoded = try JSONDecoder().decode([GamesListModel].self, from: json)
                        onComplete(decoded)
                    } catch {
                        print("\(#function) error: \(error)")
                    }
                }
                else {
                    onComplete(nil)
                }
            }
        }
    }
    
    func recordGameStartEvent(publisherId: Int, gameId: Int, timeStamp: UInt64) {
        let url = EVENT_START_URL.appending("?publisher_id=\(publisherId)&game_id=\(gameId)&event_at=\(timeStamp)")
        JSONFetcher.shared.fetchJSONData(url: url, method: .GET, bodyData: nil, headerValues: nil) {(data, error) in
             
        }
    }
}
