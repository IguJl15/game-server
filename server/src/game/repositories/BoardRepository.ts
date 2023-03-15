import { Board } from "../entities/Board"

export interface BoardRepository {
    getBoardByPlayerId(playerId: string): Board | null
    saveBoard(board: Board): string
    getBoard(id: string): Board | null
    deleteBoard(id: string): boolean
}

export default
class ArrayBoardRepo implements BoardRepository {
    private readonly boards: Map<string, Board> = new Map()
    
    
    saveBoard(board: Board): string {
        this.boards.set(board.boardId, board.deepCopy())

        return board.boardId;
    }

    getBoard(id: string): Board | null {
        const item = this.boards.get(id) ?? null
        return item?.deepCopy() ?? null
    }

    getBoardByPlayerId(playerId: string) {
        for (const [boardId, board] of this.boards.entries()) {
            if(board.player1.id == playerId || board.player2?.id == playerId) return board
        }
        
        return null
    }

    deleteBoard(id: string): boolean {
        return this.boards.delete(id)
    }
    
}


