//
//  MainView.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 16/12/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var router = Router()
    @StateObject var gamePlayVM = GameplayViewModel()
    var body: some View {
        NavigationStack(path: $router.path) {
            MenuView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .menuView:
                        MenuView()
                    case .gameplayView:
                        GameplayView()
                    case .resultView:
                        ResultView()
                    case .artStyleView(let artStyleName, let infoArtStyle):
                        ArtStyleInfoView(artStyleName: artStyleName, infoArtStyle: infoArtStyle)
                    }
                }
        }
        .environmentObject(gamePlayVM)
        .environmentObject(router)
    }
}
