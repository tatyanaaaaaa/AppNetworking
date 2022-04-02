//
//  MainScreenFactory.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от `Главного Экрана`
protocol MainScreenFactoryOutput: AnyObject {
    
    /// Был получен готовый текст
    /// - Parameters:
    /// - text: готовый, сформированный `текст`
    func didReciveFull(text: String)
}

/// Фабрика элментов `Главного Экрана`
protocol MainScreenFactoryInput {
    
    /// Создает секции для отображения
    /// - Parameters:
    ///   - text: `вторая часть готового текста`
    ///   - output: output `MainScreenFactoryOutput`
    /// - Returns: секции
    func createTitle(text: String, output: MainScreenFactoryOutput)
}

/// Фабрика элментов `Главного Экрана`
final class MainScreenFactory: MainScreenFactoryInput {
    func createTitle(text: String, output: MainScreenFactoryOutput) {
        let fullText = "\(Appearance().title), \(text)"
        output.didReciveFull(text: fullText)
    }
}

// MARK: - Appearance

private extension MainScreenFactory {
    struct Appearance {
        let title = "Hello"
    }
}
