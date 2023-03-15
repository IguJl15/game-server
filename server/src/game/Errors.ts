class AlreadyMarkedError extends Error {
    constructor() { super("Posição já preenchida") }
}

class BoardNotFoundError extends Error {
    constructor() { super("Jogo não encontrado") }
}

class FullBoardError extends Error {
    constructor() { super("Jogo cheio") }
}

class CanNotMarkPositionError extends Error {
    constructor() { super("Você não pode jogar nesse momento") }
}

class GameNotRunningError extends Error {
    constructor() { super("O jogo não está em execução no momento") }
}

class UnknownOperationError extends Error {
    constructor() { super("Operação não reconhecida") }
}

export {
    AlreadyMarkedError,
    BoardNotFoundError,
    CanNotMarkPositionError,
    FullBoardError,
    GameNotRunningError,
    UnknownOperationError,
}
