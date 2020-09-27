//
//  ContentView.swift
//  Codiv-19 Swift UI API
//
//  Created by Baskoro Nugroho on 27/09/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var index = 0
    var body: some View {
        VStack {
            VStack(spacing: 18) {
                
                HStack {
                    Text("Statistics")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("USA")
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top) // safe area inset
                
                HStack {
                    Button(action: {
                        self.index = 0
                    }, label: {
                        Text("My Country")
                            .foregroundColor(self.index == 0 ? .black : .white)
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                    })
                    .background(self.index == 0 ? Color.white : Color.black)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        self.index = 1
                    }, label: {
                        Text("Global")
                            .foregroundColor(self.index == 1 ? .black : .white)
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                    })
                    .background(self.index == 1 ? Color.white : Color.black)
                    .clipShape(Capsule())
                }
                .background(Color.black.opacity(0.25))
                .clipShape(Capsule())
                .padding(.top, 10)
                
                
                HStack(spacing: 15) {
                    VStack(spacing: 12) {
                        Text("Affected")
                        Text("221,333")
                            .fontWeight(.bold)
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 45)
            .background(Color("bg"))
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
