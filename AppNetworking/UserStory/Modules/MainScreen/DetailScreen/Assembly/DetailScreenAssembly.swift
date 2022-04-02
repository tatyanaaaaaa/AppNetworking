//
//  DetailScreenAssembly.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Сборщик `Детального экрана`
public final class DetailScreenAssembly {
    
    /// Собирает экран
    /// - Returns: собранный модуль
    public func createModule() -> DetailScreenModule {
        
        let interactor = DetailScreenInteractor()
        let view = DetailScreenView()
        let factory = DetailScreenFactory()
        
        let presenter = DetailScreenViewController(interactor: interactor,
                                                 viewAssembly: { view },
                                                 factory: factory)
        interactor.output = presenter
        return presenter
    }
}
