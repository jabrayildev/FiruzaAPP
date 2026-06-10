import SwiftUI

struct HistoryView: View {
    
    let sessions: [FastingSession]
    
    var body: some View {
        
        ZStack {
            
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                Text("История")
                    .font(AppFonts.largeTitle())
                    .foregroundColor(AppColors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                // Карточка аналитики
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Записи голодания")
                        .font(AppFonts.cardTitle())
                        .foregroundColor(AppColors.textPrimary)
                    
                    if sessions.isEmpty {
                        
                        Text("Пока нет данных")
                            .foregroundColor(AppColors.textPrimary)
                            .frame(maxWidth: .infinity, minHeight: 120)
                        
                    } else {
                        
                        HistoryChartView(sessions: sessions)
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(AppColors.background2)
                .cornerRadius(24)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                
                // Список истории
                List {
                    ForEach(sessions.reversed()) { session in
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(session.startDate.formatted())
                                    .foregroundColor(AppColors.textPrimary)
                                
                                Text(session.endDate.formatted())
                                    .foregroundColor(AppColors.textPrimary)
                            }
                            
                            Spacer()
                            
                            Text("\(session.percent)%")
                                .foregroundColor(
                                    session.percent < 50 ? .red : .green
                                )
                                .bold()
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                
            }
        }
    }
}
