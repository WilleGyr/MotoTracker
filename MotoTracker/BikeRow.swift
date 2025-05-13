import SwiftUI

struct BikeRow: View {
    let bike: Bike
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(bike.name)
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }

            if isExpanded {
                ForEach(bike.imageNames, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                }

                Text(bike.bikeDescription)
                    .font(.subheadline)
                    .padding(.top, 4)
            }
        }
        .padding(.vertical, 5)
    }
}
