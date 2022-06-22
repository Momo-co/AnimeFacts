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
        let mainName = StoryBoardIdentifier.mainName.rawValue
        guard let vc = UIStoryboard(name: mainName, bundle: nil).instantiateViewController(withIdentifier: "AnimeViewController") as? AnimeViewController else {
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
        let viewControllerIdentifer = ViewControllerIdentifier.animeFactsListViewController.rawValue
        let animeFactsListName = StoryBoardIdentifier.animeFactsListName.rawValue
        guard let viewController = UIStoryboard(name: animeFactsListName, bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifer) as? AnimeFactsListViewController else {
            return
        }
        viewController.viewModel = animeFactsViewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
