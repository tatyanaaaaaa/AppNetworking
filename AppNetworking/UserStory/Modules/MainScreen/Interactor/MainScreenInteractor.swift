//
//  MainScreenInteractor.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от интерактора
protocol MainScreenInteractorOutput: AnyObject {
    
    /// `Были получены данные`
    /// - Parameter text: текст
    func didReceive(text: String)
}

/// Интерактор `Главный экран`
protocol MainScreenInteractorInput {
    
    /// Загрузить контент
    func getContent()
}

/// Интерактор `Экрана выбора банка получателя`
final class MainScreenInteractor: MainScreenInteractorInput {
    
    weak var output: MainScreenInteractorOutput?
    
    private let mainScreenServices: MainScreenServices
    
    init(mainScreenServices: MainScreenServices) {
        self.mainScreenServices = mainScreenServices
    }
    
    func getContent() {
        mainScreenServices.getContent { result in
            switch result {
            case .success(let news): print("")
            case .failure: break
            }
        }
        let appearance = Appearance()
        output?.didReceive(text: appearance.someText)
    }
}

// MARK: - Appearance

private extension MainScreenInteractor {
    struct Appearance {
        let someText = "world"
    }
}
