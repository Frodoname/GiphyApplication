//
//  DtoService.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

final class DtoService {
    
    func transform(from dtoModel: GiphyModelDto) -> GIFModel {
        var gif: [GIF] = []
        
        for model in dtoModel.data {
            gif.append(transformGifFromDto(model))
        }
        
        let gifModel = GIFModel(gif: gif, totalCount: dtoModel.pagination?.totalCount)
        
        return gifModel
    }
    
    private func transformGifFromDto(_ model: GIFDto) -> GIF {
        let gif = GIF(
            userName: model.userName,
            title: model.title,
            importDateTime: model.importDateTime,
            downSizedImage: model.images.downsized.url,
            originalImage: model.images.original.url)
        return gif
    }
}
