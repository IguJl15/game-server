import { MarkPosition } from "../../api/Mutations";
import AuthorizeUserCommand from "../../auth/commands/AuthorizeUserCommand";
import { BoardNotFoundError, CanNotMarkPositionError, GameNotRunningError } from "../Errors";
import { Board } from "../entities/Board";
import { BoardRepository } from "../repositories/BoardRepository";
import Notifier from "../utils/Notifier";

export default
    class MarkPositionCommand {
    constructor(
        private repository: BoardRepository,
        private getUserCommand: AuthorizeUserCommand,
        private playerNotifier: Notifier,
    ) { }

    execute(params: MarkPosition): Board {
        const user = this.getUserCommand.execute(params.sessionId);

        let board = this.repository.getBoard(params.boardId);

        console.log(params);

        if (board == null) throw new BoardNotFoundError();
        if (board.status != "in game") throw new GameNotRunningError();
        if (user.id != board.currentPlayer.userId) throw new CanNotMarkPositionError();

        // MARK METHOD SWAP CURRENT PLAYER VALUE
        board.mark(params.position);

        this.repository.saveBoard(board);

        const opponent = board.currentPlayer;
        this.playerNotifier.notifyGameState(board, opponent.userId);

        return board;
    }
}