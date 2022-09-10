//
//  HomeView.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = MediaViewModelImplementation(service: MediaServiceImplementation())
    
    var body: some View {
        Group {
            //retrieving our states and making conditionals based on what is returned
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error): // because of associated values
                    ErrorView(error: error, handler: viewModel.getArticles)
                case .success(let articles): //because of associated values
                    NavigationView {
                        List(articles) { item in
                            ArticleView(article: item)
                                .onTapGesture{
                                    //play video
                                }
                                .navigationTitle(Text("News"))
                        }
                    }
            }
        }
        .onAppear(perform: viewModel.getArticles)
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
