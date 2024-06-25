//
//  Haptic.swift
//  crAion Onboarding
//
//  Created by Juanjo Valiño on 25/6/24.
//

import UIKit

class Haptic {
    static let shared = Haptic()

    private let lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    private let mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let notificationGenerator = UINotificationFeedbackGenerator()

    private init() {}

    func lightImpact() {
        lightImpactGenerator.impactOccurred()
    }

    func mediumImpact() {
        mediumImpactGenerator.impactOccurred()
    }

    func heavyImpact() {
        heavyImpactGenerator.impactOccurred()
    }

    func selectionChanged() {
        selectionGenerator.selectionChanged()
    }

    func notificationOccurred(type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(type)
    }
}
