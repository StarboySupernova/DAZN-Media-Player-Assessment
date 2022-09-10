//
//  ResultState.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import Foundation

//these states will control what the user sees onscreen
//what we will do in the viewModel is dependent on the state that gets sent to the view
enum ResultState {
    case loading
    case success(content: [MediaElement]) //this is what we'll use to populate our list of articles
    case failed(error: Error)
}
