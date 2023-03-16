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
import { CloseGame, CreateGameParameters, IUserCredentials, IUserRegister, JoinGame, MarkPosition } from "./Mutations";
import LoginUserCommand from "../auth/commands/LoginUserCommand";
import UserRepository, { IUserRepository } from "../auth/repositories/UserRepositorie";
import RegisterUserCommand from "../auth/commands/RegisterUserCommand";

export default
    class Director {

    static playerNotifier: Notifier = new SocketNotifier();

    static boardRepository: BoardRepository = new ArrayBoardRepo();

    static userRepository: IUserRepository = new UserRepository();

    static getGameStateCommand = new GetGameStateCommand(this.boardRepository);
    static createGameCommand = new CreateGameCommand(this.boardRepository, this.getGameStateCommand);
    static joinGameCommand = new JoinGameCommand(this.getGameStateCommand, this.boardRepository, this.playerNotifier);
    static markPositionCommand = new MarkPositionCommand(this.boardRepository, this.getGameStateCommand, this.playerNotifier)
    static quitGameCommand = new QuitGameCommand(this.boardRepository, this.playerNotifier)
    static loginUserCommand = new LoginUserCommand(this.userRepository)
    static registerUserCommand = new RegisterUserCommand(this.userRepository)

    static direct(action: string, request: any) {
        let registerPlayer: string
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
            case "Register":
                return this.createUser(request["Register"] as IUserRegister)
            case "Login":
                return this.verifyUser(request["Login"] as IUserCredentials)
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

    static createUser(params:IUserRegister) {
        const createNewUser = this.registerUserCommand.execute(params)
        return {
            "User" : createNewUser
        }
    }

    static verifyUser(params: IUserCredentials) {
        const loggedUser = this.loginUserCommand.execute(params)
        return {
            "User" : loggedUser
        }
    }
}

