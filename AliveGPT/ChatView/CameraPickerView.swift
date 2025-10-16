import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct CameraPickerView: View {
    @State private var showPhotoLibrary = false
    @State private var showCamera = false
    @State private var showDocumentPicker = false
    @Binding var selectedPhotos: [PhotosPickerItem]
    @Binding var selectedUIImages: [UIImage]
    @Binding var selectedDocumentURLs: [URL]
    var onSelect: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            // Photo Library
            CameraPickerRow(title: "Photo Library", systemImage: "photo.on.rectangle") {
                showPhotoLibrary = true
            }
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(height: 0.5)
            
            // Take Photo or Video
            CameraPickerRow(title: "Take Photo or Video", systemImage: "camera") {
                showCamera = true
            }
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(height: 0.5)
            // Choose Files
            CameraPickerRow(title: "Choose Files", systemImage: "folder") {
                showDocumentPicker = true
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.black.opacity(0.8))
        )
        .frame(width: 260)
        // Photo Library Picker
        .photosPicker(isPresented: $showPhotoLibrary, selection: $selectedPhotos, matching: .images)
        // Camera Picker as a Sheet
        .fullScreenCover(isPresented: $showCamera) {
            CameraSheet(images: $selectedUIImages).ignoresSafeArea()
        }
        // Document Picker
        .fullScreenCover(isPresented: $showDocumentPicker) {
            DocumentPicker(documentURLs: $selectedDocumentURLs).ignoresSafeArea()
        }
        .onChange(of: selectedPhotos, initial: false) { _, newValue in
            if !newValue.isEmpty {
                onSelect()
            }
        }
        .onChange(of: selectedUIImages, initial: false) { _, newValue in
            if !newValue.isEmpty {
                onSelect()
            }
        }
        .onChange(of: selectedDocumentURLs, initial: false) { _, newValue in
            if !newValue.isEmpty {
                onSelect()
            }
        }
    }
}

struct CameraPickerRow: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var selectedPhoto: [PhotosPickerItem] = []
    @Previewable @State var selectedUIImage: [UIImage] = []
    @Previewable @State var selectedDocumentURL: [URL] = []

    CameraPickerView(selectedPhotos: $selectedPhoto, selectedUIImages: $selectedUIImage, selectedDocumentURLs: $selectedDocumentURL)
}
