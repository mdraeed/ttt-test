
//Prints board and a representation of it in numbers
func displayBoard(board: [String]) {
    print()
    print("\(board[0]) | \(board[1]) | \(board[2])             1 | 2 | 3")
    print("---------            -----------")
    print("\(board[3]) | \(board[4]) | \(board[5])             4 | 5 | 6 ")
    print("---------            -----------")
    print("\(board[6]) | \(board[7]) | \(board[8])             7 | 8 | 9 ")
    print()
}

//Checks if the entire board is empty by checking each and every board spot
func isBoardEmpty(board: [String]) -> Bool {
    for i in 0 ..< board.count {
        if board[i] == " " {
            return true
        }
    }
    return false
}

//Checks for possible victories by checking every possible way to win.
func checkWin(board: [String], letter: String) -> Bool {
    return ((board[0] == letter && board[1] == letter && board[2] == letter) || // Check 1st row
              (board[3] == letter && board[4] == letter && board[5] == letter) || // Check 2nd row
              (board[6] == letter && board[7] == letter && board[8] == letter) || // Check 3rd row
              (board[0] == letter && board[3] == letter && board[6] == letter) || // Check 1st column
              (board[1] == letter && board[4] == letter && board[7] == letter) || // Check 2nd column
              (board[2] == letter && board[5] == letter && board[8] == letter) || // Check 3rd column
              (board[6] == letter && board[4] == letter && board[2] == letter) || // Check lower left to upper right diagonal
              (board[0] == letter && board[4] == letter && board[8] == letter)) // Check upper left to lower right diagonal
}

//Utilizes a minimax algorithm to get the best possible move for the AI
func minimax(board: inout [String], depth: Int, maximum: Bool) -> Int {
    if checkWin(board: board, letter: "O") { //If any possible spot results in an AI victory, a max value of 10 is returned.
        return 10
    } else if checkWin(board: board, letter: "X") { //If any possible spot results in a player victory, a min value of 10 is returned.
        return -10
    } else if isBoardEmpty(board: board) == false { //If board is empty, a neutral value of 0 is returned.
        return 0
    }
    
    if maximum == true { //When maximum == true, the lowest value/'maxxing' will be returned
        var best : Int = -1000
        for i in 0 ..< board.count { //Cycles through all board spots with potential moves to determine lowest value/maximum
            if board[i] == " " {
                board[i] = "O"
                best = max(best, minimax(board: &board, depth: depth + 1, maximum: false)) //Determines value for each position and keeps the lowest value.
                board[i] = " "
            }
        }
        return best + depth
    } else {  //The highest value/'minning' will be returned to avoid a player victory
        var worst = 1000
        for i in 0 ..< board.count {
            if board[i] == " " {
                board[i] = "X"
                worst = min(worst, minimax(board: &board, depth: depth + 1, maximum: true)) //Cycles through all board spots to determine highest value/minimum
                board[i] = " "
            }
        }
        return worst - depth
    }
}

//Gets AI move by using the minimax algorithm
func aiMove(board: inout [String]) -> Int {
    var bestScore = -1000
    var winningMove = 0
    for i in 0 ..< board.count { //Cycles through every spot on the board                                        
        if board[i] == " " { //Only checks through empty spots
            board[i] = "O"
            let moveScore = minimax(board: &board, depth: 0, maximum: false)
            board[i] = " "
            if moveScore > bestScore { //If moveScore from i spot is higher than bestScore, bestScore is redeclared to moveScore, winningMove is declared to be the i spot, cycling through each possible spot.
                winningMove = i
                bestScore = moveScore
            }
        }
    }
    return winningMove
}

func playAgain() -> Void { //Prompts player choose whether to play again or not, returns true or false depending on response.
    print("Would you like to play again? [Y]es or [N]o.")
    let again = readLine()!.uppercased()
    if again.prefix(1) == "Y" {
        playGame()
    } else if again.prefix(1) == "N" {
        return
    } else {
        print("Invalid response.")
        playAgain()
    }
}

func clearScreen() { //Clears screen
    print("\n", terminator: Array(repeating: "\n", count: 99).joined())
}

func playerMove(board: inout [String], position: String, turn: inout Bool) {
    if 1...9 ~= Int(position)! { //Forces string of position into an integer, and determines whether it falls between 1 through 9
        if board[Int(position)! - 1] == " " {
            if turn == false { //Depending on turn, places X or O into position if position is empty
                board[Int(position)! - 1] = "X" 
                turn = true
            } else {
                board[Int(position)! - 1] = "O"
                turn = false
            }
            clearScreen()
            print("Your Turn:")
        } else { //if position is taken, prompts the player to select an open spot.
            clearScreen()
            print("That spot has already been taken! Please select an open spot.")
        }
    } else { //Clears screen if unwrapping fails.
        clearScreen()
    }
}

func checkWinCycle(board: [String], running: inout Bool, multiplayer: Bool) { //Checks for win by Player 1 or 2, or a tie.
    if checkWin(board: board, letter: "X") == true { //Runs checkWin for player 1
        print("Congratulations! You won!")
        playAgain()
        running = false
    } else if checkWin(board: board, letter: "O") == true { //Runs checkwin for player 2/AI
        if multiplayer == false { //Determines whether multiplayer or singleplayer
            print("Unfortunately, the AI won. Maybe next time 😏")
        } else {
            print("Congratulations! Player O won!")
        }
        playAgain()
        running = false
    } else if checkWin(board: board, letter: "X") == false
                && checkWin(board: board, letter: "O") == false && isBoardEmpty(board: board) == false { //Checks for possible tie
        print("It's a tie! Maybe next time 😏")
        playAgain()
        running = false
    }
}

func gameMode(multiplayer: inout Bool) { //Prompts the player into selecting a gamemode, makes multiplayer true or false depending on player response
    print("[S]ingleplayer or [M]ultiplayer?)")
    let multiplayerResponse = readLine()!.uppercased()
    if multiplayerResponse == "M" {
        multiplayer = true
    } else if multiplayerResponse == "S" {
        multiplayer = false
    } else {
        playGame()
    }
}

func printStart() { //Prints start menu.
    print("********* [ WELCOME TO TIC-TAC-TOE GAME ] *********")
    print("*                                                 *")
    print("*         INFO: PLAYER 1 (X), PLAYER 2 (O)        *")
    print("*                                                 *")
    print("*              < GAME TABLE FORMAT >              *")
    print("*                                                 *")
    print("*                   1 | 2 | 3                     *")
    print("*                   ---------                     *")
    print("*                   4 | 5 | 6                     *")
    print("*                   ---------                     *")
    print("*                   7 | 8 | 9                     *")
    print("*                                                 *")
    print("***************************************************")
}

func playGame() { //Main function that compiles all different functions together into one.
    var board : [String] = [" ", " ", " ",
                            " ", " ", " ",
                            " ", " ", " "] //Declares board into a one-dimensional 3x3 array of strings.
    var turn : Bool = false //Declares turn variable, turn false = player 1, turn true = player 2/AI
    var running : Bool = true 
    var multiplayer : Bool = false
    
    clearScreen()
    printStart()
    gameMode(multiplayer: &multiplayer) //Prompts player into selecting gameMode
    
    // Singleplayer
    while (isBoardEmpty(board: board) == true) && (running == true) && (multiplayer == false) { //Runs if player chooses singleplayer and board is empty.
        if turn == false { //Prompts player 1 into selecting a move
            print("Please select a move from 1-9:")
            let position = readLine()! //Declares position to be player response
            playerMove(board: &board, position: position, turn: &turn)
        } else {
            let position = aiMove(board: &board) //Declares position to be the AI move
            board[position] = "O" //Places O into best AI move.
            turn = false //Makes turn = false to switch turns
            print("AI's Turn: ") 
        }
        
        displayBoard(board: board) //calls displayBoard to print board.
        checkWinCycle(board: board, running: &running, multiplayer: multiplayer) //Checks if any player has won or if a tie has occurred.
    }

    // Multiplayer
    while (isBoardEmpty(board: board) == true) && (running == true) && (multiplayer == true) { //Runs if player chooses multiplayer and board is empty
        if turn == false { //Player 1s move
            print("Player 1, please select a move from 1-9:")
            let position = readLine()! //Declares player response to be position
            playerMove(board: &board, position: position, turn: &turn)
            displayBoard(board: board)
            checkWinCycle(board: board, running: &running, multiplayer: multiplayer)
        } else {
            print("Player 2, please select a move from 1-9:")
            let position = readLine()! //Declares player response to be position
            playerMove(board: &board, position: position, turn: &turn)
            displayBoard(board: board)
            checkWinCycle(board: board, running: &running, multiplayer: multiplayer)
        }
    }
}

playGame() //invokes playGame
