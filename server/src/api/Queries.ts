interface CreateGameParameters {
    boardId: String
    playerName?: String
}
abstract class CreateGameQueryValidator {
    
    static validate(jsonQuery: Object): String | null {
            
        if(!jsonQuery.hasOwnProperty("playerName")) return "propriedade 'playerName' é obrigatória"
        if(!jsonQuery.hasOwnProperty("symbol")) return "propriedade 'symbol' é obrigatória"
        
        if(typeof jsonQuery )

        return null
    }
}

abstract class StringParameterValidator {
    static validate(text: String) {
        const trimmedValue = text.trim()

    }
}