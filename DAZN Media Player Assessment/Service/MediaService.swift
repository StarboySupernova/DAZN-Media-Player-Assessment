//
//  MediaService.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import Foundation
import Combine

//to promote dependency injection, we need to make this class as testable as possible
protocol MediaService {
    //we are basically using our API that we built before to dictate which endpoint we actually trigger, which in this case is MediaAPI.getMedia, which returns with a MediaResponse.(how is MediaResponse integrated here? (by decoding JSON returned from .dataTaskPublisher with a urlRequest to the resource) how do we connect APIError with MediaAPI and then with MediaResponse (MediaAPI defines the model for fetching data, which is then fetched by an object that conforms to MediaService. That MediaService object then presents that data as an AnyPublisher<MediaResponse, APIError>))
    func request(from endpoint: MediaAPI) -> AnyPublisher<MediaResponse, APIError>
}

struct MediaServiceImplementation: MediaService {
    //basically this returns a publisher that emits values from our API. MediaAPI contains the url that we'll fetch the data from when its .getMedia property is accessed.
    // .getMedia passes the url to the urlRequest properties that appends the path to the url to get the resource we need
    //here, the request function creates a publisher with the urlRequest value
    // the publisher emits the data or an error
    // if it emits data, it will be in JSON format. We'll need to decode it into the MediaResponse struct format
    // if it emits an error, we represent it as an APIError
    
    func request(from endpoint: MediaAPI) -> AnyPublisher<MediaResponse, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown}
            .flatMap{data, response -> AnyPublisher<MediaResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    //API returns dates as String. We need to convert that to Date to work with the dates properly here
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601 //the format dates are usually in
                    
                    return Just(data)
                        .decode(type: MediaResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}
