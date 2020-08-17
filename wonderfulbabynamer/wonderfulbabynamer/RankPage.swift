//
//  RankPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI


struct NameCell: View {
  var name: String
  var body: some View {
    Text(name)
  }
}

struct RankPage: View {
  
  @ObservedObject var model: BabyNameModel
  
  let magenta = Color(UIColor(red: CGFloat(0xcc)/255, green: CGFloat(0x33)/255,
                              blue: CGFloat(0x8b)/255, alpha: 1))
  
  var body: some View {
    ZStack {
      Image("rankPage").resizable()
        .aspectRatio(contentMode: .fill).ignoresSafeArea()
      
      VStack() {
        Text("My Favorites")
          .font(Font.custom("HennyPenny-Regular", size: 35))
          .padding(.top, 80)
          .padding(30)
        Group {
          if (model.favorites.isEmpty) {
            Text("No favorites yet")
          }
          else {
            VStack(alignment: .leading, spacing: 50) {
              ForEach(model.favorites, id: \.self) { name in
                HStack {
                  Text(name.localizedCapitalized)
                  Spacer()
                  Image(systemName: "heart.fill").foregroundColor(magenta).onTapGesture {
                    withAnimation {
                      model.tapFavorite(name: name)
                    }
                  }
                }
                .font(.title)
                .frame(height: 10)
              }
            }
            .padding(100)
          }
        }
        Spacer()
      }
    }
  }
}

struct RankPage_Previews: PreviewProvider {
  static var previews: some View {
    TabView {
      RankPage(model: BabyNameModel(favorites: [
                                      "Fred", "Joe", "Biden", "Mamala"]))
    }
  }
}
