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
    @State var main : MainData!
    @State var daily : [Daily] = []
    @State var last : Int = 0
    @State var country = "indonesia"
    @State var alert = false
    
    var body: some View {
        VStack {
            if self.main != nil && !self.daily.isEmpty {
                VStack {
                    VStack(spacing: 18) {
                        HStack {
                            Text("Statistics")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                self.showDialog()
                            }, label: {
                                Text(self.country.uppercased())
                                    .foregroundColor(.white)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            })
                        }
                        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
                        
                        HStack {
                            Button(action: {
                                self.index = 0
                                self.main = nil
                                self.daily.removeAll()
                                self.getData()
                            }, label: {
                                Text("My Country")
                                    .foregroundColor(self.index == 0 ? .black : .white)
                                    .padding(.vertical, 12)
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                            })
                            .clipShape(Capsule())
                            .background(self.index == 0 ? Color.white : Color.black)
                            
                            
                            Button(action: {
                                self.index = 1
                                self.main = nil
                                self.daily.removeAll()
                                self.getData()
                            }, label: {
                                Text("Global")
                                    .foregroundColor(self.index == 1 ? .black : .white)
                                    .padding(.vertical, 12)
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                            })
                            .clipShape(Capsule())
                            .background(self.index == 1 ? Color.white : Color.black)
                            
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
                        
                        //recovered active, serious
                        HStack(spacing: 15) {
                            VStack(spacing: 12) {
                                Text("Recovered")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("21,333")
                                    .fontWeight(.bold)
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
                            ForEach(self.daily) {i in
                                VStack(spacing: 10) {
                                    Text("\(i.cases / 1000)K")
                                        .lineLimit(1)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    GeometryReader {g in
                                        VStack {
                                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                            Rectangle()
                                            .fill(Color("death"))
                                                .frame(width: 15, height: self.getHeight(value: i.cases, height: g.frame(in: .global).height))
                                        }
                                    }
                                    Text(i.day)
                                        .lineLimit(1)
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
            else {
                Indicator()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Invalid country name"), dismissButton: .destructive(Text("Ok")))
        })
        .onAppear {
            self.getData()
        }
    }
    
    func getData() {
        var url = ""
        if self.index == 0 {
            url = "https://corona.lmao.ninja/v2/countries/\(self.country)?yesterday=false"
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
        
        var url1 = ""
        if self.index == 0 {
            url1 = "https://corona.lmao.ninja/v2/historical/\(self.country)?lastdays=7"
        } else {
            url1 = "https://corona.lmao.ninja/v2/historical/all?lastdays=7"
        }
        
        let session1 = URLSession(configuration: .default)
        session1.dataTask(with: URL(string: url1)!) {
            (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            var count = 0
            var cases: [String: Int] = [:]
            if self.index == 0 {
                let json = try! JSONDecoder().decode(MyCountry.self, from: data!)
                cases = json.timeline["cases"]!
            } else {
                let json = try! JSONDecoder().decode(Global.self, from: data!)
                cases = json.cases
            }
            
            for i in cases {
                self.daily.append(Daily(id: count, day: i.key, cases: i.value))
                count += 1
            }
            self.last = self.daily.last!.cases
        }
        .resume()
    }
    
    func getHeight(value : Int,height:CGFloat)->CGFloat{
        if self.last != 0 {
            let converted = CGFloat(value) / CGFloat(self.last)
            return converted * height
        }
        else{
            return 0
        }
    }
    
    func showDialog() {
        let alert = UIAlertController(title: "Country", message: "Type a country", preferredStyle: .alert)
        alert.addTextField { (_) in
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            (_) in
            for i in countryList {
                if i.lowercased() == alert.textFields![0].text!.lowercased() {
                    self.country = alert.textFields![0].text!.lowercased()
                    self.main = nil
                    self.daily.removeAll()
                    self.getData()
                    return
                }
            }
            self.alert.toggle()
            print(alert.textFields![0].text!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
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
