interface CreateGameParameters {
    symbol: 'X' | 'O'
    sessionId: string
}

interface JoinGame {
    sessionId: string
    boardId: string
}

interface MarkPosition {
    boardId: string
    sessionId: string
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