//
//  DetailScreenCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от Coordinator `Детального экрана`
protocol DetailScreenCoordinatorOutput: AnyObject { }

/// `Coordinator детального экрана`
protocol DetailScreenCoordinatorInput {
    
    /// Обработчик событий от `Детального экрана`
    var moduleOutput: DetailScreenCoordinatorOutput? { get set }
    
    /// Цвет фона экрана
    var colorForView: UIColor? { get set }
}

/// `Coordinator protocol`
typealias DetailScreenCoordinatorProtocol = Coordinator & DetailScreenCoordinatorInput

final class DetailScreenCoordinator: DetailScreenCoordinatorProtocol {
    
    // MARK: - Internal variables
    
    var colorForView: UIColor?
    weak var moduleOutput: DetailScreenCoordinatorOutput?
    
    // MARK: - Private variables
    
    private let navigationController: UINavigationController
    private var detailScreenModule: DetailScreenModule?
    
    // MARK: - Initialization
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public func
    
    func start() {
        let detailScreenModule = DetailScreenAssembly().createModule()
        self.detailScreenModule = detailScreenModule
        self.detailScreenModule?.moduleOutput = self
        self.detailScreenModule?.colorForView = colorForView
        
        navigationController.pushViewController(detailScreenModule, animated: true)
    }
}

// MARK: - DetailScreenModuleOutput

extension DetailScreenCoordinator: DetailScreenModuleOutput {
    func didCloseModule() {
        navigationController.popViewController(animated: true)
    }
}
