import Foundation

// MARK: - Protocol

@MainActor
protocol NftDetailPresenter {
    func viewDidLoad()
}

// MARK: - State

enum NftDetailState {
    case initial, loading, failed(Error), data(Nft)
}

final class NftDetailPresenterImpl: NftDetailPresenter {

    // MARK: - Properties

    weak var view: NftDetailView?
    private let input: NftDetailInput
    private let service: NftService
    private var state = NftDetailState.initial {
        didSet {
            Task {
                await stateDidChange()
            }
        }
    }

    // MARK: - Init

    init(input: NftDetailInput, service: NftService) {
        self.input = input
        self.service = service
    }

    // MARK: - Functions

    func viewDidLoad() {
        state = .loading
    }

    private func stateDidChange() async {
        switch state {
            case .initial:
                assertionFailure("can't move to initial state")
            case .loading:
                view?.showLoading()
                await loadNft()
            case .data(let nft):
                view?.hideLoading()
                let cellModels = nft.images.map { NftDetailCellModel(url: $0) }
                view?.displayCells(cellModels)
            case .failed(let error):
                let errorModel = makeErrorModel(error)
                view?.hideLoading()
                view?.showError(errorModel)
        }
    }

    private func loadNft() async {
        do {
            let nft = try await service.loadNft(id: input.id)
            state = .data(nft)
        } catch {
            state = .failed(error)
        }
    }

    private func makeErrorModel(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
            case is NetworkClientError:
                message = NSLocalizedString("Error.network", comment: "")
            default:
                message = NSLocalizedString("Error.unknown", comment: "")
        }

        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loading
        }
    }
}
