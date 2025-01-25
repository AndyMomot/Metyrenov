//
//  AddTeamMemberViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import Foundation
import UIKit.UIImage

extension AddTeamMemberView {
    final class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var phone = ""
        @Published var email = ""
        @Published var image = UIImage()
        
        @Published var showImagePicker = false
    }
}
