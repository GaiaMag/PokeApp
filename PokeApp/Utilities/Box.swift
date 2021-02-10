//
//  Box.swift
//  PokeApp
//
//  Created by Gaia Magnani on 03/02/2021.
//

import Foundation

final class Box<T> {
    
  typealias Listener = (T) -> Void
  var listener: Listener?
  var value: T {
    didSet {
      listener?(value)
    }
  }
  init(_ value: T) {
    self.value = value
  }
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }

}
