//
//  ArtStyleInfoView.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 20/12/25.
//

import SwiftUI

struct ArtStyleInfoView: View {
    var artStyleName: String
    var infoArtStyle: String
//    var image: String
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            Image("QuestionImage")
                .offset(x: -25)
            VStack {
//                Image(image)
//                    .resizable()
//                    .frame(maxWidth: .infinity)
//                    .scaledToFill()
                
                VStack(spacing: 55) {
                    Text(artStyleName.uppercased())
                        .bold()
                        .font(.largeTitle)
                    
                    Text(infoArtStyle)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.leading)
                }
                .foregroundStyle(Color.yellowSecond)
                .padding(.horizontal, 25)
                .padding(.bottom, 120)
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
//        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topLeading, content: {
            Button {
                router.navigateToRoot()
            } label: {
                Image(systemName: "house")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    )
                    .foregroundStyle(Color.yellowSecond)
            }
            .padding(.leading, 30)
//            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        })
    }
}

// Tidak pakai toolbar karena mau costum bentuk background buttonnya
#Preview {
    ArtStyleInfoView(
        artStyleName: "Impressionism",
        infoArtStyle: "Impressionism is a style of painting that usually focuses on working outdoors. Painting in this direction is intended to convey the master's sense of light. The key characteristics of Impressionism include: thin, relatively small, barely visible strokes; accurately conveyed changes in lighting; open composition; the presence of some movement; and an unusual vision of objects."
    )
}
