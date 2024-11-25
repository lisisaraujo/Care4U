//
//  SelectLocationView.swift
//  Care4U
//
//  Created by Lisis Ruschel on 07.11.24.
//

import SwiftUI
import CoreLocation
import GooglePlaces

import SwiftUI
import CoreLocation
import GooglePlaces

struct SelectLocationView: View {
    @Binding var selectedLocation: String
    @Binding var selectedCoordinates: CLLocationCoordinate2D?
    @Binding var isAutocompletePresented: Bool
    @State private var showLocationDetails = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Location")
                .font(.headline)
                .foregroundColor(.primary)

            Button(action: {
                isAutocompletePresented.toggle()
            }) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.blue)
                    Text(selectedLocation.isEmpty ? "Select Location" : selectedLocation)
                        .foregroundColor(selectedLocation.isEmpty ? .secondary : .primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                )
            }
            .sheet(isPresented: $isAutocompletePresented) {
                            AutocompleteControllerView(location: $selectedLocation, selectedCoordinates: $selectedCoordinates)
            }
        }
        .padding()
        .sheet(isPresented: $showLocationDetails) {
            LocationDetailsView(location: selectedLocation, coordinates: selectedCoordinates)
        }
    }
}

struct LocationDetailsView: View {
    let location: String
    let coordinates: CLLocationCoordinate2D?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Location Details")
                .font(.title)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 8) {
                Text("Address:")
                    .font(.headline)
                Text(location)
                    .font(.subheadline)
            }

            if let coordinates = coordinates {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Coordinates:")
                        .font(.headline)
                    Text("Latitude: \(coordinates.latitude)")
                        .font(.subheadline)
                    Text("Longitude: \(coordinates.longitude)")
                        .font(.subheadline)
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SelectLocationView(selectedLocation: .constant("Berlin"), selectedCoordinates: .constant(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)), isAutocompletePresented: .constant(false))
        .environmentObject(PostsViewModel())
        .environmentObject(AuthViewModel())
}
