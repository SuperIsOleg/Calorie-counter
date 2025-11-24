import SwiftUI
import PhotosUI

struct ImageCardView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var showGalleryPickerSheet: Bool = false
    @State private var imageData: Data?
    
    private let onImageSelected: (Data?) -> Void
    
    init(
        imageData: Data?,
        onImageSelected: @escaping (Data?) -> Void
    ) {
        self.imageData = imageData
        self.onImageSelected = onImageSelected
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .clipped()
                    .animation(.default, value: imageData)
            } else {
                Circle()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 150)
            }
            
            Button {
                hideKeyboard()
                showGalleryPickerSheet = true
            } label: {
                Circle()
                    .fill(.blue)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: imageData == nil ? "plus" : "pencil")
                            .foregroundColor(.white)
                    }
            }

        }
        .photosPicker(
            isPresented: $showGalleryPickerSheet,
            selection: $photoItem,
            matching: .images
        )
        .onChange(of: photoItem, { _, newValue in
            guard let item = newValue else { return }
            
            Task { @MainActor in
                if let data = try await item.loadTransferable(type: Data.self) {
                    self.imageData = data
                    self.onImageSelected(data)
                }
            }
        })
    }
}

#Preview {
    ImageCardView(imageData: nil, onImageSelected: {_ in})
}
