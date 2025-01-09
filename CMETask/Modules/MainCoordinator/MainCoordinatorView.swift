//
//  MainCoordinatorView.swift
//  CMETask
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI
import UIKit

struct MainCoordinatorView: UIViewControllerRepresentable {

  var coordinator: MainCoordinator

  func makeUIViewController(
    context: Context
  ) -> UINavigationController {
    let navigationController = UINavigationController()
    coordinator.navigationController = navigationController
    coordinator.start()
    return navigationController
  }

  func updateUIViewController(
    _ uiViewController: UINavigationController,
    context: Context
  ) {}
}

