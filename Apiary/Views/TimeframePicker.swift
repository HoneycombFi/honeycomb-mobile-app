import SwiftUI

struct TimeframePicker: View {
    @State private var selectedTimeframe = "1D"
    
    let timeframes = ["1D", "1W", "1M", "YTD", "1Y", "ALL"]

    var body: some View {
          GeometryReader { geometry in
              let itemWidth = (geometry.size.width - CGFloat(timeframes.count - 1) * 10) / CGFloat(timeframes.count) / 2
              HStack(alignment: .center, spacing: 10) {
                  ForEach(timeframes, id: \.self) { timeframe in
                      Text(timeframe)
                          .font(.system(size: 12).bold())
                          .frame(width: itemWidth) // Fixed width for each item as a percentage of screen width
                          .padding(.vertical, 8)
                          .padding(.horizontal, 12)
                          .background(Color.gray12)
                          .foregroundColor(selectedTimeframe == timeframe ? Color.yellow5 : Color.white)
                          .cornerRadius(15)
                          .overlay(
                              RoundedRectangle(cornerRadius: 15)
                                  .stroke(selectedTimeframe == timeframe ? Color.yellow5 : Color.gray12, lineWidth: 2)
                          )
                          .onTapGesture {
                              selectedTimeframe = timeframe
                          }
                  }
              }
              .frame(maxWidth: .infinity)
          }
          .frame(height: 20)
      }
  }
