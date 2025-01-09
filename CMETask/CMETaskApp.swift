//
//  CMETaskApp.swift
//  CMETask
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI

@main
struct CMETaskApp: App {
    var body: some Scene {
        WindowGroup {
          let navigationController = UINavigationController()
          let coordinator = MainCoordinator(navigationController: navigationController)
          MainCoordinatorView(coordinator: coordinator)
        }
    }
}
