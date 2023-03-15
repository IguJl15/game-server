interface CreateGameParameters {
    symbol: 'X' | 'O'
    playerName: string
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

interface CloseGame {
    boardId?: string
    playerId: string
}

export { CreateGameParameters, JoinGame, MarkPosition, CloseGame }