import SwiftUI

struct PerformanceChartView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let points = [
                    CGPoint(x: 0, y: height * 0.8),
                    CGPoint(x: width * 0.2, y: height * 0.6),
                    CGPoint(x: width * 0.4, y: height * 0.7),
                    CGPoint(x: width * 0.6, y: height * 0.5),
                    CGPoint(x: width * 0.8, y: height * 0.3),
                    CGPoint(x: width, y: height * 0.2)
                ]
                
                path.move(to: points[0])
                
                for i in 1..<points.count {
                    path.addLine(to: points[i])
                }
            }
            .stroke(Color.purple, lineWidth: 3)
        }
        .padding(.horizontal)
    }
}
