//
//  UsersAssembly.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Swinject

class UsersAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NetworkAssistant.self) { _ in
            let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
            return NetworkAssistant(baseUrl: URL(string: baseUrl)!, executor: AlamofireRequestExecutor())
            
        }.inObjectScope(.container)
        
        container.register(UsersViewController.self) { resolver in
            let controller = UsersViewController.instantiate()
            controller.presenter = resolver.resolve(UsersPresenter.self, arguments: controller as UsersView, controller as UsersRouter)
            return controller
        }
        
        container.register(UsersService.self) { resolver in
            return resolver.resolve(NetworkAssistant.self)!
        }
        
        container.register(FetchUsersInteractor.self) { resolver in
            let interactor = FetchUsersInteractor()
            interactor.usersService = resolver.resolve(UsersService.self)
            return interactor
        }
        
        container.register(NumberOfRepositoriesInteractor.self) { resolver in
            let interactor = NumberOfRepositoriesInteractor()
            interactor.usersService = resolver.resolve(UsersService.self)
            return interactor
        }
        
        container.register(UsersPresenter.self) { (resolver, view: UsersView, router: UsersRouter) in
            let presenter = UsersPresenter(view: view, router: router)
            presenter.fetchUsersInteractor = resolver.resolve(FetchUsersInteractor.self)
            presenter.numberOfRepositoriesInteractor = resolver.resolve(NumberOfRepositoriesInteractor.self)
            return presenter
        }
    }
}
