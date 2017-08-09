//
//  RepositoriesAssembly.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Swinject

class RepositoriesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(RepositoriesViewController.self) { (resolver, user: User) in
            let controller = RepositoriesViewController.instantiate()
            controller.presenter = resolver.resolve(RepositoriesPresenter.self, arguments: controller as RepositoriesView, user)
            return controller
        }
        
        container.register(RepositoriesPresenter.self) { (resolver, view: RepositoriesView, user: User) in
            let presenter = RepositoriesPresenter(view: view, user: user)
            presenter.fetchRepositoriesInteractor = resolver.resolve(FetchRepositoriesInteractor.self)
            return presenter
        }
        
        container.register(RepositoriesService.self) { resolver in
            return resolver.resolve(NetworkAssistant.self)!
        }
        
        container.register(FetchRepositoriesInteractor.self) { resolver in
            let interactor = FetchRepositoriesInteractor()
            interactor.repositoriesService = resolver.resolve(RepositoriesService.self)
            return interactor
        }
    }
}
