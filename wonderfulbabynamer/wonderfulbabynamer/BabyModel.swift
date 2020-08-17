//
//  BabyModel.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import Foundation

import SwiftUI

enum Gender: String {
  case girl = "f"
  case boy = "m"
  // TODO: unisex and gender neural

  var name: String {
    switch self {
    case .girl:
      return "Girl"
    case .boy:
      return "Boy"
    }
  }
}

enum LoadingError: Error {
  case pathNotFound(String)
}

struct BabyName: Identifiable {
  init(name: String, gender: Gender, frequency: Int) {
    self.name = name
    self.gender = gender
    self.frequency = frequency
  }

  init?(commaSeparatedLine: String) {
    let values = commaSeparatedLine.split(separator: ",")
    guard values.count == 3,
          let gender = Gender(rawValue: values[1].lowercased()),
          let frequency = Int(values[2]) else {
      return nil
    }
    self.name = values[0].lowercased()
    self.gender = gender
    self.frequency = frequency
  }

  var id: String { name }

  static func load(fromResource name: String) throws -> [BabyName] {
    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
      throw LoadingError.pathNotFound(name)
    }
    let file = try String(contentsOfFile: path)
    let lines = file.split(separator: "\r\n")
    return lines.compactMap { BabyName(commaSeparatedLine: String($0)) }
  }

  var name: String
  var gender: Gender
  var frequency: Int
}

enum SortOrder {
  case alpha, popularity

  var name: String {
    switch self {
    case .alpha:
      return "A-Z"
    case .popularity:
      return "Popular"
    }
  }
}

final class BabyNameModel: ObservableObject {
  @Published var favorites: [String] = []
  @Published var filterString: String
  @Published var filterGender: Gender
  @Published var order: SortOrder
  var babyNames: [BabyName] {
    Array(Self.filter(database: database, filterString: filterString,
                      filterGender: filterGender, order: order).prefix(500))
  }
  private var database: [BabyName]

  init() {
    filterString = ""
    filterGender = .girl
    order = .popularity
    database = try! BabyName.load(fromResource: "yob2018")
  }

  func tapFavorite(name: String) {
    if favorites.contains(name) {
      favorites.removeAll { name == $0 }
    }
    else {
      favorites.insert(name, at: 0)
    }
  }

  static func filter(database: [BabyName],
                     filterString: String,
                     filterGender: Gender,
                     order: SortOrder) -> [BabyName] {

    var result = database.filter { filterGender == $0.gender }
    if !filterString.isEmpty {
      result = result.filter { $0.name.hasPrefix(filterString.lowercased()) }
    }

    switch order {
    case .alpha:
      result.sort { $0.name < $1.name }
    case .popularity:
      result.sort { $0.frequency > $1.frequency }
    }

    return result
  }
}

struct ContentTestView: View {

  @StateObject var model = BabyNameModel()

  var body: some View {
    TabView {
      NavigationView {
        VStack {
          HStack {
            TextField("Search...", text: $model.filterString)
              .textFieldStyle(PlainTextFieldStyle())
            Picker(selection: $model.order,
                   label: Text(model.order.name)) {
              Text(SortOrder.alpha.name).tag(SortOrder.alpha)
              Text(SortOrder.popularity.name).tag(SortOrder.popularity)
            }.pickerStyle(MenuPickerStyle())

            Picker(selection: $model.filterGender,
                   label: Text(model.filterGender.name)) {
              Text(Gender.boy.name).tag(Gender.boy)
              Text(Gender.girl.name).tag(Gender.girl)
            }.pickerStyle(MenuPickerStyle())
          }.padding()
          List(model.babyNames) { babyName in
            HStack {
              Text(babyName.name.localizedCapitalized)
              Spacer()
              Group {
                if model.favorites.contains(babyName.name) {
                  Image(systemName: "heart.fill").foregroundColor(.red)
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
          }.navigationTitle("Baby Names")
        }
      }.tabItem {
        Image(systemName: "a.book.closed.fill")
        Text("Names")
      }
      NavigationView {

        Group {
          if (model.favorites.isEmpty) {
            Text("No favorites yet")
          }
          else {
            List(model.favorites, id: \.self) { name in
              HStack {
                Text(name.localizedCapitalized)
                Spacer()
                Image(systemName: "heart.fill").foregroundColor(.red).onTapGesture {
                  withAnimation {
                    model.tapFavorite(name: name)
                  }
                }
              }
            }
          }
        }.navigationTitle("Favorites")
      }
      .tabItem {
        Image(systemName: "heart.fill")
        Text("Favorites")
      }
    }.accentColor(.orange)
  }
}

