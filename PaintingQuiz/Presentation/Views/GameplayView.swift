//
//  GameplayView.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 15/12/25.
//

import Foundation
import SwiftUI


struct GameplayView: View {
    @EnvironmentObject var gamePlayVM: GameplayViewModel
    @EnvironmentObject var router: Router
    @State var countDown: Double = 30
    @State var nameImageTop: String = ""
    @State var nameImageBottom: String = ""
    @State var showAlert: Bool = false
    @State var isBackHomeButtonTapped: Bool = false
    @State var isCorrect: String = ""
    @State var isGameStarted: Bool = false
    
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    
//    var options: (top: String, bottom: String){
//        gamePlayVM.generateOptions()
//    }
    var body: some View {
        GeometryReader { geometry in
            
            
            VStack {
                VStack {
                    //MARK: Header Component
                    HStack(alignment: .top) {
                        Button {
                            showAlert = true
                            isBackHomeButtonTapped = true
                        } label: {
                            Image(systemName: "house")
                                .resizable()
                                .frame(width: 26.62, height: 22.69)
                                .foregroundStyle(Color.yellowSecond)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.background)
                                )
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 12){
                            HStack(spacing: 13) {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color.green)
                                    
                                    Text(String(gamePlayVM.correctAnswers))
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                }
                                HStack {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color.red)
                                    
                                    Text(String(gamePlayVM.wrongAnswers))
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "alarm")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                
                                Text(String(format: "%.0f", countDown))
                                    .font(.system(size: 20))
                            }
                            .foregroundStyle(Color.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.background)
                        )
                        
                        Spacer()
                        
                        Button {
                            isBackHomeButtonTapped = false
                            showAlert = true
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                                .resizable()
                                .frame(width: 26.62, height: 27.69)
                                .foregroundStyle(Color.yellowSecond)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.background)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: PAINTING COMPONENT
                    VStack {
                        Button {
                            // validasi image apakah sama dengan jawabannya
                            isCorrect = gamePlayVM.checkAnswer(keyword: nameImageTop)
                            isGameStarted = true
                        } label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .frame(width: 37, height: 20)
                                
                                VStack {
                                    Text(nameImageTop.uppercased())
                                        .font(Font.custom("K2D-Italic", size: 32))
                                        .underline()
                                    
                                    Text(nameImageTop.uppercased())
                                        .font(.system(size: 32))
                                        .underline()
                                }
                                
                                Spacer()
                            }
                            .foregroundStyle(Color.white)
                        }
                        
                        //MARK: SHOW IMAGE
                        Image(gamePlayVM.currentImage.name)
                            .resizable()
                            .scaledToFit()
                            .offset(x: offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        isDragging = true
                                        let translation = value.translation.width
                                        let maxOffset = geometry.size.width - 200
                                        
                                        offset = min(max(translation, -maxOffset), maxOffset)
                                    }
                                    .onEnded { value in
                                        let maxOffset = geometry.size.width - 200
                                        
                                        if offset >= maxOffset {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                isCorrect = gamePlayVM.checkAnswer(keyword: nameImageBottom)
                                                isGameStarted = true
                                                withAnimation(.spring()) {
                                                    offset = 0
                                                }
                                            }
                                        } else if offset <= -maxOffset{
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                isCorrect = gamePlayVM.checkAnswer(keyword: nameImageTop)
                                                isGameStarted = true
                                                withAnimation(.spring()) {
                                                    offset = 0
                                                }
                                            }
                                        } else {
                                            withAnimation(.spring()) {
                                                offset = 0
                                            }
                                        }
                                        isDragging = false
                                    }
                            )
                        
                        Button {
                            isCorrect = gamePlayVM.checkAnswer(keyword: nameImageBottom)
                            isGameStarted = true
                        } label: {
                            HStack {
                                Spacer()
                                Text(nameImageBottom.uppercased())
                                    .font(.title)
                                    .underline()
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 37, height: 20)
                            }
                            .foregroundStyle(Color.white)
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: BOTTOM COMPONNENT
                    VStack(spacing: 26) {
                        Text("swipe right or left to answer".uppercased())
                            .foregroundStyle(Color.white)
                        
                        Text("\(gamePlayVM.totalScore) / 10")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .fill(Color.white)
                                
                            )
                    }
                }
                .disabled(isGameStarted)
            }
        }
        .onAppear {
            gamePlayVM.nextImage()
            let options = gamePlayVM.generateOptions()
            nameImageTop = options.top
            nameImageBottom = options.bottom
        }
        .alert( isBackHomeButtonTapped ? "Are You Sure?" : "Are You Sure to restart?", isPresented: $showAlert, actions: {
            Button( isBackHomeButtonTapped ? "Back To Menu" : "Restart", role: .destructive) {
                if isBackHomeButtonTapped {
                    router.navigateToRoot()
                } else {
                    // restart
                    print("Restart all game progress")
                    gamePlayVM.restartGameplay()
                    gamePlayVM.nextImage()
                    countDown = 30
                }
            }
            .foregroundStyle(Color.red)
            Button("Cancel", role: .cancel) {
                
            }
        }, message: {
            Text("Dengan Kembali ke menu, semua progressmu akan terhapus")
                .foregroundStyle(Color(.label))
        })
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Gradient(colors: [Color.yellowMain, Color.redMain])
        )
        .onTapGesture {
            if isGameStarted {
                gamePlayVM.nextImage()
                let options = gamePlayVM.generateOptions()
                nameImageTop = options.top
                nameImageBottom = options.bottom
                isGameStarted = false
            }
        }
        .overlay {
            if gamePlayVM.totalScore == 10 && !isGameStarted{
                ResultView(
                    totalCorrect: gamePlayVM.correctAnswers, totalWrong: gamePlayVM.wrongAnswers, restartGame: {
                        gamePlayVM.restartGameplay()
                        isGameStarted = false
                    }
                )
            } else {
                if isGameStarted {
                    if !isCorrect.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(isCorrect.uppercased())
                            .font(.largeTitle)
                            .foregroundStyle(Color.green)
                            .frame(maxWidth: .infinity)
                            .background(Color.background)
                    } else {
                        Text(gamePlayVM.currentImage.keyword.uppercased())
                            .font(.largeTitle)
                            .foregroundStyle(Color.red)
                            .frame(maxWidth: .infinity)
                            .background(Color.background)
                    }
                }
            }
        }
    }
}


#Preview {
    GameplayView()
        .environmentObject(GameplayViewModel())
}
