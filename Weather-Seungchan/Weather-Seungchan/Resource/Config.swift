//
//  Config.swift
//  Weather-Seungchan
//
//  Created by 김승찬 on 2023/11/14.
//


import Foundation

enum Config {
  enum Keys {
    enum Plist {
      static let apiKey = "API_KEY"
    }
  }
    
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("plist cannot found.")
    }
    return dict
  }()
}

extension Config {
  static let apiKey: String = {
    guard let key = Config.infoDictionary[Keys.Plist.apiKey] as? String else {
      fatalError("not found")
    }
    return key
  }()
}
