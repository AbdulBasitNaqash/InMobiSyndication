//
//  APIServices.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 26/08/21.
//

import Foundation

public enum URLMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

public enum ErrorType: String {
    case url = "url"
    case timeOut = "timeOut"
    case unknown = "unknown"
    case cancelled = "cancelled"
    case generic = "generic"
    case noConnection = "noConnection"
    case unauthorized = "unauthorized"
}

public struct ErrorData {
    public var errorType: ErrorType = .unknown
    public var message: String = "Wow ... you better run away, something terrible happened 😱"

    public init(_ errorType: ErrorType, _ message: String) {
        self.errorType = errorType
        self.message = message
    }
}

//Class for fetching the JSON data from the API...
class JSONFetcher{

    static let shared = JSONFetcher()
    
    //Function for fetching the JSON data from the API...
    func fetchJSONData(url: String, method: URLMethod?, bodyData: Data? = nil,
                       headerValues: [[String]]? = nil, timeOut: TimeInterval = 1, onComplete: @escaping (Data?, ErrorData?) -> Void){

        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                let urlError = error as NSError
                if urlError.code == NSURLErrorTimedOut {
                    onComplete(nil, ErrorData(.timeOut, "Operation timmed out."))
                } else if urlError.code == NSURLErrorNotConnectedToInternet {
                    onComplete(nil, ErrorData(.noConnection, "Could not stablish connection to the Internet"))
                } else if urlError.code == URLError.cancelled.rawValue {
                    onComplete(nil, ErrorData(.cancelled, "this operation has been cancelled."))
                } else {
                    onComplete(nil, ErrorData(.unknown, "Unknown falure."))
                }
            }
            
            guard let data = data else
            {
                onComplete(nil, ErrorData(.unknown,"data not available"))
                return
            }
            onComplete(data, nil)
            
            }.resume()
        
    }
}
