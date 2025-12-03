//
//  AlertView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Alexander Agafonov on 03.12.2025.
//

import SwiftUI

// MARK: - Models

struct StandardAlertButton: Identifiable {
    let id = UUID()
    let title: String
    let role: ButtonRole?
    let action: () -> Void
}

struct StandardAlertConfig {
    let title: String
    let message: String?
    let buttons: [StandardAlertButton]
}

// MARK: - View extension

extension View {
    func standardAlert(
        isPresented: Binding<Bool>,
        config: StandardAlertConfig
    ) -> some View {
        alert(
            config.title,
            isPresented: isPresented
        ) {
            ForEach(config.buttons) { button in
                Button(button.title, role: button.role) {
                    button.action()
                }
            }
        } message: {
            if let message = config.message {
                Text(message)
            }
        }
    }
}

// MARK: - Preview demo

private struct AlertDemoView: View {
    @State private var isAlertPresented = false

    var body: some View {
        let alertConfig = StandardAlertConfig(
            title: "Не удалось произвести оплату",
            message: nil,
            buttons: [
                StandardAlertButton(
                    title: "Отмена",
                    role: .cancel,
                    action: { print("Cancel tapped") }
                ),
                StandardAlertButton(
                    title: "Повторить",
                    role: nil,
                    action: { print("Retry tapped") }
                )
            ]
        )

        return Button("alert") {
            isAlertPresented = true
        }
        .standardAlert(isPresented: $isAlertPresented, config: alertConfig)
        .padding()
    }
}

#Preview {
    AlertDemoView()
}
