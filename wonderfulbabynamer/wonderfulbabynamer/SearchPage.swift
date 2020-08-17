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
            Image("green_banner").resizable().frame(width: 400, height: 280)
            VStack(spacing: 0) {
              HStack {
                Spacer()
                
                ZStack {
                  Image(model.filterGender == .boy ? "boy_state" : "girl_state")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 168).shadow(radius: 2)
                  Text(model.filterGender.name).foregroundColor(.black)
                    .offset(x: 35, y: -65)
                    .font(.body)
                }
                .onTapGesture {
                  model.filterGender = model.filterGender == .boy ? .girl : .boy
                }
                Spacer()
                
                ZStack {
                  Image(model.order == .popularity ? "popularity" : "AZee")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150).shadow(radius: 2)
                  Text(model.order.name).foregroundColor(.black)
                    .offset(x: -25, y: -65)
                    .font(.body)
                }
                .onTapGesture {
                  model.order = model.order == .alpha ? .popularity : .alpha
                }
                Spacer()
              }
              Text("Tap To Change")
                .font(Font.custom ("HennyPenny-Regular", size: 20))
              Spacer()
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


