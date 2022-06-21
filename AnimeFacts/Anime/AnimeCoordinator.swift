//
//  AnimeCoordinator.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import UIKit

protocol AnimeCoordinating: AnyObject {
    func start()
    func goToAnimeFacts(path: String)
}

class AnimeCoordinator: AnimeCoordinating {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimeViewController") as? AnimeViewController else {
            return
        }
        vc.coordinator = self
        navigationController.viewControllers = [vc]
    }
    
    func goToAnimeFacts(path: String) {
        let animeFactsService = AnimeFactsService()
        let animeFactsCoordinator = AnimeFactsCoordinator(navigationController: navigationController)
        let animeFactsViewModel = AnimeFactsViewModel(
            animeFactsService: animeFactsService,
            coordinator: animeFactsCoordinator,
            path: path
        )
        guard let viewController = UIStoryboard(name: "AnimeFactsList", bundle: nil).instantiateViewController(withIdentifier: "AnimeFactsListViewController") as? AnimeFactsListViewController else {
            return
        }
        viewController.viewModel = animeFactsViewModel
        //let vc = AnimeFactsListViewController(viewModel: animeFactsViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
