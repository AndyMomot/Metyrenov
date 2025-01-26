//
//  ProjectsChart.swift

import SwiftUI
import Charts

struct ProjectsChart: View {
    let projects: [Project]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Statystyka")
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .semibold))
            
            HStack(alignment: .top) {
                Chart {
                    ForEach(projects) { project in
                        BarMark(
                            x: .value("1", project.name),
                            y: .value("2", project.budget)
                        )
                        .foregroundStyle(.skywave)
                        .cornerRadius(30)
                    }
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            Text("\(value.as(String.self) ?? "")")
                                .foregroundColor(.white)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 10))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisValueLabel {
                            Text("\(value.as(Int.self) ?? 0)")
                                .foregroundColor(.white)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 10))
                        }
                    }
                }
                .shadowModifier()
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(projects) { project in
                        ChartRow(text: project.date.toString(format: .ddMMyyyy))
                    }
                }
            }
        }
        .padding()
        .background(Color.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        ProjectsChart(projects: [
            .init(
                name: "First",
                date: .init(),
                address: "",
                description: "",
                budget: 100
            ),
            
                .init(
                    name: "Second",
                    date: .init(),
                    address: "",
                    description: "",
                    budget: 150
                ),
            .init(
                name: "Third",
                date: .init(),
                address: "",
                description: "",
                budget: 50
            ),
        ])
            .frame(maxHeight: 260)
        .padding()
    }
}
