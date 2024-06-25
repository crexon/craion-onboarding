//
//  ContentView.swift
//  crAion Onboarding
//
//  Created by Juanjo Valiño on 25/6/24.
//

// If you like this, I did an iOS template to launch apps fast: https://WrapFa.st 🌯⚡️

import SwiftUI

enum OnboardingStep {
    case start
    case cardsAppear
    case cardsDown
    case cardsAnalysis
    case gallery
    case kidName
    case kidAge
    case readyToGo
}

struct OnboardingView: View {
    @FocusState private var isTextFieldFocused: Bool
    @State var step: OnboardingStep = .start
    @State var arrowOffset: CGFloat = -3
    @State var cardRotation: CGFloat = 15
    @State var logoOpacity: CGFloat = 0
    @State var buttonOpacity: CGFloat = 0
    @State var cardsDownOpacity: CGFloat = 0
    @State var galleryOpacity: CGFloat = 0
    @State var navigateToRequestReview = false
    @State var kid: Kid = Kid(id: UUID().uuidString, name: "", birthdate: Date().subtractingYears(5))
    
    var cardsOpacity: CGFloat {
        switch step {
        case .start:
            0
        default:
            1
        }
    }
    
    var demoCardYOffset: CGFloat {
        if step == .cardsAnalysis {
            if UIScreen.isSE {
                UIScreen.height / 1.9
            } else {
                UIScreen.height / 1.7
            }
            
        } else {
            0
        }
    }
    
    var demoCardXOffset: CGFloat {
        if step == .cardsAnalysis {
            cardsXOffset
        } else {
            0
        }
    }
    
    var demoCardRotation: CGFloat {
        if step == .cardsAnalysis {
            cardRotation
        } else {
            360
        }
    }
    
    var readyToGoRotation: CGFloat {
        if step == .readyToGo {
            30
        } else {
            0
        }
    }
    
    var cardsYOffset: CGFloat {
        switch step {
        case .start:
            100
        case .cardsAppear:
            15
        case .cardsDown:
            UIScreen.height / 1.5
        case .cardsAnalysis:
            UIScreen.height / 1.5
        case .gallery:
            200
        case .kidName:
            0
        case .kidAge:
            0
        case .readyToGo:
            0
        }
    }
    
    var cardsDownYOffset: CGFloat {
        switch step {
        case .start:
            0
        case .cardsAppear:
            0
        case .cardsDown:
            UIScreen.height / 3
        case .cardsAnalysis:
            UIScreen.height / 3
        case .gallery:
            50
        case .kidName:
            0
        case .kidAge:
            0
        case .readyToGo:
            0
        }
    }
    
    var cardsGalleryOffset: CGFloat {
        if step == .gallery {
            cardsYOffset - 50
        } else {
            0
        }
    }
    
    var cardsKidDataOffset: CGFloat {
        if step == .kidAge || step == .kidName {
            150
        } else {
            0
        }
    }
    
    var cardsXOffset: CGFloat {
        switch step {
        case .start:
            500
        default:
            110
        }
    }
    
    var cardsRotation: CGFloat {
        switch step {
        case .start:
            15
        case .cardsAppear:
            -15
        case .cardsDown:
            15
        case .cardsAnalysis:
            15
        case .gallery:
            -15
        case .kidName:
            -15
        case .kidAge:
            15
        case .readyToGo:
            345
        }
    }
    
    var body: some View {
        ZStack {
            
            if step == .readyToGo {
                VStack {
                    Text("Ready to dive into")
                        .font(.system(.title, design: .rounded, weight: .medium))
                    Text("\(kid.name)'s World!")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                }
                .multilineTextAlignment(.center)
            }
            
            if step == .cardsAnalysis {
                VStack() {
                    Spacer()
                    ScrollView {
                        Text(exampleAnalysis)
                    }
                    .frame(maxHeight: UIScreen.height / 5)
                    .padding()
                    .background(.white.opacity(0.5))
                    .cornerRadius(16)
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .padding(.vertical, UIScreen.height / 8)
            }
            
            if step == .cardsDown {
                VStack(spacing: 50) {
                    Text("Children's World Through Their Art...")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Text("Unveil the hidden meanings in every drawing with the power of the latest Artificial Intelligence")
                            .font(.system(.title3, design: .rounded, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                        Image("openai-black")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 160)
                            .padding(.top, 32)
                    }
                    .opacity(cardsDownOpacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                cardsDownOpacity = 1
                            }
                        }
                    }
                    
                    
                    
                }
                .transition(.opacity)
                .transition(.push(from: .top))
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(8)
                .padding(.top, UIScreen.height / 5)
            }
            
            if step == .cardsAnalysis {
                VStack() {
                    Text("Art, Interpreted")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Experience an AI's perspective on what each artwork symbolizes")
                        .font(.system(.title3, design: .rounded, weight: .regular))
                        .multilineTextAlignment(.center)
                }
                .transition(.opacity)
                .transition(.push(from: .top))
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(8)
            }
            
            VStack {
                ZStack {
                    VStack {
                        DrawingCardView(imageTitle: "example1", title: "Space Cowboy")
                            .rotationEffect(Angle(degrees: -cardsRotation + demoCardRotation))
                            .offset(x: cardsXOffset - demoCardXOffset, y: cardsYOffset - demoCardYOffset - cardsGalleryOffset)
                            .scaleEffect(step == .cardsAnalysis && !UIScreen.isSE ? 1.3 : 1)
                            .scaleEffect(step == .gallery || step == .kidName || step == .kidAge ? 1.2 : 1)
                    }
                    
                    DrawingCardView(imageTitle: "example2", title: "Jungle Adventures")
                        .rotationEffect(Angle(degrees: cardsRotation))
                        .offset(x: -cardsXOffset, y: -cardsYOffset + (cardsDownYOffset * 4))
                        .scaleEffect(step == .gallery || step == .kidName || step == .kidAge ? 1.2 : 1)
                }
                .opacity(cardsOpacity)
                .offset(y: -cardsKidDataOffset)
                
                if step == .kidName {
                    VStack(spacing: 0) {
                        Text("Who's the Artist?")
                            .font(.system(.title, design: .rounded, weight: .medium))
                        
                        VStack(spacing: 4) {
                            TextField(text: $kid.name, prompt: Text("Kid's name"), label: {
                                
                            })
                            .focused($isTextFieldFocused)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .submitLabel(.done)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.accent)
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .tint(.accent)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Button("Done") {
                                        isTextFieldFocused = false
                                    }
                                    .font(.system(.body, design: .rounded, weight: .semibold))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.horizontal, 64)
                                .opacity(0.5)
                        }
                        .padding(.top)
                    }
                    .offset(y: 20)
                    .transition(.opacity)
                }
                
                if step == .kidAge {
                    VStack(spacing: 0) {
                        Text("How old is \(kid.name)?")
                            .font(.system(.title, design: .rounded, weight: .medium))
                        
                        VStack() {
                            Text("\(kid.birthdate.age()) years old")
                                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            
                            DatePicker("Birthdate", selection: $kid.birthdate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .fixedSize()
                                .tint(.accent)
                                .foregroundStyle(.accent)
                        }
                        .padding(.top)
                    }
                    .offset(y: 20)
                    .transition(.opacity)
                    .animation(nil)
                }
                
                VStack(spacing: 0) {
                    Text("Welcome to")
                        .font(.system(.title, design: .rounded, weight: .medium))
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 180)
                }
                .opacity(logoOpacity)
                .onAppear {
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            logoOpacity = 1
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        withAnimation(.easeInOut(duration: 1)) {
                            buttonOpacity = 1
                        }
                        
                        withAnimation(.snappy(duration: 0.8), {
                            step = .cardsAppear
                        })
                    }
                }
                
                if step == .gallery {
                    VStack {
                        Image(systemName: "icloud")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 42)
                            .foregroundStyle(.accent)
                            .fontWeight(.regular)
                        Text("Your Gallery in the Cloud")
                            .font(.system(.title, design: .rounded, weight: .medium))
                        Text("Store and showcase a colorful array of drawings in your personal gallery")
                            .font(.system(.title3, design: .rounded, weight: .regular))
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                            .opacity(galleryOpacity)
                    }
                    .offset(y: -20)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(.snappy(duration: 1.5)) {
                                galleryOpacity = 1
                            }
                        }
                    }
                }
                
                ZStack {
                    DrawingCardView(imageTitle: "example4", title: "My Happy Farm")
                        .rotationEffect(Angle(degrees: -cardsRotation - readyToGoRotation))
                        .offset(x: cardsXOffset, y: cardsYOffset - cardsDownYOffset - (cardsGalleryOffset * 0.9))
                        .scaleEffect(step == .gallery || step == .kidName || step == .kidAge ? 1.2 : 1)
                    
                    DrawingCardView(imageTitle: "example3", title: "Sunny Day Family")
                        .rotationEffect(Angle(degrees: cardsRotation + readyToGoRotation))
                        .offset(x: -cardsXOffset, y: -cardsYOffset + (cardsDownYOffset * 3) + cardsGalleryOffset)
                        .scaleEffect(step == .gallery || step == .kidName || step == .kidAge ? 1.2 : 1)
                }
                .padding(.top, 40)
                .offset(y: cardsKidDataOffset)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.paperBeige)
        .foregroundStyle(.accent)
        .navigationDestination(isPresented: $navigateToRequestReview) {
            //            Navigate towards you wish
            //            RequestReviewView()
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                Haptic.shared.lightImpact()
                if step == .readyToGo {
                    //                    Save logic or whatever you need before leaving
                    //                    userManager.kid = self.kid
                    
                    // Toggle navigation logic
                    // navigateToRequestReview.toggle()
                } else {
                    DispatchQueue.main.async {
                        withAnimation(.snappy(duration: 0.8), {
                            advanceStep()
                        })
                    }
                }
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(maxWidth: step == .readyToGo ? 200 : 140, maxHeight: 45)
                        .foregroundStyle(.accent)
                    
                    if step != .readyToGo {
                        Image(systemName: "arrowshape.right")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 24)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .offset(x: arrowOffset)
                            .onAppear {
                                DispatchQueue.main.async {
                                    withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                                        arrowOffset = 3
                                    }
                                }
                            }
                    } else {
                        Text("Let's go!")
                            .foregroundStyle(.white)
                            .font(.system(.body, design: .rounded, weight: .semibold))
                    }
                }
            }
            .padding(.bottom, UIScreen.isSE ? 8 : 0)
            .opacity(step == .kidName && kid.name.isEmpty || isTextFieldFocused ? 0 : buttonOpacity)
        }
    }
    
    func advanceStep() {
        var nextStep: OnboardingStep
        
        switch step {
        case .start:
            nextStep = .cardsAppear
        case .cardsAppear:
            logoOpacity = 0
            nextStep = .cardsDown
        case .cardsDown:
            nextStep = .cardsAnalysis
        case .cardsAnalysis:
            nextStep = .gallery
        case .gallery:
            nextStep = .kidName
        case .kidName:
            nextStep = .kidAge
        case .kidAge:
            nextStep = .readyToGo
        case .readyToGo:
            nextStep = .readyToGo
        }
        
        step = nextStep
    }
    
    var exampleAnalysis = "This vibrant drawing, which seems to have been crafted with a mix of crayon and colored pencils, depicts a lively outer space scene filled with astronomical elements. At the center of the composition is a classic red and white rocket with flames shooting out from the bottom, suggesting motion and energy. To the right of the rocket stands an astronaut, outfitted in a traditional white space suit and helmet, evoking a sense of exploration and curiosity. Scattered across the page are various celestial bodies, including stars twinkling in bright yellow, planets shown with rings and different colors suggesting they might represent Saturn or imaginary planets, and a fiery orange celestial object resembling the sun. The way the stars are arranged gives a sense of whimsy and delight, hinting that the child might feel a sense of wonder towards the universe. Each element is outlined boldly, which is a characteristic approach for young children as they define their shapes with confidence. The use of space and the depiction of the astronaut might suggest Andys's fascination with space travel, adventure, and perhaps a dream of becoming an astronaut. The artwork exudes a sense of joy and excitement, possibly reflecting Andy's optimistic perception of space as a place for amazing adventures."
}

#Preview {
    OnboardingView()
}

struct DrawingCardView: View {
    @State var imageTitle: String
    @State var title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
                .shadow(radius: 5)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                Image(imageTitle)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8.0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(8)
        }
        .frame(maxWidth: 220, maxHeight: 200)
        .foregroundStyle(.accent)
    }
}

struct Kid: Codable {
    let id: String
    var name: String
    var birthdate: Date
}

extension Kid {
    static func mockKid() -> Kid {
        Kid(id: "kidID", name: "Andy", birthdate: Date().subtractingYears(5))
    }
}

extension Date {
    func age() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year ?? 0
    }
    
    func addingYears(_ years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
    }
    
    func subtractingYears(_ years: Int) -> Date {
        return addingYears(-years)
    }
}

extension UIScreen {
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var isSE: Bool {
        width == 375 && height == 667
    }
}
