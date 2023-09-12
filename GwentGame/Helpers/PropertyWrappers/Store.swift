//
//  Store.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import Combine
import SwiftUI

/// Property wrapper - аналог `@ObservedObject`, для ViewModels закрытых протоколами.
///
/// Использование с `ObservableObject` - невозможно. Только `AnyObservableObject`
///
///     protocol IExampleViewModel: AnyObservableObject { ... }
///
///     struct ExampleView: View {
///         @Store
///         var viewModel: IExampleViewModel
///     }
@propertyWrapper
@frozen
public struct Store<ModelType>: DynamicProperty {
    @dynamicMemberLookup
    @frozen
    public struct Wrapper {
        @usableFromInline var store: Store

        @usableFromInline
        init(store: Store) {
            self.store = store
        }

        @inlinable
        public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<ModelType, Value>) -> Binding<Value> {
            Binding(
                get: { self.store.wrappedValue[keyPath: keyPath] },
                set: { self.store.wrappedValue[keyPath: keyPath] = $0 }
            )
        }
    }

    @usableFromInline
    class ErasedObservableObject: ObservableObject {
        @usableFromInline let objectWillChange: AnyPublisher<Void, Never>

        init(objectWillChange: AnyPublisher<Void, Never>) {
            self.objectWillChange = objectWillChange
        }
    }

    // MARK: - Properties

    public let wrappedValue: ModelType

    @ObservedObject
    var observableObject: ErasedObservableObject

    @inlinable public var projectedValue: Wrapper {
        Wrapper(store: self)
    }

    // MARK: - Init

    public init(wrappedValue: ModelType) {
        self.wrappedValue = wrappedValue

        if let objectWillChange = (wrappedValue as? AnyObservableObject)?.objectWillChange {
            observableObject = .init(objectWillChange: objectWillChange.eraseToAnyPublisher())
        } else {
            assertionFailure("Only use the `Store` property wrapper with instances conforming to `AnyObservableObject`.")
            observableObject = .init(objectWillChange: Empty().eraseToAnyPublisher())
        }
    }

    // MARK: - Private

    public mutating func update() {
        _observableObject.update()
    }
}

