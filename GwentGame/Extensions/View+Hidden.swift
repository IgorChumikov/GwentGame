//
//  View+Hidden.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 07.05.2023.
//

import SwiftUI

public enum HiddenMode {
    /// Скрывается через модификатор `hidden`, не освобождая занимаемое пространство. При появлении view срабатывают методы onFirstAppear и onAppear.
    case hidden
    /// Скрывается через модификатор `opacity`, не освобождая занимаемое пространство. При появлении view не срабатывает метод onAppear.
    case opacity
    /// Скрывается путем удаления view из иерархии, освобождая занимаемое пространство.
    case removed
}

public extension View {
    /// Прячет или показывает View в зависимости от Bool значения. Существует 3 режима скрытия:
    /// - Два с визуальным скрытие элемента, View не освобождает занимаемую площадь. Будто opacity стало 0.
    /// - Полное скрытие элемента, View удаляется из структуры,
    ///
    /// Пример визуального скрытия:
    ///
    ///     HStack {
    ///         Text("Label1")
    ///         Text("Label2")
    ///             .isHidden(true, mode: .hidden) // .isHidden(true, mode: .opacity)
    ///         Text("Label3")
    ///     }
    ///
    ///
    /// Результат: `Label1        Label3`
    ///
    /// Пример полного скрытия:
    ///
    ///     HStack {
    ///         Text("Label1")
    ///         Text("Label2")
    ///             .isHidden(true, mode: .removed)
    ///         Text("Label3")
    ///     }
    ///
    /// Результат: `Label1 Label3`
    ///
    /// - Parameters:
    ///   - hidden: Флаг, определяющий необходимость отображения View.
    ///   - mode: Мод, определяющий поведение скрытия.
    @ViewBuilder
    func hidden(_ hidden: Bool, mode: HiddenMode) -> some View {
        switch mode {
        case .hidden:
            if hidden {
                self.hidden()
            } else {
                self
            }
        case .opacity:
            opacity(hidden ? 0 : 1)
        case .removed:
            if !hidden {
                self
            }
        }
    }
}
