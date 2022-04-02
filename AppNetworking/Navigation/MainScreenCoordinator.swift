//
//  MainScreenCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от Coordinator `Главного экрана`
protocol MainScreenCoordinatorOutput: AnyObject { }

/// `Coordinator главного экрана`
protocol MainScreenCoordinatorInput {
    
    /// Обработчик событий от `Главного экрана`
    var moduleOutput: MainScreenCoordinatorOutput? { get set }
}

/// `Coordinator protocol`
typealias MainScreenCoordinatorProtocol = Coordinator & MainScreenCoordinatorInput

// Координатор главного экрана
final class MainScreenCoordinator: MainScreenCoordinatorProtocol {
    
    // MARK: - Internal variables
    
    /// Обработчик событий от Coordinator `Главного экрана`
    weak var moduleOutput: MainScreenCoordinatorOutput?
    
    // MARK: - Private variables
    
    private let navigationController: UINavigationController
    private var mainScreenModule: MainScreenModule?
    private var detailCoordinator: Coordinator?
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - navigationController: UINavigationController
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal func
    
    func start() {
        // Создаем наш модуль главного экрана
        let mainScreenModule = MainScreenAssembly().createModule()
        
        // Копируем ссылку в глобальную область видимости, чтобы объект не удалился из памяти
        self.mainScreenModule = mainScreenModule
        
        // Подписываемся на события протокола MainScreenModuleOutput
        self.mainScreenModule?.moduleOutput = self
        
        // Открываем текущий модуль
        navigationController.pushViewController(mainScreenModule, animated: true)
    }
    
    // MARK: - Private func
    
    private func presentDetailCoordinator(_ navigationController: UINavigationController,
                                          color: UIColor?) {
        // Прокидываем UINavigationController во второй экран (координатор)
        let detailCoordinator = DetailScreenCoordinator(navigationController)
        
        // Копируем ссылку в глобальную область видимости, чтобы объект не удалился из памяти
        self.detailCoordinator = detailCoordinator
        
        // Передаем с первого экрана ЦВЕТ, на второй экран
        detailCoordinator.colorForView = color
        
        // Подписываемся на события протокола DetailScreenCoordinatorOutput
        detailCoordinator.moduleOutput = self
        
        // Открываем текущий модуль
        detailCoordinator.start()
    }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {
    func userPressedChange(color: UIColor?) {
        presentDetailCoordinator(navigationController, color: color)
    }
}

// MARK: - DetailScreenCoordinatorOutput

extension MainScreenCoordinator: DetailScreenCoordinatorOutput { }
