
# IMS project

## Description

- Command line program that helps DJ to manage their artists and tracks. 
- COSI 105b assignment
- Github: 
https://github.com/yirunzhou/IMS-Program/blob/master/README.md

## Manual

`ruby ims` to run the program


IMS Command Manual:

      help
        get help messages of all commands in this IMS app
      
      exit
        save and exit IMS
      
      info
        display recently played tracks' info
      
      info artist <artist_id>
        display this artist's info
      
      info track <track_id>
        display this track's info
      
      add artist <artist_name>
        add this artist to the table, display the id 
        ed to this new artist
      
      add track <track_name> by <artist_id>
        add this track to this artist's record, display the id assigned to this new track
      
      count tracks by <artist_id>
        display # of tracks of this artist
      
      list tracks by <artist_id>
        display info of all the tracks of this artist


<argument_name> is argument for that command


## Design

 #### General
 Get user's input, process it, and call method with extracted arguments to manipulate data of IMS. There are mainly three classes, `DJTable`, `ArtistRecord`, `Main`.

 #### DJTable
 - Deal with all the logics for adding information (artists and tracks);
 - Response with text message or exceptions when some arguments are invalid;
 
 #### ArtistRecord
 - Act as a record for a single artist with his or her name and tracks' information (track name and id);
 
 #### Main
 - Act as an interface between raw input and `DJTable` instance;
 - Process raw string input to see what command user is intended to use and then extract arguments accordingly(regex), finally, call the right method of `DJTable` instance with right arguments;
 - Loop until user exit;
 - Save and load data using `YAML`;
 
 

## File Structure

### Data Persistence

`./data` is used for data persistence;\
`DJTable`'s data are stored in `./data/data.yml`;\
Also I put the long help message in `./data/help_msg/yml`;

### Unit Test

`./test` is used for testing files;\
I use `Rakefile` to automate my test;\
`rake test` to run the test, testing code is in `./test/test_ims_mini.rb`;



## Documentation for methods

  ### DJTable
  Functions with the same names as commands (such like function count_tracks_by for command 'count tracks by') return text messages to display in console.
  
  Other helper functions:
  
  `validation`:\
  It checks if `artist_id`, `track_id` are valid, and checks if `artist` (artist's name) already exitsts. If so, throw exception accordingly.\
  \
  `assign_artist_id`: \
  It takes new artist name and get the artists' initial, following by a number, which is the amount of artists before adding the new artist.\
  e.g. `add artist paul mccartney` when there was no artist before, then this function assigns `pm0` to artist `paul mccartney`.\
  If there already exists the same artist, `validation` method throws exception.\
  \
  `assign_track_id`: 
  It assign the number of tracks in IMS as an ID for this track. Duplication check is in method `add_track` as it only make sense to check if there is a same track for an artist.\
  
  
 ### Main
 
 `initialize`:\
 It takes a boolean `test` as indicator for test mode. If true then it loads testing data in `./data/test_store.yml`, otherwise loads user's data in `./data/data.yml`.\
 \
 `preprocess`:\
 It takes raw user input, makes it downcase and separates words by `1` space, making the regex inside `execute` method a lot more easier to extract arguments.\
 \
 `execute`: \
 It takes the preprocessed command from `preprocess` and use regrex to get intended command and arguments, then executes methods of instance of `DJTable`, finally returns response message.\
 \
 `run`:\
 Run the loop to get user input, call `preprocess` and then `execute`.\
 
 

## Other thoughts

- I should probably separate my test to multiple files so that I could test different parts easier. I kept updating my testing files when developing, losing many tests for the parts I worked with in the beginning.
- Maybe I can decouple between `Main` and `DJTable` as sometimes making my test messy.
- Too many if else in `Main` when trying to figure out what command user wants, I try to use hashing and lambda but I gave up because when I use them my code are even much more longer and less readable.
- Other rubyish things, like I still use `return` in ruby functions.
