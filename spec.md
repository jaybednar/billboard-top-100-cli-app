# Specifications for the CLI Assessment

Specs:
1) - [x] Have a CLI for interfacing with the application
2) - [x] Pull data from an external source
3) - [x] Implement both list and detail views

	-CLI allows the user to choose the category of songs. (1)
		-Once a category is chosen, the gem will scrape the appropriate chart off of Billboard.com and generate the data for the rest of the program (2) Data is pulled at any time a new category is chosen.
		-Then user chooses the number of songs they would like to view and songs are displayed in a list format (1), (3)
		-User can choose to view more info about an individual song, or choose menu, back, or exit which allows them to access the Main menu, the current category of songs, or exit the program respectively. (1)
			-If User chooses to view more info, they are displayed the details including: Artist, Current Rank, Previous Rank, Peak Rank, and Number of weeks on chart. (3)
			-User can then choose to see if this current artist has any more songs on the current chart or access menu, back, or exit (1)
				-If User chooses to  see if the artist has any other songs on the chart, they will see the details including how many songs the artist has on this chart, and be displayed the song(s) and the song(s)' current rank(s) on the chart. (1), (3)
				-The User can then choose menu, back or exit once again (1)

