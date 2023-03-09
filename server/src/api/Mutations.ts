interface CreateGameParameters {
    symbol: 'X' | 'O'
    playerName?: String
}

interface JoinGame {
    playerName: string
    boardId: string
}

interface MarkPosition {
    playerId: string
    position: number
}