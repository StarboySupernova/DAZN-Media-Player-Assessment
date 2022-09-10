//
//  MediaViewModel.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import Foundation
import Combine

//same as before in MediaEndPoint, we will use a protocol to keep our classes less coupled
//if we wanted to test, we can now create a mock of this viewmodel with ease
protocol MediaViewModel {
    func getArticles()
}

class MediaViewModelImplementation: ObservableObject, MediaViewModel {
    //dependency injection. by using MediaService protocl instead of MediaServiceImplementation, we can inject any object into our class here as long as it conforms to MediaService, making the concrete MediaViewModelImplementation class and MediaServiceImplementation class loosely coupled by adding a layer of abstraction
    
    private let service: MediaService
    //array that will hold out articles
    private(set) var articles = [MediaElement]()
    private var cancellables = Set<AnyCancellable>() //to store subscriptions (here, requests)
    
    //creating property based on result state that we can push to the front end
    //we are going to be listenimg to state changes
    @Published private(set) var state: ResultState = .loading
    
    init(service: MediaService) {
        self.service = service
    }
    
    func getArticles() {
        //calling our injected service to trigger an API call
        
        self.state = .loading //ensuring our state is .loading every time getArticles is called
        
        let cancellable = service
            .request(from: .getMedia)
            .sink { res in
                switch res {
                    case .finished:
                        self.state = .success(content: self.articles)
                    case .failure(let error):
                        self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response
            }
            
        
        self.cancellables.insert(cancellable)
    }
}

