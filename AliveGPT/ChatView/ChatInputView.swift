//
//  ChatInputView.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import SwiftUI

struct ChatInputView: View {
    @Bindable var viewModel: ChatViewModel
    
    var body: some View {
        // Combined selected images
        let allImages: [Image] = viewModel.selectedUIImages.map { Image(uiImage: $0) } + viewModel.loadedSelectedPhotos
        if !allImages.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(allImages.prefix(5).enumerated()), id: \.offset) { index, image in
                        let size = viewModel.imagePreviewSize(for: allImages.count)
                        ZStack(alignment: .topTrailing) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: size, height: size)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.13), lineWidth: 0.8)
                                )
                            Button(action: { viewModel.removeAttachment(at: index) }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(.black, lineWidth: 1.5)
                                    }
                                    .padding([.top, .trailing], 4)
                            }
                        }
                    }
                }
                .animation(.default, value: allImages)
                .padding(.bottom, 2)
            }
        }
        
        // Show selected documents (file preview cards)
        if !viewModel.selectedDocumentURLs.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(viewModel.selectedDocumentURLs.prefix(5).enumerated()), id: \.offset) { index, url in
                        ZStack(alignment: .topTrailing) {
                            HStack(spacing: 6) {
                                Image(systemName: "doc.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.purple)
                                Text(url.lastPathComponent)
                                    .font(.caption2)
                                    .foregroundColor(.black.opacity(0.8))
                                    .lineLimit(1)
                                    .frame(width: 62)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray.opacity(0.10))
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black.opacity(0.13), lineWidth: 0.8)
                            }
                            
                            Button(action: { viewModel.removeAttachment(at: index) }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(.black, lineWidth: 1.5)
                                    }
                                    .padding([.top, .trailing], 4)
                            }
                        }
                    }
                }
                .animation(.default, value: viewModel.selectedDocumentURLs)
                .padding(.bottom, 2)
            }
        }
        // Text field and buttons (updated TextEditor with dynamic height)
        ZStack(alignment: .leading) {
            TextEditor(text: $viewModel.newMessageText)
                .frame(minHeight: viewModel.textEditorMinHeight, maxHeight: max(viewModel.textEditorMinHeight, min(viewModel.textEditorHeight, viewModel.textEditorMaxHeight)))
                .scrollContentBackground(.hidden)
                .background(.white)
                .foregroundStyle(.black)
                .fontWeight(.light)
                .onChange(of: viewModel.newMessageText) { _ in
                    viewModel.recalculateTextEditorHeight()
                }
            if viewModel.newMessageText.isEmpty {
                Text("Type message here...")
                    .fontWeight(.light)
                    .foregroundStyle(.black.opacity(0.6))
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 2)
        .onAppear { viewModel.recalculateTextEditorHeight() }
        .animation(.easeInOut, value: viewModel.textEditorHeight)
    }
}

#Preview {
    ChatInputView(viewModel: ChatViewModel())
}
