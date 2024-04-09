//
//  TabBarVC.swift
//  SwiftProject
//
//  Created by Admin on 02/04/24.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a visual effect view with a blur effect
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
//
//        // Set the frame to half the height of the tab bar
//        visualEffectView.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: tabBar.bounds.height/2)
//
//        // Add the visual effect view to the tab bar
//        tabBar.addSubview(visualEffectView)
//
//        // Make the tab bar translucent
//        tabBar.isTranslucent = true
//
//        // Adjust the position of the tab bar items to be above the visual effect view
//        tabBar.items?.forEach { $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -visualEffectView.bounds.height) }
//        // Do any additional setup after loading the view.
        // Add gesture recognizer
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        guard let viewControllers = viewControllers else { return }
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.x > 0 { // Swiping right
                // Select previous tab
                let newIndex = max(selectedIndex - 1, 0)
                setSelectedIndex(index: newIndex)
            } else { // Swiping left
                // Select next tab
                let newIndex = min(selectedIndex + 1, viewControllers.count - 1)
                setSelectedIndex(index: newIndex)
            }
        }
    }
    
    func setSelectedIndex(index: Int) {
        selectedIndex = index
    }
}
