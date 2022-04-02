//
//  RootApplicationCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

final class RootApplicationCoordinator: Coordinator {
    
    // MARK: - Private variables
    
    private let window: UIWindow?
    
    // Делаем глобальное св-во чтобы объект не удалился из памяти т.к. он создается в локальной области видимости
    // В любой момент мы можем присвоить `nil` и данный координатор закроется
    private var mainScreenCoordinator: Coordinator?
    
    // MARK: - Initialization
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Public func
    
    func start() {
        // Создаем NavigationController
        let navigationController = UINavigationController()
        
        // Создаем координатор главного(первого) экрана
        let mainScreenCoordinator = MainScreenCoordinator(navigationController)
        
        // Сохраняем локальную ссылку, чтобы наш объект не удалился из памяти
        // Если присвоить `self.mainScreenCoordinator` nil, то координатор закроется
        self.mainScreenCoordinator = mainScreenCoordinator
        
        // Командой `start` мы запускаем координатор
        mainScreenCoordinator.start()
        
        // Эти настройки делаются один раз, для запуска главного экрана
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
