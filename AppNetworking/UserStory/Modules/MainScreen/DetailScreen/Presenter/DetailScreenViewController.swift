//
//  DetailScreenViewController.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от `Детального экрана`
public protocol DetailScreenModuleOutput: AnyObject {
    
    /// Пользователь нажал `Закрыть экран`
    func didCloseModule()
}

/// `Модуль главного экрана`
public protocol DetailScreenModuleInput {
    
    /// Обработчик событий от `Детального экрана`
    var moduleOutput: DetailScreenModuleOutput? { get set }
    
    var colorForView: UIColor? { get set }
}

/// Готовый модуль `Детального экрана`
public typealias DetailScreenModule = UIViewController & DetailScreenModuleInput

/// Главный экран
final class DetailScreenViewController: DetailScreenModule {
    
    // MARK: - Public property
    
    public weak var moduleOutput: DetailScreenModuleOutput?
    public var colorForView: UIColor? {
        didSet {
            moduleView.changeBackground(color: colorForView)
        }
    }
    
    // MARK: - Private property
    
    private let interactor: DetailScreenInteractorInput
    private let viewAssembly: () -> UIView & DetailScreenViewInput
    private lazy var moduleView: UIView & DetailScreenViewInput = viewAssembly()
    private let factory: DetailScreenFactoryInput
    
    /// Инициализатор
    /// - Parameters:
    ///   - interactor: интерактор
    ///   - viewAssembly: вью
    ///   - factory: фабрика
    init(interactor: DetailScreenInteractorInput,
         viewAssembly: @escaping () -> UIView & DetailScreenViewInput,
         factory: DetailScreenFactoryInput) {
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

extension DetailScreenViewController: DetailScreenInteractorOutput {
    func didReceive(text: String) {
        factory.createTitle(text: text, output: self)
    }
}

// MARK: - MainScreenViewOutput

extension DetailScreenViewController: DetailScreenViewOutput {
    func presentNewScreenButtonAction() {
        moduleOutput?.didCloseModule()
    }
}

// MARK: - MainScreenFactoryOutput

extension DetailScreenViewController: DetailScreenFactoryOutput {
    func didReciveFull(text: String) {
        moduleView.setTitle(text: text)
    }
}

// MARK: - Appearance

private extension DetailScreenViewController {
    struct Appearance {
        let title = "ROUTING to Coordinator"
    }
}
