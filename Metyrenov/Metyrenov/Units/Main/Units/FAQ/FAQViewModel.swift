//
//  FAQViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import Foundation

extension FAQView {
    final class ViewModel: ObservableObject {
        let items: [Model] = [
            .init(
                title: "Pławna:",
                text: """
                Określ budżet: weź pod uwagę koszty materiałów, robocizny i możliwe nieprzewidziane wydatki.
                Stwórz szczegółowy plan pracy, uwzględniający terminy.
                """,
                imageName: Asset.faq1.name
            ),
            .init(
                title: "Wybór materiału:",
                text: """
                Zwróć uwagę na jakość materiałów: tańsze opcje mogą wiązać się z większymi kosztami w przyszłości.
                Weź pod uwagę styl i kolorystykę, które pasują do Twojego wnętrza.
                """,
                imageName: Asset.faq2.name
            ),
            .init(
                title: "Wybór wykonawców:",
                text: """
                Firmy badawcze: przeczytaj recenzje i poproś o rekomendacje.
                Podpisz umowę, aby uniknąć nieporozumień co do zakresu prac i terminów.
                """,
                imageName: Asset.faq3.name
            ),
            .init(
                title: "Kontrola procesu:",
                text: """
                Regularnie sprawdzaj postęp prac i zgodność z planem.
                Jeśli masz jakiekolwiek wątpliwości, nie wahaj się zadawać pytań wykonawcom.
                """,
                imageName: Asset.faq4.name
            ),
            .init(
                title: "Szczegóły końcowe:",
                text: """
                Nie zapomnij o oświetleniu: może ono znacząco zmienić wygląd pomieszczenia.
                Dodaj elementy dekoracyjne, aby nadać wnętrzu kompletny wygląd.
                """,
                imageName: Asset.faq5.name
            ),
            .init(
                title: "Regularne sprawdzanie statusu:",
                text: "Po zakończeniu naprawy należy sprawdzić różne elementy pod kątem zużycia i wykonać konserwację.",
                imageName: Asset.faq6.name
            ),
        ]
    }
}

extension FAQView {
    struct Model: Identifiable {
        private(set) var id = UUID().uuidString
        let title: String
        let text: String
        let imageName: String
    }
}
