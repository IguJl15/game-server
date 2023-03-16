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

interface IUserCredentials {
    userName: string;
    password: string;
}

interface IUserRegister {
    userName: string;
    password: string;
    confimedPassword: string;
}

export { 
    CreateGameParameters, 
    JoinGame, 
    MarkPosition, 
    CloseGame, 
    IUserCredentials, 
    IUserRegister
}