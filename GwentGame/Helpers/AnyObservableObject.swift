//
//  AnyObservableObject.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import Combine

/// Стертый тип ObservableObject
///
/// Использование AnyObservableObject без ObservableObject в реализации - невозможно.
///
///     protocol IExampleViewModel: AnyObservableObject { ... }
///     class ExampleViewModel: ObservableObject, AnyObservableObject { ... }
public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}
