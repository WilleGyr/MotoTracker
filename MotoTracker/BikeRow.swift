import SwiftUI

struct BikeRow: View {
    let bike: Bike
    @Binding var isSeen: Bool
    @State private var showingDetails = false
    @EnvironmentObject var bikeData: BikeDataManager
    
    var body: some View {
        HStack {
            Button {
                isSeen.toggle()
                bikeData.save() // ✅ Save when toggled
            } label: {
                Image(systemName: isSeen ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSeen ? .blue : .gray)
            }
            .buttonStyle(.plain)
            
            Text(bike.name)
                .font(.headline)
            
            Spacer()
            
            Button {
                showingDetails.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $showingDetails) {
            BikeDetailsView(bike: bike)
        }
    }
}


// Preview for the details view
struct BikeDetailsView: View {
    let bike: Bike
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Bike name (centered)
                Text(bike.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                // Centered multi-line description
                Text(bike.bikeDescription)
                    .font(.body)
                    .multilineTextAlignment(.center) // Center-align text
                    .frame(maxWidth: .infinity) // Full width for centering
                    .padding(.horizontal)
                
                Spacer()
                
                // Images at bottom
                VStack(spacing: 0) {
                    ForEach(bike.imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity) // Ensure VStack uses full width
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(bike.name)
    }
}
