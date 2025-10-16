//
//  SettingsView.swift
//  AliveGPT
//
//  Created by William Lopez on 10/15/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var personalizationEnabled = false
    @State private var showPrivacyPolicy = false
    @State private var showTermsOfUse = false
    @State private var showExportDataAlert = false
    
    var body: some View {
        VStack {
            header.padding(.bottom, 18)
            VStack(alignment: .leading, spacing: 35) {
                dataAndPrivacy
                policiesAndLegal
                Spacer()
            }
        }
        .overlay {
            if showExportDataAlert {
                exportDataAlert
            }
        }
        .animation(.snappy, value: showExportDataAlert)
        .padding(.horizontal, 15)
        .background(.aliveGPTBG)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showPrivacyPolicy) {
            NavigationStack {
                ScrollView {
                    Text("Privacy Policy content here...")
                        .padding()
                }
                .navigationTitle("Privacy Policy")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            showPrivacyPolicy = false
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showTermsOfUse) {
            NavigationStack {
                ScrollView {
                    Text("Terms of Use content here...")
                        .padding()
                }
                .navigationTitle("Terms of Use")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            showTermsOfUse = false
                        }
                    }
                }
            }
        }
        
    }
    
    private var header: some View {
        HStack(alignment: .center) {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 2) {
                    Image(systemName: "chevron.left")
                    Text("AliveGPT").font(.caption)
                }
            }
            Spacer()
        }
        .foregroundStyle(.black)
        .overlay {
            Text("Settings")
                .font(.system(.title3, weight: .bold))
                .foregroundStyle(.black)
        }
    }
    
    private var dataAndPrivacy: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Data & Privacy")
                .font(.system(.caption, weight: .medium))
                .foregroundStyle(.black)
                .padding(.leading, 15)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Personalization")
                        .font(.system(.caption2, weight: .medium))
                        .foregroundStyle(.black)
                    Text("Use my on platform data for higher quality and personalised responses")
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black.opacity(0.6))
                    
                }.layoutPriority(1)
                
                Toggle("", isOn: $personalizationEnabled)
                    .tint(.purple3)
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
            }
            
            HStack {
                Text("Export data")
                    .font(.system(.caption2, weight: .medium))
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    showExportDataAlert = true
                }) {
                    Text("Export data")
                        .font(.system(.caption2, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(6)
                        .background {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.white)
                                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                        }
                }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
            }
        }
    }
    
    private var policiesAndLegal: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Policies & Legal")
                .font(.system(.caption, weight: .medium))
                .foregroundStyle(.black)
                .padding(.leading, 15)
            
            VStack(spacing: 20) {
                Button(action: {
                    showPrivacyPolicy = true
                }) {
                    HStack {
                        Text("Privacy Policy")
                            .font(.system(.caption2, weight: .medium))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(.caption, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                Button(action: {
                    showTermsOfUse = true
                }) {
                    HStack {
                        Text("Terms of Use")
                            .font(.system(.caption2, weight: .medium))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(.caption, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay {
                Rectangle()
                    .fill(.black.opacity(0.3))
                    .frame(height: 0.4)
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
            }
            .padding(.bottom, 5)
            
            Text("Visit account settings in Profile to see all of our policies")
                .font(.system(.caption, weight: .light))
                .foregroundStyle(.black.opacity(0.6))
                .frame(maxWidth: .infinity)
        }
    }
    
    private var exportDataAlert: some View {
        VStack {
            Text("Request data export - are you sure?")
                .font(.system(.subheadline, weight: .medium))
                .foregroundStyle(.black)
                .padding(.bottom, 2)
            VStack(alignment: .leading) {
                Text("• Your account details and chats will be included in the export.")
                Text("• The data will be sent to your registered email in a downloadable file.")
                Text("• The download link will expire 24 hours after you receive it.")
                Text("• Processing may take some time. You’ll be notified when its ready.")
            }
            .font(.system(.caption, weight: .light))
            .foregroundStyle(.black.opacity(0.6))
            .padding(.bottom, 10)
            Text("To proceed, click “Confirm export” below.")
                .font(.system(.caption, weight: .light))
                .foregroundStyle(.black.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 25)
            Button(action: {
                showExportDataAlert = false
            }) {
                Text("Confirm export")
                    .foregroundStyle(.white)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.black)
                    }
            }
            .padding(.bottom, 6)
            Button(action: {
                showExportDataAlert = false
            }) {
                Text("Cancel")
                    .foregroundStyle(.black)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.purple6, lineWidth: 1)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 50, leading: 35, bottom: 15, trailing: 35))
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.offWhite)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                .shadow(color: .black.opacity(0.15), radius: 1)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}


