//
//  GameplayViewModel.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 17/12/25.
//

import Foundation
import Combine

struct imageModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var keyword: String
}

class GameplayViewModel: ObservableObject {
    @Published var images: [imageModel] = [
        imageModel(name: "Cubism 1", keyword: "Cubism"),
        imageModel(name: "Cubism 2", keyword: "Cubism"),
        imageModel(name: "Cubism 3", keyword: "Cubism"),
        imageModel(name: "Impressionism 1", keyword: "Impressionism"),
        imageModel(name: "Impressionism 2", keyword: "Impressionism"),
        imageModel(name: "Impressionism 3", keyword: "Impressionism"),
        imageModel(name: "Modernism 1", keyword: "Modernism"),
        imageModel(name: "Modernism 2", keyword: "Modernism"),
        imageModel(name: "Modernism 3", keyword: "Modernism"),
        imageModel(name: "Surrealism 1", keyword: "Surrealism"),
        imageModel(name: "Surrealism 2", keyword: "Surrealism"),
        imageModel(name: "Surrealism 3", keyword: "Surrealism"),
        imageModel(name: "Expressionism 1", keyword: "Expressionism"),
        imageModel(name: "Realism 1", keyword: "Realism"),
    ]
    
    var uniqueImage: [imageModel] {
        var seen = Set<String>()
        return images.filter { image in
            if seen.contains(image.keyword) { return false }
            seen.insert(image.keyword)
            return true
        }
    }
    
    var allPaintingStyle: [String] = ["Cubism", "Impressionism", "Modernism", "Surrealism", "Expressionism", "Realism"]
    
    @Published var totalScore: Int = 0
    @Published var wrongAnswers: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var currentImage: imageModel = imageModel(name: "Cubism 1", keyword: "Cubism")
    
    func checkAnswer(keyword: String) -> String {
        totalScore += 1
        if keyword.lowercased() == currentImage.keyword.lowercased() {
            correctAnswers += 1
            return keyword
        } else {
            wrongAnswers += 1
            return ""
        }
    }
    
    func generateOptions() -> (top: String, bottom: String) {
        let wrongOptions = allPaintingStyle.filter { $0.lowercased() != currentImage.keyword.lowercased()}
        
        let wrongAnswer = wrongOptions.randomElement() ?? ""
        
        let isCorrectOnTop = Bool.random()
        
        if isCorrectOnTop {
            print("Correct on top: \(currentImage.keyword.lowercased())")
            return (top: currentImage.keyword.lowercased(), bottom: wrongAnswer)
        } else {
            print("Correct on bottom: \(currentImage.keyword.lowercased())")
            return (top: wrongAnswer, bottom: currentImage.keyword.lowercased())
        }
    }
    
    func nextImage() {
        currentImage = images.randomElement()
        ?? imageModel(name: "Cubism 1", keyword: "Cubism")
    }
    
    func restartGameplay() {
        totalScore = 0
        wrongAnswers = 0
        correctAnswers = 0
    }
}
