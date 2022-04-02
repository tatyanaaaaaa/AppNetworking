//
//  DetailScreenFactory.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от `Детального Экрана`
protocol DetailScreenFactoryOutput: AnyObject {
    
    /// Был получен готовый текст
    /// - Parameters:
    /// - text: готовый, сформированный `текст`
    func didReciveFull(text: String)
}

/// Фабрика элментов `Главного Экрана`
protocol DetailScreenFactoryInput {
    
    /// Создает секции для отображения
    /// - Parameters:
    ///   - text: `вторая часть готового текста`
    ///   - output: output `DetailScreenFactoryOutput`
    /// - Returns: секции
    func createTitle(text: String, output: DetailScreenFactoryOutput)
}

/// Фабрика элментов `Главного Экрана`
final class DetailScreenFactory: DetailScreenFactoryInput {
    func createTitle(text: String, output: DetailScreenFactoryOutput) {
        let fullText = "\(Appearance().title) \(text)"
        output.didReciveFull(text: fullText)
    }
}

// MARK: - Appearance

private extension DetailScreenFactory {
    struct Appearance {
        let title = "это - "
    }
}
