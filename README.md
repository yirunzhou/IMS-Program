
# IMS project

## Description

Command line program that helps DJ to manage their aritsts and tracks. 
COSI 105b assiginment 


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
 - Loading data using `YAML`;
 
 #### ArtistRecord
 - Act as a record for a single artist with his or her name and tracks' information (track name and id);
 
 #### Main
 - Act as an interface between raw input and `DJTable` instance;
 - Process raw string input to see what command user are intended to use and then extract arguments, finally, call the right method of `DJTable` instance with right arguments;
 - Loop until user exit;
 

## Unit Test

I used `Rakefile` to automate my test.
`rake test` to run the test, testing code is in `./test/test_ims_mini.rb`
I should probably separate my test to multiple files.

## Data Persistence

`DJTable`'s data are stored in `./data/data.yml`
Also I put the long help message in `./data/help_msg/yml`
