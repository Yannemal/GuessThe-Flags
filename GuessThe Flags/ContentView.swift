//
//  ContentView.swift
//  GuessThe Flags DAY20
//   100 Days of SwiftUI @TwoStraws Paul Hudson tutorial
//  Created by yannemal on 26/06/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - DATA
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score : Int = 0
    @State private var lives : Int = 3
    
    // new worldmap
    let worldWest = "WorldWest"
    let worldEast = "WorldEast"
    let worldMid = "WorldMid"
    
    let maps = ["WorldWest", "WorldMid", "WorldEast"]
    @State private var isShowingFlags = false
    private var isRoundOne : Bool {
                               return score != 0 }
        
    @State private var buttonsOpacity = 0.0
    
    @State var countries = ["Estonia", "France", "Russia","Nigeria", "USA", "Poland", "Ireland", "Germany", "Spain","Italy", "UK"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    // animate graphics
    @State private var colorPickTop = Color.black
    @State private var colorPickBottom = Color.yellow
    private let colorPick2 = Color(red: 0.8, green: 0.14, blue: 0.23)
    private let colorPick3 = Color(red: 0.2, green: 0.80, blue: 0.33)
    private let colorPick4 = Color(red: 0.1, green: 0.43, blue: 0.5)
    private let colorPick5 = Color(red: 0.5, green: 0.4, blue: 0.76)
    private let colorPick6 = Color(red: 0.92, green: 0.8, blue: 0.1)
    private let colorPick7 = Color(red: 0.3, green: 0.47, blue: 0.2)
    private let colorPick8 = Color(red: 0.3, green: 0.78, blue: 0.4)
    private let colorPick9 = Color(red: 0.23, green: 0.2, blue: 0.5)
    
    @State private var colorLineTop = 0.1
    
    @State private var colorLineBottom = 0.2
    private let colorLine2 = 0.3
    private let colorLine3 = 0.7
    private let colorLine4 = 1.2
    private let colorLine5 = 1.0

    
    @State private var startRad = 100.0
    @State private var endRad = 400.0
    private let startRad2 = 250.0
    private let endRad2 = 760.0
    private let startRad3 = 450.0
    private let endRad3 = 900.0
    
    @State private var groupOpacity = 1.0

    @State private var changeBackDrop = 1
    
    @State private var UnitPointer : UnitPoint = .top
    let centreTop : UnitPoint = .top
    let centreBottom : UnitPoint = .bottom
    let centreLeft : UnitPoint = .leading
    let centreRight : UnitPoint = .trailing

    @State private var refreshGradientTime = 3.0
    
    @State private var blackCover = 0.0
    
    
    var body: some View {
        // MARK: - VIEW
        
        ZStack {
            //Layer 0
            Group {
                // so animation to RadialGradient doesnt effect everything in the original ZStack
                RadialGradient(stops: [.init(color: colorPickTop, location: colorLineTop),
                                       .init(color: colorPickBottom, location:  colorLineBottom)
                ], center: UnitPointer, startRadius: startRad, endRadius: endRad)
                .ignoresSafeArea()
                // animate this radialGrad View as follows if any of the above @State change
                //any of the above params can't fit all in value:  )
                .animation(.easeInOut(duration: refreshGradientTime)
                    .repeatForever(autoreverses: true), value: changeBackDrop)
                
                
            } // animate when Group appears
            .onAppear {
                resetGradientBackDrop()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    isShowingFlags = true
                    buttonsOpacity = 0.1
                    score = 0
                }
                
            } //.animation(.easeIn .repeatForever(autoreverses: true))
            .opacity(groupOpacity)
            
            // layer 2
            Color.black
                .ignoresSafeArea()
                .opacity(blackCover)
                .animation(.easeIn(duration: 0.8), value: blackCover)
            
            
            VStack{
                // Layer 3
                VStack {
                    
                    Text(isShowingFlags ? "Tap the flag of" : "Get Ready to ..")
                        .foregroundColor(.primary)
                        .font(.subheadline.weight(.heavy))
                    Text(isShowingFlags ? countries[correctAnswer] : "guess that flag !")
                        .foregroundColor(.blue)
                        .font(isShowingFlags ? .largeTitle.weight(.semibold) : .largeTitle.weight(.thin))
                        .italic()
                }
                ZStack {
                VStack {
                    Image(maps[0])
                        .renderingMode(.original)
                        .clipShape(Capsule(style: .continuous))
                    
                    Image(maps[1])
                        .renderingMode(.original)
                        .clipShape(Capsule(style: .continuous))
                    
                    Image(maps[2])
                        .renderingMode(.original)
                        .clipShape(Capsule(style: .continuous))
                }
                
                VStack {
                    if isShowingFlags {
                        Image(countries[0])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(radius: 5)
                            .transition(.push(from: .trailing))
                        Image(countries[1])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(radius: 5)
                            .transition(.push(from: .trailing))
                        Image(countries[2])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(radius: 5)
                            .transition(.push(from: .trailing))
                    }
                }
                
                VStack {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                isShowingFlags = false
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule(style: .continuous))
                            
                        }
                        .padding(4)
                        .opacity(buttonsOpacity)
                    }
                }
            }
        
            } // end VStack
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    
            
            
        } // end ZStack 1
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion  )
        } message: {
            Text("Your winning scorestreak is \(score)")
        }
        
    
        
    } //end body View

    
    //* ***************************************************************************** */
    //* MARK: - METHODS
    //* ***************************************************************************** */

    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            isShowingFlags = false
            buttonsOpacity = 0.0
            scoreTitle = "Correctemundo"
            score += 1
        } else {
            isShowingFlags = false
            buttonsOpacity = 0.0
            scoreTitle = "Wrong"
            score = 0
            blackCover = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                resetGradientBackDrop()
                
            }
            
        }
        showingScore = true
    }
    
    func askQuestion() {
        // if prev Question was answered wrong undo fade to black
        if blackCover == 1.0 {
            blackCover = 0.0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGradientBackDrop() {
        // data needed
        let colorsPickedforTop = [colorPick2, colorPick3, colorPick4, colorPick5, Color.gray, Color.orange, Color.brown]
        let colorsPickedforBottom = [colorPick6, colorPick7, colorPick8, colorPick9, Color.white, Color.red, Color.blue]
        let linesPicked = [colorLine2, colorLine3, colorLine4, colorLine5, 0.2, 0.78, 0.9, 1.3, 1.5, 1.6, 1.9, 2.3, 2.6]
        let startRadii = [startRad2, startRad3]
        let endRadii = [endRad2, endRad3]
       // let centreRadial = [centreTop, centreBottom, centreLeft, centreRight]
        
        
        // set new values for RadialGradient :
        let colorPickTopTemp = colorsPickedforTop.randomElement() ?? Color.yellow // random from an Array is an Optional -> set default
        let colorPickBottomTemp = colorsPickedforBottom.randomElement() ?? Color.black
        
            colorPickTop = colorPickTopTemp
            colorPickBottom = colorPickBottomTemp
 //some colours dont go well together
        print("colorPickTop = \(colorPickTop)")
        print("colorPickBottom = \(colorPickBottom)")

        var colorLineTopTemp = linesPicked.randomElement() ?? 0.1
        let colorLineBottomTemp = linesPicked.randomElement() ?? 1.0
        
        if colorLineTopTemp >= 1 {
//            var difference = colorLineTop - colorLineBottom
            colorLineTopTemp = 1
            let difference = Double.random(in: 0.2...0.8)
            colorLineTopTemp -= difference
        }
 
        colorLineTop =  colorLineTopTemp
        colorLineBottom =  colorLineBottomTemp
        print("colorLineTop is \(colorLineTop.formatted())")
        print("colorLineBottom is \(colorLineBottom.formatted())")

        startRad = startRadii.randomElement() ?? 50.0
        endRad = endRadii.randomElement() ?? 200.0
        
        UnitPointer = centreTop
        print("UnitPointer is \(UnitPointer)")
        groupOpacity = Double.random(in: 0.4...1.0)
        print("groupOpacity is \(groupOpacity.formatted())")
        
        refreshGradientTime = Double.random(in: 3.0...9.0)
        print("refreshGradientTimer = \(refreshGradientTime.formatted())")
        
        changeBackDrop += 1
    }
    
    func changeColorBackDrop() {
        // data needed
        let colorsPickedforTop = [colorPick2, colorPick3, colorPick4, colorPick5, Color.gray, Color.orange, Color.brown]
        let colorsPickedforBottom = [colorPick6, colorPick7, colorPick8, colorPick9, Color.white, Color.red, Color.blue]
    
        // set new colors for RadialGradient :
        let colorPickTopTemp = colorsPickedforBottom.randomElement() ?? Color.yellow // random from an Array is an Optional -> set default
        let colorPickBottomTemp = colorsPickedforTop.randomElement() ?? Color.black
        
            colorPickTop = colorPickTopTemp
            colorPickBottom = colorPickBottomTemp
        
        changeBackDrop += 1
    }
    
} // end ContentView


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
   
    
    // TODO: this  🤪
    
    
}
 
