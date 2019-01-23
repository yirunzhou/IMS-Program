
# IMS project

## Description

- Command line program that helps DJ to manage their aritsts and tracks. 
- COSI 105b assiginment 
- Github: 
https://github.com/yirunzhou/IMS-Program/blob/master/README.md

## Manual

IMS Command Mannual:

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
        add this artist to the table, display the id assigned to this new artist
      
      add track <track_name> by <artist_id>
        add this track to this artist's record, display the id assigned to this new track
      
      count tracks by <artist_id>
        display # of tracks of this artist
      
      list tracks by <aritist_id>
        display info of all the tracks of this artist


<argument_name> is argument for that command


## Design

There are mainly three classes, `DJTable`, `ArtistRecord`, `Main`:

 #### DJTable
 - Deal with all the logics for adding information (artists and tracks);
 - Response with text message or exceptions when some arguments are invalid;
 - Save and load data using `YAML`;
 
 #### ArtistRecord
 - Act as a record for a single artist with his or her name and tracks' information (track name and id);
 
 #### Main
 - Act as an interface between raw input and `DJTable` instance;
 - Process raw string input to see what command user is intended to use and then extract arguments accordingly(regex), finally, call the right method of `DJTable` instance with right arguments;
 - Loop until user exit;
 
 

## File Structure

### Data Persistence

`./data` is used for data persistence;
`DJTable`'s data are stored in `./data/data.yml`;
Also I put the long help message in `./data/help_msg/yml`;

### Unit Test

`./test` is used for testing files;
I use `Rakefile` to automate my test;
`rake test` to run the test, testing code is in `./test/test_ims_mini.rb`;



## Documentation for methods

  ### DJTable
  Functions with the same names as commands (such like function count_tracks_by for command 'count tracks by') return text messages to display in console.
  
  Other helper functions:
  
  `validation`:\
  It checks if `artist_id`, `track_id` are valid, and checks if `artist` (artist's name) already exitsts. If so, throw exception accordingly.\
  \
  `assigin_artist_id`: \
  It takes new artist name and get the artists' initial, following by a number, which is the amount of artists before adding the new artist.\
  e.g. Command 'add artist paul mccartney' when there was no artist before, then this function assign 'pm0' to artist 'paul mccartney'.\
  If there already exists the same artist, `validation` method throws exception.



 


## Other thoughts

- I should probably separate my test to multiple files so that I could test different parts easier.
- Maybe I can loose the coupling between `Main` and `DJTable` as sometimes making my test messy.
- Too many if else in `Main` when trying to figure out what command user wants, I try to use hashing and lambda but I gave up because when I use them my code are even much more longer
