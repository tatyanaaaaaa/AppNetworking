//
//  MainScreenViewController.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от `Главного экрана`
public protocol MainScreenModuleOutput: AnyObject {
    
    /// Пользователь нажал `Изменить цвет экрана`
    /// - Parameters:
    ///   - color: `Текущий цвет экрана`
    func userPressedChange(color: UIColor?)
}

/// `Модуль главного экрана`
public protocol MainScreenModuleInput {
    
    /// Обработчик событий от `Главного экрана`
    var moduleOutput: MainScreenModuleOutput? { get set }
}

/// Готовый модуль `Главного экрана`
public typealias MainScreenModule = UIViewController & MainScreenModuleInput

/// Главный экран
final class MainScreenViewController: MainScreenModule {
    
    // MARK: - Public property
    
    public weak var moduleOutput: MainScreenModuleOutput?
    
    // MARK: - Private property
    
    private let interactor: MainScreenInteractorInput
    private let viewAssembly: () -> UIView & MainScreenViewInput
    private lazy var moduleView: UIView & MainScreenViewInput = viewAssembly()
    private let factory: MainScreenFactoryInput
    
    /// Инициализатор
    /// - Parameters:
    ///   - interactor: интерактор
    ///   - viewAssembly: вью
    ///   - factory: фабрика
    init(interactor: MainScreenInteractorInput,
         viewAssembly: @escaping () -> UIView & MainScreenViewInput,
         factory: MainScreenFactoryInput) {
        self.interactor = interactor
        self.viewAssembly = viewAssembly
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moduleView.output = self
        interactor.getContent()
        title = Appearance().title
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenViewController: MainScreenInteractorOutput {
    func didReceive(text: String) {
        factory.createTitle(text: text, output: self)
    }
}

// MARK: - MainScreenViewOutput

extension MainScreenViewController: MainScreenViewOutput {
    func presentNewScreenButtonAction() {
        moduleView.changeBackgroundColor()
        moduleOutput?.userPressedChange(color: view.backgroundColor)
    }
}

// MARK: - MainScreenFactoryOutput

extension MainScreenViewController: MainScreenFactoryOutput {
    func didReciveFull(text: String) {
        moduleView.setTitle(text: text)
    }
}

// MARK: - Appearance

private extension MainScreenViewController {
    struct Appearance {
        let title = "ROUTING to Coordinator"
    }
}
