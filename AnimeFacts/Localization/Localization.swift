//
//  Localization.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 22/06/2022.
//

import Foundation

enum URLString: String {
    case urlBase = "https://anime-facts-rest-api.herokuapp.com/api/v1/"
}

enum Identifier: String {
    case animeTableViewCell = "animeTableViewCell"
    case animeFactsTableViewCell = "animeFactsTableViewCell"
}

enum NavTitle: String {
    case animeFact = " Facts"
}

enum StoryBoardIdentifier: String {
    case mainName = "Main"
    case animeFactsListName = "AnimeFactsList"
}

enum ViewControllerIdentifier: String {
    case animeFactsListViewController = "AnimeFactsListViewController"
}
