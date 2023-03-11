interface CreateGameParameters {
    symbol: 'X' | 'O'
    playerName?: String
}

interface JoinGame {
    playerName: string
    boardId: string
}

interface MarkPosition {
    boardId: string
    playerId: string
    position: number
}

export { CreateGameParameters, JoinGame, MarkPosition, CloseGame }