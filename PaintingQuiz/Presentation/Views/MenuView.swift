//
//  ContentView.swift
//  PaintingQuiz
//
//  Created by Gilang Ramadhan on 15/12/25.
//

import SwiftUI

enum ArtStyleInfo: String, CaseIterable {
    case impressionism
    case surrealism
    case cubism
    case expressionism
    case modernism
    case realism
}

struct MenuView: View {
    @EnvironmentObject var gameplayVM: GameplayViewModel
    @State var isSoundOn: Bool = true
    @State var isMusicOn: Bool = true
    @State var isVibrationOn: Bool = true
    private var data = Array(1...6)
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    private let flexibleColumn: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
        
    ]
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack(alignment: .center) {
            Image("QuestionImage")
                .offset(x: -40, y: -65)
            
            VStack {
                VStack {
                    Text("MAX")
                        .foregroundStyle(Color.white)
                        .font(Font.largeTitle.bold())
                    
                    Text("ART QUIZ")
                        .foregroundStyle(Color.white)
                }
                .padding(.bottom, 36)
                
                //MARK: SETTING COMPONNENT
                VStack(spacing: 10) {
                    Toggle(isOn: $isSoundOn) {
                        HStack(spacing: 13) {
                            Image(systemName: "speaker.wave.1.fill")
                                .foregroundStyle(Color.white)
                            
                            Text("SOUND")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Toggle(isOn: $isMusicOn) {
                        HStack(spacing: 13) {
                            Image(systemName: "music.note")
                                .foregroundStyle(Color.white)
                            
                            Text("MUSIC")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Toggle(isOn: $isVibrationOn) {
                        HStack(spacing: 13) {
                            Image(systemName: "iphone.radiowaves.left.and.right")
                                .foregroundStyle(Color.white)
                            
                            Text("VIBRATION")
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(24)
                .background(
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(style: StrokeStyle(lineWidth: 3, dash: [6]))
                        
                        Text("SETTINGS")
                            .foregroundStyle(Color.yellowSecond)
                            .padding(.horizontal, 24)
                            .background(.white)
                            .cornerRadius(5)
                            .offset(y: -10)
                    }
                        .foregroundColor(.white)
                )
                .fontWeight(.bold)
                .padding(.bottom, 78)
                
                
                //MARK: IMAGE GRID
                LazyVGrid(columns: flexibleColumn, alignment: .center, pinnedViews: .sectionHeaders) {
                    ForEach(gameplayVM.uniqueImage) { item in
                        Button {
                            guard let style = ArtStyleInfo(rawValue: item.keyword.lowercased()) else {
                                return
                            }
                            switch style {
                            case .cubism:
                                router.navigate(to: .artStyleView(artStyleName: "cubism", infoArtStyle: "Cubism is an avant-garde art movement that originated in the 20th century thanks to the famous Pablo Picasso. Therefore, it is he who is the most vivid representative of this style. Note that this direction revolutionized sculpture and painting in Europe, inspiring also similar trends in architecture, literature and music. Works of art in this style are characterized by recombined, broken objects in abstract form."))
                            case .expressionism:
                                router.navigate(to: .artStyleView(artStyleName: "Expressionims", infoArtStyle: "Expressionists usually depict the world around them only subjectively, completely distorting reality for even greater emotional effect. In this way, they make their viewer think."))
                            case .impressionism:
                                router.navigate(to: .artStyleView(artStyleName: "Impressionism", infoArtStyle: "Impressionism is a style of painting that usually focuses on working outdoors. Painting in this direction is intended to convey the master's sense of light. The key characteristics of Impressionism include: thin, relatively small, barely visible strokes; accurately conveyed changes in lighting; open composition; the presence of some movement; and an unusual vision of objects."))
                            case .modernism:
                                router.navigate(to: .artStyleView(artStyleName: "Modernism", infoArtStyle: "Modernism demonstrates the totality of different trends of culture, as well as a number of united directions of art, which originated in the XIX and XX centuries. Painters call modernism “a different art”, the purpose of which is to create unique, unlike anything else pictures, that is, they show the special vision of the artist."))
                            case .surrealism:
                                router.navigate(to: .artStyleView(artStyleName: "Surrealism", infoArtStyle: "Surrealism is the exposure of psychological truth by separating objects from their everyday meanings in order to create a strong image to empathize with the viewer."))
                            case .realism:
                                router.navigate(to: .artStyleView(artStyleName: "Realism", infoArtStyle: "Realism emerged as a reaction to academism and romanticism, first manifesting itself in the 1850s in France. Realist artists usually tried to portray various subjects through the lens of worldly rules. They were devoid of any explanation or embellishment. Realism believed only in the existence of objective reality, so it protested against the strong emotionality of Romanticism. Accuracy and truth were the main goals in the work of most representatives of this style."))
                            }
                        } label: {
                            VStack(spacing: 7) {
                                Image(item.name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 94, height: 94)
                                    .cornerRadius(12)
                                
                                Text(item.keyword).bold()
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                            }
                        }
                        
                    }
                }
            
                Spacer()
                
                SlideToStartButton {
                    router.navigate(to: .gameplayView)
                }

            }
            .padding(.horizontal, 32)
        }
       
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: [Color.yellowMain, Color.redMain]))
    }
}

struct SlideToStartButton: View {
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    let maxWidth: CGFloat = UIScreen.main.bounds.width - 80 // Sesuaikan dengan padding
    let buttonSize: CGFloat = 50
    var onSlideComplete: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.background)
                    .frame(height: 74)
                
                // Text
                HStack {
                    Spacer()
                    Text("SLIDE TO START")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .opacity(1 - Double(offset / (geometry.size.width - buttonSize - 24)))
                    Spacer()
                }
                
                // Draggable Circle
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundStyle(Color.white)
                        .frame(width: buttonSize, height: buttonSize)
                        .background(
                            Circle()
                                .fill(Color.yellowMain)
                        )
                        .offset(x: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDragging = true
                                    let translation = value.translation.width
                                    let maxOffset = geometry.size.width - buttonSize - 24
                                    
                                    // Batasi offset
                                    offset = min(max(0, translation), maxOffset)
                                }
                                .onEnded { value in
                                    let maxOffset = geometry.size.width - buttonSize - 24
                                    
                                    // Jika sudah slide lebih dari 80%, trigger action
                                    if offset > maxOffset * 0.8 {
                                        offset = maxOffset
                                        // Delay sedikit untuk animasi
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            onSlideComplete()
                                        }
                                    } else {
                                        // Reset ke posisi awal
                                        withAnimation(.spring()) {
                                            offset = 0
                                        }
                                    }
                                    isDragging = false
                                }
                        )
                }
                .padding(12)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                offset = 0
            }
        }
        .frame(height: 74)
    }
}

#Preview {
    MenuView()
        .environmentObject(GameplayViewModel())
}
