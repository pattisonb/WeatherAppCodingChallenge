//
//  ButtonWrapper.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//
import SwiftUI
import UIKit

struct SearchBarWrapper: UIViewRepresentable {
    typealias UIViewType = UISearchBar

    @Binding var searchText: String
    var onSearchButtonClicked: (() -> Void)?

    // Create and configure the UIKit view
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        return searchBar
    }

    // Update the view when SwiftUI updates
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }

    // Coordinator to handle UISearchBar interactions
    func makeCoordinator() -> Coordinator {
        Coordinator(searchText: $searchText, onSearchButtonClicked: onSearchButtonClicked)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var searchText: String
        var onSearchButtonClicked: (() -> Void)?

        init(searchText: Binding<String>, onSearchButtonClicked: (() -> Void)?) {
            _searchText = searchText
            self.onSearchButtonClicked = onSearchButtonClicked
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchText = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onSearchButtonClicked?()
        }
    }
}
