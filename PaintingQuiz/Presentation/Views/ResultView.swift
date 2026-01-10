//
//  ResultView.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 16/12/25.
//

import SwiftUI

struct ResultView: View {
    var totalCorrect: Int = 7
    var totalWrong: Int = 10
    @State var totalTime: Int = 20
    var restartGame: () -> Void = {}
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            Image("QuestionImage")
                .offset(x: -40, y: -65)
            VStack {
                VStack {
                    Text("GAME")
                    Text("OVER")
                }
                .foregroundStyle(Color.white)
                .font(Font.largeTitle.bold())
                
                Spacer()
                
                VStack {
                    HStack(spacing: 13) {
                        Image(systemName: "checkmark")
                        Text("Correct: \(totalCorrect)".uppercased())
                    }
                    
                    HStack(spacing: 13) {
                        Image(systemName: "xmark")
                        Text("Incorrect: \(totalWrong)".uppercased())
                    }
                    
                    HStack(spacing: 13) {
                        Image(systemName: "alarm")
                        Text("Time: \(totalTime)")
                    }
                }
                .foregroundStyle(Color.yellowMain)
                .font(.system(size: 32))
                .padding(.bottom, 42)
                
                VStack(spacing: 17) {
                    //MARK: RESTART BUTTON
                    Button {
                        print("Restart button tapped")
                        restartGame()
                    } label: {
                        Text("Restart".uppercased())
                            .font(.system(size: 24))
                            .foregroundStyle(Color.yellowMain)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .fill(Color.yellowMain)
                            )
                    }
                    
                    //MARK: MENU BUTTON
                    Button {
                        print("Menu button tapped")
                        restartGame()
                        router.navigateToRoot()
                    } label: {
                        Text("menu".uppercased())
                            .font(.system(size: 24))
                            .foregroundStyle(Color.yellowMain)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .fill(Color.yellowMain)
                            )
                    }
                }
            }
            .padding(.horizontal, 70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.background
        )
    }
}

#Preview {
    ResultView()
}
