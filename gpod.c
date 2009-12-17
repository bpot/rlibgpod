/*
  cc gpod.c -o gpod -I/usr/include/glib-2.0/ -I/usr/lib/glib-2.0/include/  -I/usr/include/gpod-1.0/gpod/ -lgpod
*/

#include "itdb.h"

void main(void) {
    Itdb_iTunesDB* db;
    GList *tracks;
    Itdb_Track *track;
    int num;
    int i;

    db = itdb_parse("/home/paulv/files/src/ruby/rlibgpod/ipod", NULL);
    num = itdb_tracks_number(db);
    tracks = db->tracks;
    printf("%d\n", num);

    for (i = 0; tracks != NULL; i++) {
        tracks = tracks->next;
    }
    printf("%d\n", i);

}
