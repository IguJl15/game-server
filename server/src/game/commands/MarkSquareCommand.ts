import { MarkPosition } from "../../api/Mutations";
import { BoardNotFoundError, CanNotMarkPositionError, GameNotRunningError } from "../Errors";
import { Board } from "../entities/Board";
import { BoardRepository } from "../repositories/BoardRepository";
import Notifier from "../utils/Notifier";
import GetGameStateCommand from "./GetGameStateCommand";

export default
    class MarkPositionCommand {
    constructor(
        private repository: BoardRepository,
        private getBoardCommand: GetGameStateCommand,
        private playerNotifier: Notifier,
    ) { }

    execute(params: MarkPosition): Board {
        let board = this.repository.getBoard(params.boardId);

        console.log(params);

        if (board == null) throw new BoardNotFoundError();
        if (board.status != "in game") throw new GameNotRunningError();
        if (params.playerId != board.currentPlayer.id) throw new CanNotMarkPositionError();

        // MARK METHOD SWAP CURRENT PLAYER VALUE
        board.mark(params.position);
        
        this.repository.saveBoard(board);
        
        const opponent = board.currentPlayer
        const boardFromOpponentReference = this.getBoardCommand.execute({ boardId: board.boardId, playerId: opponent.id! })
        this.playerNotifier.notifyGameState(boardFromOpponentReference, opponent.id!);
        
        // if there is a winner, we do not need to store the board anymore
        if (board.winner != null) {
            this.repository.deleteBoard(board.boardId);
            return board;
        }

        return this.getBoardCommand.execute({ boardId: board.boardId, playerId: params.playerId });
    }
}