import { JoinGame } from "../../api/Mutations";
import { BoardNotFoundError, FullBoardError } from "../Errors";
import { Board } from "../entities/Board";
import Player from "../entities/Player";
import { BoardRepository } from "../repositories/BoardRepository";
import Notifier from "../utils/Notifier";
import Utils from "../utils/Utils";
import GetGameStateCommand from "./GetGameStateCommand";

export default
    class JoinGameCommand {
    constructor(
        private getBoardCommand: GetGameStateCommand,
        private repository: BoardRepository,
        private playerNotifier: Notifier,
    ) { }

    execute(params: JoinGame): Board {
        let board = this.repository.getBoard(params.boardId)

        if (board == null) throw new BoardNotFoundError();

        if (board.player2) throw new FullBoardError();

        const player2Symbol = board.player1.value == "X" ? "O" : "X";

        board.player2 = new Player(
            Utils.generateId(),
            params.playerName,
            player2Symbol
        )
        board.status = "in game"

        this.repository.saveBoard(board);

        const opponent = board.player1
        const boardFromOpponentReference = this.getBoardCommand.execute({ boardId: board.boardId, playerId: opponent.id! })
        this.playerNotifier.notifyGameState(boardFromOpponentReference, board.player1.id!)

        return this.getBoardCommand.execute({ boardId: board.boardId, playerId: board.player2.id! });
    }
}