//
//  DiscoverSceneCoordinator.swift
//  TVPulse
//
//  Created by Maxime Maheo on 21/04/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit.UINavigationController
import SwiftUI
import Core
import TMDB
import TVShowDetail

public protocol DiscoverSceneCoordinatorDependencies: AnyObject {
    
    // MARK: - Properties
    
    var tmdbService: TMDBServiceProtocol { get }
    var tvShowDetailDIContainer: TVShowDetailSceneDIContainer { get }

}

public final class DiscoverSceneCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    public var parentCoordinator: CoordinatorProtocol?
    public var children: [CoordinatorProtocol] = []
    
    private let navigationController: UINavigationController
    private let dependencies: DiscoverSceneCoordinatorDependencies

    // MARK: - Lifecycle
    
    init(navigationController: UINavigationController,
         dependencies: DiscoverSceneCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    
    @MainActor
    public func start(params: Any...) {
        let viewModel = DiscoverSceneViewModel(tmdbService: dependencies.tmdbService)
        viewModel.coordinator = self
        
        let viewController = UIHostingController(rootView: DiscoverScene(viewModel: viewModel))
        viewController.title = "§Discover"
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([viewController],
                                                animated: false)
    }
    
    public func stop() { fatalError("Should not be stopped.") }
    
    @MainActor
    func pushTVShowDetails(tvShowId: Int) {
        dependencies
            .tvShowDetailDIContainer
            .makeCoordinator(navigationController: navigationController)
            .start(params: tvShowId)
    }
}
