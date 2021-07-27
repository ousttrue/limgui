-- generated from imstb_textedit.h
local ffi = require 'ffi'
ffi.cdef[[
typedef struct {
    int where;
    int insert_length;
    int delete_length;
    int char_storage;
} StbUndoRecord;
typedef struct {
    StbUndoRecord undo_rec;
    ImWchar undo_char;
    short undo_point;
    short redo_point;
    int undo_char_point;
    int redo_char_point;
} StbUndoState;
typedef struct {
    int cursor;
    int select_start;
    int select_end;
    unsigned char insert_mode;
    int row_count_per_page;
    unsigned char cursor_at_end_of_line;
    unsigned char initialized;
    unsigned char has_preferred_x;
    unsigned char single_line;
    unsigned char padding1;
    unsigned char padding2;
    unsigned char padding3;
    float preferred_x;
    StbUndoState undostate;
} STB_TexteditState;
]]
