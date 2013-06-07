# SQL Assessment

## Instructions

You have 25 minutes to write SQL queries for the following questions.

You may only use the command line and a text editor. Do not use the
internet.

Run the following commands:

    cd #{your/path/to}/assessment03a
    cat import_db.sql | sqlite3 sql-assessment03a.db
    sqlite3 sql-assessment03a.db

Use your text editor to craft your SQL queries, then run them in
SQLite to see your output.

To aid you, the desired result output is provided for each
question. All result output is ordered ascending, by columns in order
of appearance.

(Note: Some database entries are a bit wonky, and may not reflect
reality. Do not worry, the given output is correct based on the
supplied dataset.)

In `sqlite3` you can list all tables with `.tables` and view the
database schema with `.schema`.

Don't get stuck on any one problem; move on to others if you can't
solve one.

After 25 minutes (or upon completion), send me the text file with your
SQL queries. Name the file
`sql-assessment03a-#{firstname}-#{lastname}.sql`.

If you have any problems getting set up and started, ask your
instructor for help.

Focus and conquer!

## Questions

### 7. Obtain the cast list for the movie 'Casablanca'.

    Curt Bois
    Dooley Wilson
    Georges Renavent
    Hans Twardowski
    Helmut Dantine
    High Sierra
    Ilka Grünig
    Intermezzo
    Jean Del Val
    John Qualen
    Joy Page
    Key Largo
    Leo White
    Leon Belasco
    Leonid Kinskey
    Louis V. Arco
    Ludwig Stössel
    Madeleine LeBeau
    Norma Varden
    Notorious
    Paul Henreid
    Peter Lorre
    Richard Ryen
    Russian Revolution
    S. Z. Sakall
    The Cabinet of Dr. Caligari
    The Maltese Falcon
    To Have and Have Not
    Torben Meyer
    Trude Berliner
    William Edmunds
    Wolfgang Zilzer

### 8. Obtain the cast list for the film 'Alien'

    BAFTA
    Invasion of the Body Snatchers
    Tom Skerritt
    Yaphet Kotto
    android
    bronchitis

### 9. List the films in which 'Harrison Ford' has appeared

    A Hundred and One Nights
    American Graffiti
    Apocalypse Now
    Dead Heat on a Merry-Go-Round
    Extraordinary Measures
    Firewall
    Force 10 From Navarone
    Hawthorne of the U.S.A.
    Hollywood Homicide
    Indiana Jones and the Last Crusade
    Jimmy Hollywood
    More American Graffiti
    Morning Glory
    Presumed Innocent
    Regarding Henry
    Sabrina
    Sally of the Sawdust
    Shadows
    Six Days Seven Nights
    Smilin' Through
    Star Wars Episode IV: A New Hope
    Star Wars Episode V: The Empire Strikes Back
    Star Wars Episode VI: Return of the Jedi
    The Conversation
    The Devil's Own
    The Fugitive
    The Mosquito Coast
    The Star Wars Holiday Special
    What Lies Beneath
    Witness

### 10: List the films where 'Harrison Ford' has appeared, but not in the star role.

(Note: the ord field of casting gives the position of the actor. If ord = 1 then this actor is in the starring role.)

    A Hundred and One Nights
    American Graffiti
    Apocalypse Now
    Dead Heat on a Merry-Go-Round
    Extraordinary Measures
    Force 10 From Navarone
    Hawthorne of the U.S.A.
    Jimmy Hollywood
    More American Graffiti
    Morning Glory
    Sally of the Sawdust
    Shadows
    Smilin' Through
    Star Wars Episode IV: A New Hope
    Star Wars Episode V: The Empire Strikes Back
    Star Wars Episode VI: Return of the Jedi
    The Conversation
    The Star Wars Holiday Special

### 11. List the films together with the leading star for all 1962 films.

    A Kind of Loving|Alan Bates
    Barabbas|Anthony Quinn
    Big and Little Wong Tin Bar|Jackie Chan
    Billy Rose's Jumbo|Doris Day
    Birdman of Alcatraz|Burt Lancaster
    Boys' Night Out|Kim Novak
    Cape Fear|Gregory Peck
    Carry On Cruising|Sid James
    Days of Wine and Roses|Jack Lemmon
    Dr. No|James Bond
    Gay Purr-ee|Judy Garland
    Gypsy|Rosalind Russell
    In Search of the Castaways|Hayley Mills
    Jigsaw|Jack Warner
    L'Eclisse|Alain Delon
    La notte|Marcello Mastroianni
    Life for Ruth|Michael Craig
    Lolita|James Mason
    Long Day's Journey into Night|Katharine Hepburn
    Love at Twenty|Jean-Pierre Léaud
    Lycanthropus|Barbara Lass
    Mother Joan of the Angels|Lucyna Winnicka
    Mutiny on the Bounty|Marlon Brando
    Panic in Year Zero!|Ray Milland
    Period of Adjustment|Anthony Franciosa
    Pressure Point|Bobby Darin
    Ride the High Country|Randolph Scott
    State Fair|Pat Boone
    Sundays and Cybele|Hardy Krüger
    Term of Trial|Laurence Olivier
    That Touch of Mink|Cary Grant
    The 300 Spartans|King Leonidas
    The Apartment|Jack Lemmon
    The Counterfeit Traitor|William Holden
    The Man Who Shot Liberty Valance|John Wayne
    The Manchurian Candidate|Frank Sinatra
    The Music Man|Robert Preston
    The Phantom of the Opera|Herbert Lom
    The Trial|Anthony Perkins
    Through a Glass Darkly|Harriet Andersson
    To Kill a Mockingbird|Mary Badham
    What Ever Happened to Baby Jane?|Joan Crawford
    Who's Got the Action?|Dean Martin

### 12. Which were the busiest years for 'John Travolta'?

Show the year and the number of movies he made each year for any year in which he made more than 2 movies.

    1998|3

### 13. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

    10|Dudley Moore
    Darling Lili|Julie Andrews
    Despicable Me|Steve Carell
    Relative Values|Julie Andrews
    S.O.B.|Julie Andrews
    Star!|Julie Andrews
    The Americanization of Emily|James Garner
    The Pink Panther Strikes Again|Peter Sellers
    The Princess Diaries|Anne Hathaway
    The Princess Diaries 2: Royal Engagement|Anne Hathaway
    The Sound of Music|Julie Andrews
    Thoroughly Modern Millie|Julie Andrews
    Tooth Fairy|Dwayne Johnson
    Torn Curtain|Paul Newman
    Victor Victoria|Julie Andrews

### 14. Obtain a list in alphabetical order of actors who've had at least 30 starring roles.

    John Wayne
