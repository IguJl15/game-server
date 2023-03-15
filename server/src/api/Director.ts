import SocketServer from "..";
import { UnknownOperationError } from "../game/Errors";
import CreateGameCommand from "../game/commands/CreateGameCommand";
import GetGameStateCommand from "../game/commands/GetGameStateCommand";
import JoinGameCommand from "../game/commands/JoinGameCommand";
import MarkPositionCommand from "../game/commands/MarkSquareCommand";
import QuitGameCommand from "../game/commands/QuitGameCommand";
import { Board } from "../game/entities/Board";
import ArrayBoardRepo, { BoardRepository } from "../game/repositories/BoardRepository";
import Notifier, { SocketNotifier } from "../game/utils/Notifier";
import { CloseGame, CreateGameParameters, JoinGame, MarkPosition } from "./Mutations";

export default
    class Director {

    static playerNotifier: Notifier = new SocketNotifier();

    static boardRepository: BoardRepository = new ArrayBoardRepo();

    static getGameStateCommand = new GetGameStateCommand(this.boardRepository);
    static createGameCommand = new CreateGameCommand(this.boardRepository, this.getGameStateCommand);
    static joinGameCommand = new JoinGameCommand(this.getGameStateCommand, this.boardRepository, this.playerNotifier);
    static markPositionCommand = new MarkPositionCommand(this.boardRepository, this.getGameStateCommand, this.playerNotifier)
    static quitGameCommand = new QuitGameCommand(this.boardRepository, this.playerNotifier)

    static direct(action: string, request: any) {
        let requestPlayerId: string
        let gameState: { GameState: Board } | null

        switch (action) {
            case "CreateGame":
                gameState = this.createGame(request["CreateGame"] as CreateGameParameters);
                requestPlayerId = gameState.GameState.player1.id!;
                break;
            case "JoinGame":
                gameState = this.joinGame(request["JoinGame"] as JoinGame);
                requestPlayerId = gameState.GameState.player2.id!;
                break;
            case "MarkPosition":
                requestPlayerId = (request["MarkPosition"] as MarkPosition).playerId
                gameState = this.markPosition(request["MarkPosition"] as MarkPosition);
                break;
            case "CloseGame":
                this.closeGame(request as CloseGame);
                return
            default:
                throw new UnknownOperationError();
        }

        if (gameState != null) {
            SocketServer.activeConnections.set(requestPlayerId, SocketServer.currentConnection!);
        }

        return gameState;
    }

    static createGame(params: CreateGameParameters) {
        const newBoard = this.createGameCommand.execute(params);

        return {
            "GameState": newBoard
        }
    }

    static joinGame(params: JoinGame) {
        const updatedBoard = this.joinGameCommand.execute(params);

        const gameState = {
            "GameState": updatedBoard
        }

        return gameState
    }

    static markPosition(params: MarkPosition) {
        const updatedBoard = this.markPositionCommand.execute(params)

        const gameState = {
            "GameState": updatedBoard
        }

        return gameState
    }
    
    static closeGame(params: CloseGame) {
        this.quitGameCommand.execute(params)
    }
}

