//
//  RMSettingView.swift
//  RAndM
//
//  Created by mac on 2024/7/31.
//

import SwiftUI

struct RMSettingView: View {
    private var viewModel: RMSettingsViewModel
    
    init(viewModel: RMSettingsViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            List(viewModel.cellViewModels) { viewModel in
                HStack {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.init(uiColor: viewModel.iconContainerColor))
                            .padding(.init(top: 4, leading: 4, bottom: 4, trailing: 10))
                    }
                    Text(viewModel.title)
                    Spacer()
                }
                .onTapGesture {
                    viewModel.onTapHander(viewModel.type)
                }
            }
            
            
        }
    }
}

#Preview {
    RMSettingView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellViewModel(type: $0) { _ in
            
        }
    })))
}
