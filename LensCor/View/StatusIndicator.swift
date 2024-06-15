//
//  StatusIndicator.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//

import SwiftUI

struct StatusIndicator: View {
    var status: TodoStatus

    var body: some View {
        let backgroundColor: Color = {
                        switch status {
                        case .completed:
                            return Color.green
                        case .pending:
                            return Color.red
                        }
                    }()

        Text(status == .completed ? "Completed" : "Pending")
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}
