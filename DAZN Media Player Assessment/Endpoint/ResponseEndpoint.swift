//
//  ResponseEndpoint.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import Foundation

//protocol used here to promote reusability, e.g. when using another API like to get Reviews, when can use the same pattern here
protocol APIBuilder {
    var urlRequest: URLRequest {get}
    var baseURL: URL {get}
    var path: String {get} //path to retrieve the resource
}

enum MediaAPI {
    case getMedia //if we have multiple endpoints for our API, we add them here
    case getSchedule
}

extension MediaAPI: APIBuilder {
    //we can now define a urlRequest, baseURL and a path for each of our cases in NewsAPI
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseURL.appendingPathComponent(self.path))
    }
    
    var baseURL: URL {
        switch self {
            case .getMedia, .getSchedule:
                //https://us-central1-dazn-sandbox.cloudfunctions.net/getEvents
                //https://us-central1-dazn-sandbox.cloudfunctions.net/getSchedule
                return URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net")!
        }
    }
    
    var path: String {
        get {
            switch self {
                case .getMedia:
                   return "/getEvents" //path is the resource we want to access
                case .getSchedule:
                    return "/getSchedule"
            }
        }
    }
    
    
}
