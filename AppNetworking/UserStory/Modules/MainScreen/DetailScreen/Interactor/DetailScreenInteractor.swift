//
//  DetailScreenInteractor.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от интерактора
protocol DetailScreenInteractorOutput: AnyObject {
    
    /// `Были получены данные`
    /// - Parameter text: текст
    func didReceive(text: String)
}

/// Интерактор `Главный экран`
protocol DetailScreenInteractorInput {
    
    /// Загрузить контент
    func getContent()
}

/// Интерактор `Экрана выбора банка получателя`
final class DetailScreenInteractor: DetailScreenInteractorInput {
    
    weak var output: DetailScreenInteractorOutput?
    
    func getContent() {
        let appearance = Appearance()
        output?.didReceive(text: appearance.someText)
    }
}

// MARK: - Appearance

private extension DetailScreenInteractor {
    struct Appearance {
        let someText = "НОВЫЙ ЭКРАН"
    }
}
