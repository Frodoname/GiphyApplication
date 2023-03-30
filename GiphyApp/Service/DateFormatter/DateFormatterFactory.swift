//
//  DateFormatterFactory.swift
//  GiphyApp
//
//  Created by Fed on 28.03.2023.
//

import Foundation

final class DateFormatterFactory {
    
    static let dateFormatter: DateFormatter = makeFormatter(format: "yyyy-MM-dd HH:mm:ss")
    
    private static func makeFormatter(format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
