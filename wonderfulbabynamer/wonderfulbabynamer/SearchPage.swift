//
//  SearchPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI

struct SearchPage: View {
  
  @StateObject var model = BabyNameModel()
  
  let magenta = Color(UIColor(red: CGFloat(0xcc)/255, green: CGFloat(0x33)/255,
                              blue: CGFloat(0x8b)/255, alpha: 1))
  
  var body: some View {
    TabView {
      ZStack {
        Image("blue_bg").resizable().ignoresSafeArea()
        VStack {
          
          TextField("\(Image(systemName: "magnifyingglass")) Search...", text: $model.filterString)
            .padding()
            .background(Color(.systemBackground))
            .border(Color.gray)
            .padding(EdgeInsets(top: 60, leading: 10, bottom: 10, trailing: 10))
          ZStack {
            Image("green_banner").resizable().frame(width: 400, height: 230
            )
            VStack {
              
              Text("Child Parameters...")
                .font(Font.custom ("HennyPenny-Regular", size: 20))
                .padding(.top, 20)
                .padding(.bottom, -10)
              
              HStack {
                Spacer()
                
                ZStack {
                  Image(model.filterGender == .boy ? "boy" : "girl")
                    .frame(width: 40, height: 40).shadow(radius: 2)
                  Text(model.filterGender.name).foregroundColor(.black)
                    .offset(y: model.filterGender == .boy ? 35.0 : 25.0)
                  
                }
                .padding(30)
                .onTapGesture {
                  model.filterGender = model.filterGender == .boy ? .girl : .boy
                }
                
                
                Spacer()
                
                ZStack {
                  Image(model.order == .popularity ? "mixed" : "mixed")
                    .frame(width: 40, height: 40).shadow(radius: 2)
                  Text(model.order.name).foregroundColor(.black)
                    .offset(y: model.order == .popularity ? 25.0 : 25.0)
                  
                }
                .padding(30)
                .onTapGesture {
                  model.order = model.order == .alpha ? .popularity : .alpha
                }
                Spacer()
              }.padding(.bottom, 30)
            }
          }
                    
          List(model.babyNames) { babyName in
            HStack {
              Text(babyName.name.localizedCapitalized)
              Spacer()
              Group {
                if model.favorites.contains(babyName.name) {
                  Image(systemName: "heart.fill").foregroundColor(magenta)
                }
                else {
                  Image(systemName: "heart").foregroundColor(.gray)
                }
              }.onTapGesture {
                withAnimation {
                  model.tapFavorite(name: babyName.name)
                }
              }
            }
          }
        }
      }.tabItem {
        Text("Search")
        Image(systemName: "magnifyingglass")
      }
      
      RankPage(model: model).tabItem {
        Text("My Favorites")
        Image(systemName: "heart")
      }
    }.accentColor(magenta)
  }
}

struct SearchPage_Previews: PreviewProvider {
  static var previews: some View {
    SearchPage()
  }
}


