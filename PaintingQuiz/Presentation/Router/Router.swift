//
//  Router.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 16/12/25.
//

import Foundation
import SwiftUI
import Combine

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func popToView(count: Int) {
        path.removeLast(count)
    }
    
}


enum Route: Hashable {
    case menuView
    case gameplayView
    case resultView
    case artStyleView(artStyleName: String, infoArtStyle: String)
}

