//
//  SplashView.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 23.11.22..
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            CharactersView()
        } else {
            VStack {
                VStack {
                    Image("Splash")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    Text("Wubba Lubba Dub Dub!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.green.opacity(0.8))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.7
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
