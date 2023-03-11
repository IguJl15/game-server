import SocketServer from "../..";
import { Board } from "../entities/Board";

export default
interface Notifier {
    notifyGameState(message: Board, playerId: string): void
}

export
class SocketNotifier implements Notifier {
    notifyGameState(gameState: Board, playerId: string): void {
        SocketServer.sendMessageToPlayer({ "GameState": gameState }, playerId);
    }
}