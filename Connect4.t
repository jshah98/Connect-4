% Jinansh Shah
% Connect4.t
% 27/05/13
% Ms Dyke
% This program allows two users to play connect 4.
% The first screen is the introduction. It displays a loading bar and a connect 4 chip bouncing up and down.
% Then, it displays a picture and a Main Menu button.
% When the user clicks the Main Menu button, a menu is displayed with three buttons: "Play Game", "Instructions", and "Exit"
% If the user clicks the "Instructions" button, the program will display the instructions and wait for keyboard input. As soon as the user presses any key, they return to the Main Menu.
% If the user chooses to play the game, game screen will be shown. When  the user clicks on a column, a chip will drop in that column.
% If the same column is clicked again, the chip will land on top of the last chip. This will comtinue until each column is full.
% When there is winner (either player get four of his/her chips in a row- horizontally, vertically, or diagonally), the program will display the winner (either Player 1 or Player 2).
% During anytime while playing the game, and after the game, the user can go back to the main menu by clicking cool "Main Menu" button.
% Lastly, if the user chooses to exit from the main menu, the program will run goodBye and then exit when the user inputs any key.

import GUI
% This global variable is used to open a new window.
var mainWin : int := Window.Open ("position:top;right,graphics:1000;640")
% These variables store the location of the mouse.
var xCoord, yCoord, button : int := 0
% This variable stores the result of the game.
var gameResult : string := "Game not over."
setscreen ("nocursor")
forward procedure mainMenu

% Title- clears screen and displays title
procedure title
    cls
    drawfillbox (0, 0, 1000, 640, black)
    % This variable stores a new font.
    var font := Font.New ("Stencil:48:bold")
    Font.Draw ("Connect 4!", 330, 580, font, 0)
end title

% This process plays music while the program is running.
% You have requested that Jinansh and Kevin put a reminder in their codes explaining that we had weird problems with the music because you wanted to check it.
%process playMusic
%    Music.PlayFileLoop ("BeverlyHills.mp3")
%end playMusic

% Displays winner and a Main Menu button.
procedure display
    % This variable stores a new font.
    var font := Font.New ("arial:16")
    % This variable stores a new font.
    var font2 := Font.New ("Comic Sans MS:20:bold")
    Font.Draw (gameResult, 408, 538, font2, 10)
    Font.Draw (gameResult, 410, 540, font2, 14)
    % This loop is used to check where the mouse is.
    loop
	mousewhere (xCoord, yCoord, button)
	% Checks if the mouse is within the given range.
	if (xCoord > 440 and xCoord < 560) and (yCoord > 40 and yCoord < 70) then
	    Font.Draw ("Main Menu", 450, 48, font, 10)
	    drawbox (440, 40, 560, 70, 10)
	    % Checks if the user clicked
	    if button = 1 then
		mainMenu
		exit
	    end if
	else
	    Font.Draw ("Main Menu", 450, 48, font, 14)
	    drawbox (440, 40, 560, 70, 13)
	end if
    end loop
end display

% Main Game and processing- checks for gam result and displays the game being played.
procedure userInput
    GUI.Hide (2002)
    GUI.Hide (2003)
    GUI.Hide (2004)
    title
    % This variable stores a new font.
    var font := Font.New ("arial:16")
    % This variable is used to check what the colour of the chip is (at the stored x and y coordinate).
    var xCheck, yCheck : int
    % Used to determine if the game is over or not. If it is over, the program will run display.
    var gameOver := false
    % Used to store the colour of the chip being played.
    var colourOfChip : int
    % Used to store the number of chips in each column.
    var number : array 1 .. 7 of int
    for i : 1 .. 7
	number (i) := 0
    end for
    % This loop is used to run the game until the game ends.
    loop
	mousewhere (xCoord, yCoord, button)
	yCheck := 116
	% This loop checks for a winner.
	loop
	    xCheck := 284
	    % This loop checks every column, from left to right, for a winner.
	    loop
		% Checks every cell to see if any player won.
		if whatdotcolour (xCheck, yCheck) = 11 and whatdotcolour (xCheck, yCheck + 72) = 11 and whatdotcolor (xCheck, yCheck + 144) = 11 and whatdotcolour (xCheck, yCheck + 216) = 11
			or (whatdotcolour (xCheck, yCheck) = 11 and whatdotcolour (xCheck + 72, yCheck) = 11 and whatdotcolour (xCheck + 144, yCheck) = 11 and whatdotcolour (xCheck + 216, yCheck) =
			11)
			or (whatdotcolour (xCheck, yCheck) = 11 and whatdotcolour (xCheck + 72, yCheck + 72) = 11 and whatdotcolour (xCheck + 144, yCheck + 144) = 11 and whatdotcolour (xCheck + 216,
			yCheck + 216) = 11)
			or (whatdotcolour (xCheck, yCheck) = 11 and whatdotcolour (xCheck + 72, yCheck - 72) = 11 and whatdotcolour (xCheck + 144, yCheck - 144) = 11 and whatdotcolour (xCheck + 216,
			yCheck - 216) = 11) then
		    gameResult := "Player 2 wins!"
		    gameOver := true
		elsif (whatdotcolour (xCheck, yCheck) = 12 and whatdotcolour (xCheck, yCheck + 72) = 12 and whatdotcolor (xCheck, yCheck + 144) = 12 and whatdotcolour (xCheck, yCheck + 216) = 12)
			or (whatdotcolour (xCheck, yCheck) = 12 and whatdotcolour (xCheck + 72, yCheck) = 12 and whatdotcolour (xCheck + 144, yCheck) = 12 and whatdotcolour (xCheck + 216, yCheck) =
			12)
			or (whatdotcolour (xCheck, yCheck) = 12 and whatdotcolour (xCheck + 72, yCheck + 72) = 12 and whatdotcolour (xCheck + 144, yCheck + 144) = 12 and whatdotcolour (xCheck + 216,
			yCheck + 216) = 12)
			or (whatdotcolour (xCheck, yCheck) = 12 and whatdotcolour (xCheck + 72, yCheck - 72) = 12 and whatdotcolour (xCheck + 144, yCheck - 144) = 12 and whatdotcolour (xCheck + 216,
			yCheck - 216) = 12) then
		    gameResult := "Player 1 wins!"
		    gameOver := true
		else
		    xCheck := xCheck + 72
		end if
		exit when gameOver or xCheck > 716
	    end loop
	    yCheck := yCheck + 72
	    exit when gameOver or yCheck > 476
	end loop
	exit when gameOver
	% Checks to see if the game was a tie.
	if (xCoord > 248 and xCoord < 752) and (number (1) >= 6 and number (2) >= 6 and number (3) >= 6 and number (4) >= 6 and number (5) >= 6 and number (6) >= 6 and number (7) >= 6) then
	    gameResult := "Tie! Play again."
	    gameOver := true
	end if
	% This loop is used to determine the colour of the chip being played.
	for i : 0 .. 42 by 2
	    % Checks to see if the colour of the chip should red.
	    if number (1) + number (2) + number (3) + number (4) + number (5) + number (6) + number (7) - i = 0 then
		colourOfChip := 12
		exit
	    else
		% Checks to see if the colour of the chip should blue.
		if number (1) + number (2) + number (3) + number (4) + number (5) + number (6) + number (7) - i = 1 then
		    colourOfChip := 11
		    exit
		end if
	    end if
	end for
	drawfilloval (125, 220, 33, 33, colourOfChip)
	locatexy (70, 175)
	% This if statement displays whos turn it is.
	if colourOfChip = 12 then
	    put "Player 1's turn!" ..
	else
	    put "Player 2's turn!" ..
	end if
	% Checks to see if the mouse has been clicked and if the mouse if within the range.
	if button = 1 and (yCoord > 80 and yCoord < 550) then
	    % Checks to see which column the user clicked on.
	    if (xCoord < 319 and xCoord > 248) then
		number (1) := number (1) + button
		% Checks to see if the column is full.
		if number (1) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (1) * 72
			drawfilloval (284, 476 - x, 35, 35, 7)
			drawfilloval (284, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (1) := number (1) - 1
		end if
	    elsif (xCoord < 391 and xCoord > 320) then
		number (2) := number (2) + button
		% Checks to see if the column is full.
		if number (2) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (2) * 72
			drawfilloval (356, 476 - x, 35, 35, 7)
			drawfilloval (356, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (2) := number (2) - 1
		end if
	    elsif (xCoord < 463 and xCoord > 392) then
		number (3) := number (3) + button
		% Checks to see if the column is full.
		if number (3) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (3) * 72
			drawfilloval (428, 476 - x, 35, 35, 7)
			drawfilloval (428, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (3) := number (3) - 1
		end if
	    elsif (xCoord < 535 and xCoord > 464) then
		number (4) := number (4) + button
		% Checks to see if the column is full.
		if number (4) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (4) * 72
			drawfilloval (500, 476 - x, 35, 35, 7)
			drawfilloval (500, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (4) := number (4) - 1
		end if
	    elsif (xCoord < 607 and xCoord > 536) then
		number (5) := number (5) + button
		% Checks to see if the column is full.
		if number (5) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (5) * 72
			drawfilloval (572, 476 - x, 35, 35, 7)
			drawfilloval (572, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (5) := number (5) - 1
		end if
	    elsif (xCoord < 679 and xCoord > 608) then
		number (6) := number (6) + button
		% Checks to see if the column is full.
		if number (6) <= 6 then
		    % This loop is used to animate the chip falling.
		    for x : 0 .. 432 - number (6) * 72
			drawfilloval (644, 476 - x, 35, 35, 7)
			drawfilloval (644, 476 - x, 33, 33, colourOfChip)
			delay (5)
		    end for
		else
		    number (6) := number (6) - 1
		end if
	    else
		% Checks to see if the user clicked the last column.
		if (xCoord < 751 and xCoord > 608) then
		    number (7) := number (7) + button
		    % Checks to see if the column is full.
		    if number (7) <= 6 then
			% This loop is used to animate the chip falling.
			for x : 0 .. 432 - number (7) * 72
			    drawfilloval (716, 476 - x, 35, 35, 7)
			    drawfilloval (716, 476 - x, 33, 33, colourOfChip)
			    delay (5)
			end for
		    else
			number (7) := number (7) - 1
		    end if
		end if
	    end if
	end if
	% This loop is used to draw multiple horizontal lines that make the grid representing the connect 4 board.
	for x : 0 .. 7
	    Draw.ThickLine (248 + x * 72, 80, 248 + x * 72, 512, 2, 14)
	end for
	% This loop is used to draw multiple vertical lines that make the grid representing the connect 4 board.
	for i : 0 .. 6
	    Draw.ThickLine (248, 80 + i * 72, 752, 80 + i * 72, 2, 14)
	end for
	% checks to see if the mouse if by the main menu button
	if (xCoord > 440 and xCoord < 560) and (yCoord > 40 and yCoord < 70) then
	    Font.Draw ("Main Menu", 450, 48, font, 10)
	    drawbox (440, 40, 560, 70, 10)
	    % Checks to see if the main menu button has been clicked.
	    if button = 1 then
		mainMenu
		exit
	    end if
	else
	    Font.Draw ("Main Menu", 450, 48, font, 14)
	    drawbox (440, 40, 560, 70, 13)
	end if
    end loop
    display
end userInput

% Displays the instructions
procedure instructions
    GUI.Hide (2002)
    GUI.Hide (2003)
    GUI.Hide (2004)
    title
    locate (15, 30)
    colour (0)
    put "Welcome to Connect 4!"
    locate (17, 25)
    put "The aim of this game is to get 4 of your chips in a row (horizontally, vertically, or diagonally)."
    locate (18, 25)
    put "Two players take turns dropping chips into a column (Player 1 is red and Player 2 is blue)."
    locate (19, 25)
    put "To drop a chip into a column, click on the column."
    locate (20, 25)
    put "If all the cells are occupied before a player manages to win, the game will end as a tie."
    locate (21, 25)
    put "Player 1 goes first."
    locate (28, 48)
    put "Press any key to continue..."
    % This loop is used to pause the program until there is keyboard input.
    loop
	exit when hasch
    end loop
    mainMenu
end instructions

% Displays 3 buttons leading to instructions, exit screen, or the game.
body procedure mainMenu
    GUI.Hide (2001)
    title
    % This variable stores the new GUI buttons.
    var buttonPlayGame, buttonInstructions, buttonExit : int := 0
    buttonPlayGame := GUI.CreateButton (450, 450, 100, "Play Game", userInput)
    buttonInstructions := GUI.CreateButton (450, 400, 100, "Instructions", instructions)
    buttonExit := GUI.CreateButton (450, 350, 100, "Exit", GUI.Quit)
end mainMenu

% Displays animation, a main menu button and a picture of the connect 4 box.
procedure intro
    %fork playMusic         % Plays the music
    title
    % This variable stores the picture ID of the imported picture.
    var pictureID : int
    pictureID := Pic.FileNew ("connect4.jpg")
    colourback (black)
    colour (white)
    drawbox (454, 475, 546, 486, 0)
    locatexy (470, 450)
    put "Loading..." ..
    % This loop is used to animmate the bouncing ball three times.
    for i : 1 .. 3
	drawfillbox (455, 476, 456 + i * 30, 484, 10)
	% This loop is used to animate the ball bouncing back up.
	for x : 0 .. 225
	    drawfilloval (500, 41 + x, 42, 42, 7)
	    drawfilloval (500, 41 + x, 40, 40, 12)
	    delay (6)
	end for
	% This loop is used to animate the ball falling down.
	for x : 0 .. 225
	    drawfilloval (500, 266 - x, 42, 42, 7)
	    drawfilloval (500, 266 - x, 40, 40, 12)
	    delay (4)
	end for
    end for
    drawfilloval (500, 41, 50, 50, 7)
    Pic.Draw (pictureID, 340, 200, picMerge)
    % This variable is used to store the new GUI button.
    var buttonMainMenu : int := GUI.CreateButton (450, 50, 100, "Main Menu", mainMenu)
    GUI.SetColour (buttonMainMenu, 10)
end intro

% Displays a goodbye message
procedure goodBye
    GUI.Hide (2002)
    GUI.Hide (2003)
    GUI.Hide (2004)
    title
    colourback (black)
    color (white)
    locate (9, 40)
    put "Game created by: Jinansh Shah!"
    locate (10, 40)
    put "For further inforation, contact me at: jinanshshah@yahoo.ca"
    locate (12, 45)
    put "Thank you for using this prgram. Bye!"
    locate (28, 48)
    put "Press any key to continue..."
    % This loop is used to pause the program until there is keyboard input.
    loop
	exit when hasch
    end loop
    Window.Close (mainWin)
end goodBye

% Start of main program
intro
% This loop loops the program until the user chooses to quit (by clicking the "Exit" button).
loop
    exit when GUI.ProcessEvent
end loop
goodBye
% End of main program

