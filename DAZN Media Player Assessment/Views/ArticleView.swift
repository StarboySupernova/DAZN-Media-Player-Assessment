//
//  ArticleView.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

import SwiftUI
import URLImage

//what we need to do here is to only handle the image if there is a valid URL

struct ArticleView: View {
    let article: MediaElement
        
        var body: some View {
            HStack {
                if let imgUrl = article.imageURL,
                   let url = URL(string: imgUrl) {
                    URLImage(url, failure: { error, _ in
                        PlaceholderImageView()
                    },
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .environment(\.urlImageOptions, URLImageOptions(fetchPolicy: .returnStoreElseLoad(downloadDelay: 0.25)))
                } else {
                    PlaceholderImageView()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(article.title)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                    Text(article.subtitle)
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
        }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: MediaElement.dummyData)
    }
}
