//
//  AnnotationViewFactory.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 10/11/24.
//

import SwiftUI

enum AnnotationType {
    case danger, traffic, rating
}

struct AnnotationViewFactory {
    static func makeView(for type: AnnotationType) -> some View {
        switch type {
        case .danger:
            return AnyView(
                Circle()
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 20, height: 20)
            )
        case .traffic:
            return AnyView(
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
            )
        case .rating:
            return AnyView(
                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 10, height: 10)
            )
        }
    }
}
