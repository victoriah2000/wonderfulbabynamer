//
//  SearchPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI

struct SearchPage: View {
  var body: some View {
    VStack(alignment: .leading) {
      
      ZStack {
        VStack {
          HStack(alignment: .top, spacing: -5.0) {
           // Image ("bunny_banner")
            //  .resizable()
            //  .padding(.leading, -20)
            //  .frame(width:386, height: 235 )
            Spacer()
          }
          Spacer()
          HStack(alignment: .bottom) {
            Image ("green_banner")
              .padding(.all)
              .frame(width: 0.0)
            Spacer()
            Image ("boy")
          }
        }
        .background(Image("blue_bg"), alignment: .center )
      }
    }
  }
}

struct SearchPage_Previews: PreviewProvider {
  static var previews: some View {
    SearchPage().previewLayout(.fixed(width: 414, height: 896))
  }
}


