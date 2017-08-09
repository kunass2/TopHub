//
//  DependencyAssistant.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import Swinject

class DependencyAssistant {
    
    static let shared = DependencyAssistant()
    
    static var resolver: Resolver {
        return shared.resolver
    }
    
    private lazy var assembler: Assembler = {
        return Assembler([
            UsersAssembly(),
            RepositoriesAssembly()
            ])
    }()
    
    var resolver: Resolver {
        return assembler.resolver
    }
}
