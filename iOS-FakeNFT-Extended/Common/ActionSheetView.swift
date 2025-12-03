//
//  ActionSheetView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Alexander Agafonov on 03.12.2025.
//

import SwiftUI

// MARK: - Models

struct SortOption: Identifiable {
    let id = UUID()
    let title: String
    let action: () -> Void
}

struct SortSheetConfig {
    let title: String
    let options: [SortOption]
    let cancelTitle: String
}

// MARK: - View extension

extension View {
    func standardSortSheet(
        isPresented: Binding<Bool>,
        config: SortSheetConfig
    ) -> some View {
        confirmationDialog(
            config.title,
            isPresented: isPresented,
            titleVisibility: .visible
        ) {
            ForEach(config.options) { option in
                Button(option.title) {
                    option.action()
                }
            }

            Button(config.cancelTitle, role: .cancel) {
            }
        }
    }
}

// MARK: - Preview demo

private struct SortSheetDemoView: View {
    @State private var isSheetPresented = false

    var body: some View {
        let config = SortSheetConfig(
            title: "Сортировка",
            options: [
                SortOption(title: "По цене") {
                    print("Sort by price")
                },
                SortOption(title: "По рейтингу") {
                    print("Sort by rating")
                },
                SortOption(title: "По названию") {
                    print("Sort by name")
                }
            ],
            cancelTitle: "Закрыть"
        )

        return Button("sheet") {
            isSheetPresented = true
        }
        .standardSortSheet(isPresented: $isSheetPresented, config: config)
        .padding()
    }
}

#Preview {
    SortSheetDemoView()
}
