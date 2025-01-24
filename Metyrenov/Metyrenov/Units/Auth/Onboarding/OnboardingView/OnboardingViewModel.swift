//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showRegistration = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Aplikacja remontowa pozwala zaplanować prace, określić materiały i obliczyć budżet. Pomaga to skutecznie kontrolować każdy etap procesu renowacji."
            case .second:
                return "Pozwala śledzić postępy zadań, rejestrować koszty i porównywać je z zaplanowanym budżetem. Zalecenia dotyczące wyboru materiałów i optymalizacji kosztów pomagają osiągnąć lepsze wyniki."
            case .third:
                return "Używaj narzędzi i materiałów bezpiecznie i zgodnie z instrukcjami. Intuicyjny interfejs ułatwia organizację napraw i tworzenie stylowych wnętrz."
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .first, .second:
                return "Dalej"
            case .third:
                return "Rozpocznij"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var lastIndex: Int {
            OnboardingItem.allCases.last?.rawValue ?? .zero
        }
        
        var progress: Double {
            Double(rawValue + 1) / Double(lastIndex + 1)
        }
    }
}
