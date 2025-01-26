//
//  ProfileViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import Foundation
import UIKit.UIImage

extension ProfileView {
    final class ViewModel: ObservableObject {
        @Published var image = UIImage()
        @Published var showImagePiker = false
        @Published var user: User?
        @Published var userName = "" {
            didSet { performSaveWithDelay() }
        }
        
        let appStoreURL = URL(string: "https://www.apple.com")
        let supportURL = URL(string: "https://google.com")
        
        @Published var showSupport = false
        @Published var showAlert = false
        
        private var saveNameTask: Task<Void, Never>?
    }
}

extension ProfileView.ViewModel {
    func getUser() {
        Task { [weak self] in
            guard let self else { return}
            let user = DefaultsService.shared.user
            if let id = user?.id {
                self.fetchUserImage(for: id)
            }
            
            await MainActor.run {
                self.userName = user?.name ?? ""
            }
        }
    }
    
    func fetchUserImage(for userId: String) {
        Task { [weak self] in
            guard let self else { return}
            
            if let imageData = await FileManagerService().fetchImage(with: userId),
                let uiImage = UIImage(data: imageData) {
                await MainActor.run {
                    self.image = uiImage
                }
            }
        }
    }
    
    func saveUserImage() {
        Task { [weak self] in
            guard let self else { return}
            guard let userId = self.user?.id,
                  self.image != UIImage(),
                  let imageData = self.image.jpegData(compressionQuality: 1)
            else { return }
            
            FileManagerService().saveImage(data: imageData, for: userId)
        }
    }
    
    func removeData() {
        Task {
            DefaultsService.shared.removeAll()
            FileManagerService().removeAllFiles()
        }
    }
}

private extension ProfileView.ViewModel {
    private func performSaveWithDelay() {
        // Скасовуємо попередню задачу, якщо вона ще виконується
        saveNameTask?.cancel()
        
        // Запускаємо нову задачу
        saveNameTask = Task { [weak self] in
            guard let self else { return }
            try? await Task.sleep(nanoseconds: 1_000_000_000) // Затримка 1 сек
            
            guard !Task.isCancelled else { return } // Перевірка на скасування
            
            Task {
                DefaultsService.shared.user?.name = self.userName
            }
        }
    }
}
