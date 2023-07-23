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
    @State private var currentRound = 0
    // new worldmap
    let worldWest = "WorldWest"
    let worldEast = "WorldEast"
    let worldMid = "WorldMid"
    
    let maps = ["WorldWest", "WorldMid", "WorldEast"]
    
    @State var isShowingStartGame = false
    @State private var isShowingFlags = false
    
    private var isRoundOne : Bool {
        return currentRound == 0 }
    
    enum GameLabel {
          case topText
          case midText
          }
    
    enum ShowTime {
        case beforeRound
        case playRound
        case afterRound
    }
    
    let roundStrings = ["guess the flag for each country !", "Round One",  "Round Two", "Round Three", "Round Four ", "Round Five", "Round Six", "Round Seven", "Round Eight", "Round Nine", "Round TEN"]
    
    @State private var buttonsOpacity = 0.0
    
    
    @State var countries = ["Estonia", "France","Nigeria", "USA", "Poland", "Ireland", "Germany", "Spain","Italy", "UK"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var topText = ""
    @State private var midText = ""
    
    let winningEmoji = ["🙌🏻", "🤟🏼", "💪🏼", "👀", "🥳", "😆", "☺️", "🔥", "⭐️", "☘️",]
    let losingEmoji = ["💔", "👿", "🫥", "😞", "🤨", "🥺", "😵", "🤌🏼", "💀", "🙈"]
    
    @State private var isShowingPlayButton = false
    
    //twirl flags upon correct answer
    @State private var animateAxisZero = 0.0
    @State private var animateAxisOne = 0.0
    @State private var animateAxisTwo = 0.0
    
    @State private var isShowingEmoji = false
    
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
            .onAppear{
                resetGradientBackDrop()
                resetGame()
           
            }
            
         //.animation(.easeIn .repeatForever(autoreverses: true))
        .opacity(groupOpacity)
        
        // layer 2
        Color.black
            .ignoresSafeArea()
            .opacity(blackCover)
            .animation(.easeIn(duration: 0.4), value: blackCover)
        
        
        VStack {
            // Layer 3
            VStack {
                
                Text(topText)
                    .foregroundColor(.primary)
                    .font(.subheadline.weight(.heavy))
               
            
                    Text(midText)
                        .foregroundColor(.blue)
    //                    .font(isShowingFlags ? .largeTitle.weight(.semibold) : .largeTitle.weight(.thin))
                        .font(.system(size: isShowingEmoji ? 60 : 30))
                        .italic()
                        .padding(isShowingEmoji ? 8 : 4)
                        .background(Color(isShowingEmoji ? .black : .clear))
                        .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.7), value: isShowingEmoji)
                        .clipShape(Ellipse())
                        .animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.4), value: isShowingEmoji)
                
                   
               
                    
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
                            .rotation3DEffect(.degrees(animateAxisZero),
                                              axis: (x: 0, y: 1, z: 0))
                        Image(countries[1])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(radius: 5)
                            .transition(.push(from: .trailing))
                            .rotation3DEffect(.degrees(animateAxisOne),
                                              axis: (x: 0, y: 1, z: 0))
                        Image(countries[2])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(radius: 5)
                            .transition(.push(from: .trailing))
                            .rotation3DEffect(.degrees(animateAxisTwo),
                                              axis: (x: 0, y: 1, z: 0))
                        
                    }
                }
                
// MARK: - BUTTONS
                
                VStack {
                        Button {
                            flagTapped(0)
                        
                            withAnimation(.easeInOut(duration: 1.8)) {
                                animateAxisZero += 1080
                            }
                        } label: {
                            Image(countries[0])
                                .renderingMode(.original)
                                .clipShape(Capsule(style: .continuous))
                            
                        }
                        .padding(4)
                        .opacity(buttonsOpacity)
                    
                    Button {
                        flagTapped(1)

                        withAnimation(.easeInOut(duration: 1.8)) {
                            animateAxisOne += 1080
                        }
                    } label: {
                        Image(countries[1])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                    }
                    .padding(4)
                    .opacity(buttonsOpacity)
                    
                    Button {
                        flagTapped(2)
                       
                        withAnimation(.easeInOut(duration: 1.8)) {
                            animateAxisTwo += 1080
                        }
                    } label: {
                        Image(countries[2])
                            .renderingMode(.original)
                            .clipShape(Capsule(style: .continuous))
                     }
                    .padding(4)
                    .opacity(buttonsOpacity)
                    
                }
            }
            
        } // end VStack
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.easeInOut(duration: 0.5), value: isShowingEmoji)
        
            
            Button("Start Game", action: {
                withAnimation {
                   continueGame()
                }
            })
            .font(.largeTitle)
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(Ellipse())
            .offset(y: isShowingStartGame ? 300 : 500)
            .animation(.spring(response: isShowingStartGame ? 1.4 : 0.6,                                dampingFraction: 0.6,
                                blendDuration: 0.8),
                                value: isShowingStartGame
                               )
            
            Button("Play Round", action: {
                withAnimation {
                   askQuestion()
                }
            })
            .font(.largeTitle)
            .foregroundColor(.primary)
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(Ellipse())
            .offset(y: isShowingPlayButton ? 300 : 500)
            .animation(.spring(response: isShowingPlayButton ? 1.4 : 0.6,                                dampingFraction: 0.6,
                                blendDuration: 0.8),
                                value: isShowingPlayButton
                               )
        
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

    func resetGame() {
       
            isShowingFlags = false
        isShowingPlayButton = false
            buttonsOpacity = 0.0
            currentRound = 0
            score = 0
            isShowingStartGame = true
        topText = "can you .."
        midText = "Guess the Flag ?"
    }
    
    func continueGame() {
        
          isShowingStartGame = false
              currentRound = 1
         checkRound(round: currentRound)
    }
    
    func checkRound(round : Int){
        // enter currentRound when called
        switch round {
        case 0 : setUpRound(round: 0)
        case 1 : setUpRound(round: 1)
        case 2...9 : setUpRound(round: round)
        case 10 : setUpRound(round: 10)
        default : resetGame()
        }
    }
    
    func setUpRound(round: Int) {
        changeTextsAnimated(when: .beforeRound, round: round, changeComment: .topText)
        changeTextsAnimated(when: .beforeRound, round: round, changeComment: .midText)
        isShowingPlayButton = true
    }
    
    func changeTextsAnimated(when: ShowTime, round : Int, changeComment : GameLabel) {
        var comment = ""
        var buildingComment = ""
        
        // which Text label needs to be changed ?
        switch changeComment {
        case .topText:
            // what time during the Show ?
            switch when {
                
            case .beforeRound : topText = "Get Ready !"
            case .playRound : topText = "what flag belongs to .."
            case .afterRound : topText = ""
            }
        case .midText:
            switch when {
                
            case .beforeRound : typeText(comment: roundStrings[round])
            case .playRound : typeText(comment: countries[correctAnswer])
            case .afterRound : typeText(comment: "hmmm")
            }
        }
        
        func typeText(comment : String) {
            let commentToBePresented = Array(comment)
            
            for i in 0..<comment.count {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(i)) {
                    withAnimation {
                        buildingComment.append(commentToBePresented[i])
                        // update on-Screen
                        midText = buildingComment
                    }
                }
            }
            
        } // end TypeText func
    } // end changeTextAnimated func

    
    func askQuestion() {
        isShowingPlayButton = false
        isShowingEmoji = false
        
        // if prev Question was answered wrong undo fade to black
        if blackCover == 1.0 {
            blackCover = 0.0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        setUpPlayRound()
    }
    
    func setUpPlayRound() {
        changeTextsAnimated(when: .playRound, round: currentRound, changeComment: .topText)
        changeTextsAnimated(when: .playRound, round: currentRound, changeComment: .midText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isShowingFlags = true
            buttonsOpacity = 0.1
        }
    }
    
    func flagTapped(_ number: Int) {
        buttonsOpacity = 0.0
        
        currentRound += 1
        topText = ""
        midText = ""
        
        if number == correctAnswer {
            
            withAnimation {
                midText = winningEmoji.randomElement() ?? "👍🏻"
                isShowingEmoji = true
            }
            // actual challenge
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            isShowingFlags = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                resetGradientBackDrop()
                scoreTitle = "Correctemundo"
                score += 1
                showingScore = true
            }
            
        } else {
            blackCover = 1.0
            withAnimation {
                midText = losingEmoji.randomElement() ?? "👎🏻"
                isShowingEmoji = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            isShowingFlags = false
           }
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            scoreTitle = "Wrong"
            lives -= 1
               showingScore = true
               
            }
        }
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
        // print("colorPickTop = \(colorPickTop)")
        // print("colorPickBottom = \(colorPickBottom)")

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
        // print("colorLineTop is \(colorLineTop.formatted())")
        // print("colorLineBottom is \(colorLineBottom.formatted())")

        startRad = startRadii.randomElement() ?? 50.0
        endRad = endRadii.randomElement() ?? 200.0
        
        UnitPointer = centreTop
        // print("UnitPointer is \(UnitPointer)")
        groupOpacity = Double.random(in: 0.4...1.0)
        // print("groupOpacity is \(groupOpacity.formatted())")
        
        refreshGradientTime = Double.random(in: 3.0...9.0)
        // print("refreshGradientTimer = \(refreshGradientTime.formatted())")
        
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
 
