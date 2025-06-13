// TabBarAppearanceModifier.swift
import SwiftUI

struct TabBarAppearanceModifier: ViewModifier {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // Set the background color with desired opacity (e.g., 85% opacity)
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        // Customize the appearance for selected and unselected items
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        
        // Remove the top border
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        // Apply the appearance to all UITabBar instances
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}
