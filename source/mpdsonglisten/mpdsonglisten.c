/*
 * Compile: gcc mpdsonglisten.c -o mpdsonglisten -lmpdclient -std=c99 
 * Run: ./mpdsonglisten localhost 6600 <on_play_script> <on_stop_script>
* Example: ./mpdsong localhost 6600 'echo plays!' 'echo stopped!'
* 
* It will call on_play_script once mpd starts playing,
* and on_stop_script once it pauses, stops or does something unknown.
*
* Error handling is done by ignoring none-fatal erros and trying to reconnect if
* fatal errors happen.
 * */
#include <mpd/client.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
 
static volatile bool not_ctrlc_pressed = true;
 
 
static bool check_error(struct mpd_connection * client)
{
    if(mpd_connection_get_error(client) != MPD_ERROR_SUCCESS) {
        printf("Error: %s (Retry in 1 second...)\n", mpd_connection_get_error_message(client));
        if(!mpd_connection_clear_error(client)) {
            mpd_connection_free(client);
            sleep(1);
            return true;
        }
    }
    return (client == NULL);
}
 
static struct mpd_connection * connect(const char * host, unsigned port) 
{
    struct mpd_connection * client = NULL;
    for(;;) {
        client = mpd_connection_new(host, port, 2000);
        if(check_error(client)) {
            continue;
        }
 
        break;
    }
 
    return client;
}
 
void cancel_signal(int signal)
{
    if(signal == SIGINT) {
        not_ctrlc_pressed = false;
    }
}
 
int main(int argc, char const *argv[])
{
    if (argc < 3) {
        printf("Usage: prog <hostname> <port> <on_play_script> <on_stop_script>");
        return EXIT_FAILURE;
    }
 
    int previous_sond_id = -1;
    enum mpd_state prev_state = MPD_STATE_UNKNOWN;
    struct mpd_connection * client = connect(argv[1], strtol(argv[2], NULL, 10));
 
    signal(SIGINT, cancel_signal);
 
    while(not_ctrlc_pressed) {
        enum mpd_idle events = mpd_run_idle (client);
        if(check_error(client)) {
            client = connect(argv[1], strtol(argv[2], NULL, 10));
            continue;
        }
 
        if (events & MPD_IDLE_PLAYER) {
            struct mpd_status * status = mpd_run_status(client);
            if (status != NULL) {
                enum mpd_state play_state = mpd_status_get_state(status);
                int current_song_id = mpd_status_get_song_id(status);
 
                switch(play_state) {
                    case MPD_STATE_PLAY:
                        // if (current_song_id != previous_sond_id && prev_state != play_state) {
                    	if (current_song_id != previous_sond_id) {
                            previous_sond_id = current_song_id;
                            if (argc > 3)
                                system(argv[3]);
                        }
                        break;
                    case MPD_STATE_UNKNOWN:
                    // case MPD_STATE_PAUSE:
                    case MPD_STATE_STOP:
                        previous_sond_id = -1;
                        if (argc > 4)
                            system(argv[4]);
                        break;
                }
 
                // prev_state = play_state;
            }
        }
    }
 
    if(client != NULL) {
        mpd_connection_free(client);
    }
    return EXIT_SUCCESS;
}