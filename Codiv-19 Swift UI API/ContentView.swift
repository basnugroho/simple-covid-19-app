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
    @State var main: MainData!
    
    var body: some View {
        VStack {
            if self.main != nil {
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
                                self.main = nil
                                self.getData()
                                
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
                                self.main = nil
                                self.getData()
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
                        
                        // affected, death
                        HStack(spacing: 15) {
                            VStack(spacing: 12) {
                                Text("Affected")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(self.main.cases)")
                                    .fontWeight(.bold)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 2 - 30)
                            .background(Color("affected"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12) {
                                Text("Death")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(self.main.deaths)")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 2 - 30)
                            .background(Color("death"))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        
                        HStack(spacing: 15) {
                            VStack(spacing: 12) {
                                Text("Recovered")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("21,333")
                                    .fontWeight(.bold)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 3 - 30)
                            .background(Color("recovered"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12) {
                                Text("Active")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(self.main.active)")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 3 - 30)
                            .background(Color("active"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12) {
                                Text("Serious")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(self.main.critical)")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 3 - 30)
                            .background(Color("serious"))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 45)
                    .background(Color("bg"))
                    
                    VStack(spacing: 15){
                        HStack {
                            Text("Last 7 days")
                                .font(.title)
                                .foregroundColor(.black)
                                Spacer()
                        }
                        .padding(.top)
                        //Graph
                        HStack {
                            ForEach(0...6, id: \.self) {_ in
                                VStack(spacing: 10) {
                                    Text("330K")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    GeometryReader {g in
                                        VStack {
                                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                            Capsule()
                                            .fill(Color("death"))
                                            .frame(width: 15)
                                        }
                                    }
                                    
                                    Text("4/4/20")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, -30)
                    .offset(y: -30)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.getData()
        }
    }
    
    func getData() {
        var url = ""
        if self.index == 0 {
            url = "https://corona.lmao.ninja/v2/countries/usa?yesterday=false"
        } else {
            url = "https://corona.lmao.ninja/v2/all"
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) {
            (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSONDecoder().decode(MainData.self, from: data!)
            self.main = json
        }
        .resume()
    }
}



// Data Models For JSON Parsing....

struct Daily: Identifiable{
    
    var id : Int
    var day : String
    var cases : Int
}

struct MainData : Decodable{
    
    var deaths : Int
    var recovered : Int
    var active : Int
    var critical : Int
    var cases : Int
}

struct MyCountry : Decodable {
    
    var timeline : [String : [String : Int]]
}

struct Global : Decodable {
    
    var cases : [String : Int]
}

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) ->  UIActivityIndicatorView {
        
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) {
        
        
    }
}
