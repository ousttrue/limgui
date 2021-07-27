-- generated from imgui_internal.h
local ffi = require 'ffi'
ffi.cdef[[
struct ImGuiDockRequest;
struct ImGuiDockNodeSettings;
typedef int ImGuiDataAuthority;
typedef int ImGuiLayoutType;
typedef int ImGuiItemFlags;
typedef int ImGuiItemStatusFlags;
typedef int ImGuiOldColumnFlags;
typedef int ImGuiNavMoveFlags;
typedef int ImGuiNextItemDataFlags;
typedef int ImGuiNextWindowDataFlags;
typedef FILE* ImFileHandle;
struct ImVec1{
    float x;
};
struct ImVec2ih{
    short x;
    short y;
};
struct ImRect{
    struct ImVec2 Min;
    struct ImVec2 Max;
};
struct ImVec2 ImRect_GetCenter(
    struct ImRect* this
) asm("?GetCenter@ImRect@@QEBA?AUImVec2@@XZ");
struct ImVec2 ImRect_GetSize(
    struct ImRect* this
) asm("?GetSize@ImRect@@QEBA?AUImVec2@@XZ");
float ImRect_GetWidth(
    struct ImRect* this
) asm("?GetWidth@ImRect@@QEBAMXZ");
float ImRect_GetHeight(
    struct ImRect* this
) asm("?GetHeight@ImRect@@QEBAMXZ");
float ImRect_GetArea(
    struct ImRect* this
) asm("?GetArea@ImRect@@QEBAMXZ");
struct ImVec2 ImRect_GetTL(
    struct ImRect* this
) asm("?GetTL@ImRect@@QEBA?AUImVec2@@XZ");
struct ImVec2 ImRect_GetTR(
    struct ImRect* this
) asm("?GetTR@ImRect@@QEBA?AUImVec2@@XZ");
struct ImVec2 ImRect_GetBL(
    struct ImRect* this
) asm("?GetBL@ImRect@@QEBA?AUImVec2@@XZ");
struct ImVec2 ImRect_GetBR(
    struct ImRect* this
) asm("?GetBR@ImRect@@QEBA?AUImVec2@@XZ");
bool ImRect_Contains(
    struct ImRect* this,
    const struct ImVec2* p
) asm("?Contains@ImRect@@QEBA_NAEBUImVec2@@@Z");
bool ImRect_Contains(
    struct ImRect* this,
    const struct ImRect* r
) asm("?Contains@ImRect@@QEBA_NAEBU1@@Z");
bool ImRect_Overlaps(
    struct ImRect* this,
    const struct ImRect* r
) asm("?Overlaps@ImRect@@QEBA_NAEBU1@@Z");
void ImRect_Add(
    struct ImRect* this,
    const struct ImVec2* p
) asm("?Add@ImRect@@QEAAXAEBUImVec2@@@Z");
void ImRect_Add(
    struct ImRect* this,
    const struct ImRect* r
) asm("?Add@ImRect@@QEAAXAEBU1@@Z");
void ImRect_Expand(
    struct ImRect* this,
    float amount
) asm("?Expand@ImRect@@QEAAXM@Z");
void ImRect_Expand(
    struct ImRect* this,
    const struct ImVec2* amount
) asm("?Expand@ImRect@@QEAAXAEBUImVec2@@@Z");
void ImRect_Translate(
    struct ImRect* this,
    const struct ImVec2* d
) asm("?Translate@ImRect@@QEAAXAEBUImVec2@@@Z");
void ImRect_TranslateX(
    struct ImRect* this,
    float dx
) asm("?TranslateX@ImRect@@QEAAXM@Z");
void ImRect_TranslateY(
    struct ImRect* this,
    float dy
) asm("?TranslateY@ImRect@@QEAAXM@Z");
void ImRect_ClipWith(
    struct ImRect* this,
    const struct ImRect* r
) asm("?ClipWith@ImRect@@QEAAXAEBU1@@Z");
void ImRect_ClipWithFull(
    struct ImRect* this,
    const struct ImRect* r
) asm("?ClipWithFull@ImRect@@QEAAXAEBU1@@Z");
void ImRect_Floor(
    struct ImRect* this
) asm("?Floor@ImRect@@QEAAXXZ");
bool ImRect_IsInverted(
    struct ImRect* this
) asm("?IsInverted@ImRect@@QEBA_NXZ");
struct ImVec4 ImRect_ToVec4(
    struct ImRect* this
) asm("?ToVec4@ImRect@@QEBA?AUImVec4@@XZ");
struct ImSpan{
    void* Data;
    void* DataEnd;
};
typedef int ImPoolIdx;
struct ImPool{
    struct ImVector Buf;
    struct ImGuiStorage Map;
    ImPoolIdx FreeIdx;
    ImPoolIdx AliveCount;
};
struct ImChunkStream{
    struct ImVector Buf;
};
struct ImDrawListSharedData{
    struct ImVec2 TexUvWhitePixel;
    struct ImFont* Font;
    float FontSize;
    float CurveTessellationTol;
    float CircleSegmentMaxError;
    struct ImVec4 ClipRectFullscreen;
    ImDrawListFlags InitialFlags;
    struct ImVec2 ArcFastVtx;
    float ArcFastRadiusCutoff;
    ImU8 CircleSegmentCounts;
    const struct ImVec4* TexUvLines;
};
void ImDrawListSharedData_SetCircleTessellationMaxError(
    struct ImDrawListSharedData* this,
    float max_error
) asm("?SetCircleTessellationMaxError@ImDrawListSharedData@@QEAAXM@Z");
struct ImDrawDataBuilder{
    struct ImDrawList Layers;
};
void ImDrawDataBuilder_FlattenIntoSingleLayer(
    struct ImDrawDataBuilder* this
) asm("?FlattenIntoSingleLayer@ImDrawDataBuilder@@QEAAXXZ");
enum ImGuiItemFlags_{
    ImGuiItemFlags_None = 0,
    ImGuiItemFlags_NoTabStop = 1 << 0,
    ImGuiItemFlags_ButtonRepeat = 1 << 1,
    ImGuiItemFlags_Disabled = 1 << 2,
    ImGuiItemFlags_NoNav = 1 << 3,
    ImGuiItemFlags_NoNavDefaultFocus = 1 << 4,
    ImGuiItemFlags_SelectableDontClosePopup = 1 << 5,
    ImGuiItemFlags_MixedValue = 1 << 6,
    ImGuiItemFlags_ReadOnly = 1 << 7,
};
enum ImGuiItemAddFlags_{
    ImGuiItemAddFlags_None = 0,
    ImGuiItemAddFlags_Focusable = 1 << 0,
};
enum ImGuiItemStatusFlags_{
    ImGuiItemStatusFlags_None = 0,
    ImGuiItemStatusFlags_HoveredRect = 1 << 0,
    ImGuiItemStatusFlags_HasDisplayRect = 1 << 1,
    ImGuiItemStatusFlags_Edited = 1 << 2,
    ImGuiItemStatusFlags_ToggledSelection = 1 << 3,
    ImGuiItemStatusFlags_ToggledOpen = 1 << 4,
    ImGuiItemStatusFlags_HasDeactivated = 1 << 5,
    ImGuiItemStatusFlags_Deactivated = 1 << 6,
    ImGuiItemStatusFlags_HoveredWindow = 1 << 7,
    ImGuiItemStatusFlags_FocusedByCode = 1 << 8,
    ImGuiItemStatusFlags_FocusedByTabbing = 1 << 9,
    ImGuiItemStatusFlags_Focused = ImGuiItemStatusFlags_FocusedByCode | ImGuiItemStatusFlags_FocusedByTabbing,
};
enum ImGuiInputTextFlagsPrivate_{
    ImGuiInputTextFlags_Multiline = 1 << 26,
    ImGuiInputTextFlags_NoMarkEdited = 1 << 27,
    ImGuiInputTextFlags_MergedItem = 1 << 28,
};
enum ImGuiButtonFlagsPrivate_{
    ImGuiButtonFlags_PressedOnClick = 1 << 4,
    ImGuiButtonFlags_PressedOnClickRelease = 1 << 5,
    ImGuiButtonFlags_PressedOnClickReleaseAnywhere = 1 << 6,
    ImGuiButtonFlags_PressedOnRelease = 1 << 7,
    ImGuiButtonFlags_PressedOnDoubleClick = 1 << 8,
    ImGuiButtonFlags_PressedOnDragDropHold = 1 << 9,
    ImGuiButtonFlags_Repeat = 1 << 10,
    ImGuiButtonFlags_FlattenChildren = 1 << 11,
    ImGuiButtonFlags_AllowItemOverlap = 1 << 12,
    ImGuiButtonFlags_DontClosePopups = 1 << 13,
    ImGuiButtonFlags_AlignTextBaseLine = 1 << 15,
    ImGuiButtonFlags_NoKeyModifiers = 1 << 16,
    ImGuiButtonFlags_NoHoldingActiveId = 1 << 17,
    ImGuiButtonFlags_NoNavFocus = 1 << 18,
    ImGuiButtonFlags_NoHoveredOnFocus = 1 << 19,
    ImGuiButtonFlags_PressedOnMask_ = ImGuiButtonFlags_PressedOnClick | ImGuiButtonFlags_PressedOnClickRelease | ImGuiButtonFlags_PressedOnClickReleaseAnywhere | ImGuiButtonFlags_PressedOnRelease | ImGuiButtonFlags_PressedOnDoubleClick | ImGuiButtonFlags_PressedOnDragDropHold,
    ImGuiButtonFlags_PressedOnDefault_ = ImGuiButtonFlags_PressedOnClickRelease,
};
enum ImGuiComboFlagsPrivate_{
    ImGuiComboFlags_CustomPreview = 1 << 20,
};
enum ImGuiSliderFlagsPrivate_{
    ImGuiSliderFlags_Vertical = 1 << 20,
    ImGuiSliderFlags_ReadOnly = 1 << 21,
};
enum ImGuiSelectableFlagsPrivate_{
    ImGuiSelectableFlags_NoHoldingActiveID = 1 << 20,
    ImGuiSelectableFlags_SelectOnNav = 1 << 21,
    ImGuiSelectableFlags_SelectOnClick = 1 << 22,
    ImGuiSelectableFlags_SelectOnRelease = 1 << 23,
    ImGuiSelectableFlags_SpanAvailWidth = 1 << 24,
    ImGuiSelectableFlags_DrawHoveredWhenHeld = 1 << 25,
    ImGuiSelectableFlags_SetNavIdOnHover = 1 << 26,
    ImGuiSelectableFlags_NoPadWithHalfSpacing = 1 << 27,
};
enum ImGuiTreeNodeFlagsPrivate_{
    ImGuiTreeNodeFlags_ClipLabelForTrailingButton = 1 << 20,
};
enum ImGuiSeparatorFlags_{
    ImGuiSeparatorFlags_None = 0,
    ImGuiSeparatorFlags_Horizontal = 1 << 0,
    ImGuiSeparatorFlags_Vertical = 1 << 1,
    ImGuiSeparatorFlags_SpanAllColumns = 1 << 2,
};
enum ImGuiTextFlags_{
    ImGuiTextFlags_None = 0,
    ImGuiTextFlags_NoWidthForLargeClippedText = 1 << 0,
};
enum ImGuiTooltipFlags_{
    ImGuiTooltipFlags_None = 0,
    ImGuiTooltipFlags_OverridePreviousTooltip = 1 << 0,
};
enum ImGuiLayoutType_{
    ImGuiLayoutType_Horizontal = 0,
    ImGuiLayoutType_Vertical = 1,
};
enum ImGuiLogType{
    ImGuiLogType_None = 0,
    ImGuiLogType_TTY = 1,
    ImGuiLogType_File = 2,
    ImGuiLogType_Buffer = 3,
    ImGuiLogType_Clipboard = 4,
};
enum ImGuiAxis{
    ImGuiAxis_None = -1,
    ImGuiAxis_X = 0,
    ImGuiAxis_Y = 1,
};
enum ImGuiPlotType{
    ImGuiPlotType_Lines = 0,
    ImGuiPlotType_Histogram = 1,
};
enum ImGuiInputSource{
    ImGuiInputSource_None = 0,
    ImGuiInputSource_Mouse = 1,
    ImGuiInputSource_Keyboard = 2,
    ImGuiInputSource_Gamepad = 3,
    ImGuiInputSource_Nav = 4,
    ImGuiInputSource_Clipboard = 5,
    ImGuiInputSource_COUNT = 6,
};
enum ImGuiInputReadMode{
    ImGuiInputReadMode_Down = 0,
    ImGuiInputReadMode_Pressed = 1,
    ImGuiInputReadMode_Released = 2,
    ImGuiInputReadMode_Repeat = 3,
    ImGuiInputReadMode_RepeatSlow = 4,
    ImGuiInputReadMode_RepeatFast = 5,
};
enum ImGuiNavHighlightFlags_{
    ImGuiNavHighlightFlags_None = 0,
    ImGuiNavHighlightFlags_TypeDefault = 1 << 0,
    ImGuiNavHighlightFlags_TypeThin = 1 << 1,
    ImGuiNavHighlightFlags_AlwaysDraw = 1 << 2,
    ImGuiNavHighlightFlags_NoRounding = 1 << 3,
};
enum ImGuiNavDirSourceFlags_{
    ImGuiNavDirSourceFlags_None = 0,
    ImGuiNavDirSourceFlags_Keyboard = 1 << 0,
    ImGuiNavDirSourceFlags_PadDPad = 1 << 1,
    ImGuiNavDirSourceFlags_PadLStick = 1 << 2,
};
enum ImGuiNavMoveFlags_{
    ImGuiNavMoveFlags_None = 0,
    ImGuiNavMoveFlags_LoopX = 1 << 0,
    ImGuiNavMoveFlags_LoopY = 1 << 1,
    ImGuiNavMoveFlags_WrapX = 1 << 2,
    ImGuiNavMoveFlags_WrapY = 1 << 3,
    ImGuiNavMoveFlags_AllowCurrentNavId = 1 << 4,
    ImGuiNavMoveFlags_AlsoScoreVisibleSet = 1 << 5,
    ImGuiNavMoveFlags_ScrollToEdge = 1 << 6,
};
enum ImGuiNavForward{
    ImGuiNavForward_None = 0,
    ImGuiNavForward_ForwardQueued = 1,
    ImGuiNavForward_ForwardActive = 2,
};
enum ImGuiNavLayer{
    ImGuiNavLayer_Main = 0,
    ImGuiNavLayer_Menu = 1,
    ImGuiNavLayer_COUNT = 2,
};
enum ImGuiPopupPositionPolicy{
    ImGuiPopupPositionPolicy_Default = 0,
    ImGuiPopupPositionPolicy_ComboBox = 1,
    ImGuiPopupPositionPolicy_Tooltip = 2,
};
enum ImGuiDataTypePrivate_{
    ImGuiDataType_String = ImGuiDataType_COUNT + 1,
    ImGuiDataType_Pointer = 12,
    ImGuiDataType_ID = 13,
};
struct ImGuiColorMod{
    ImGuiCol Col;
    struct ImVec4 BackupValue;
};
struct ImGuiStyleMod{
    ImGuiStyleVar VarIdx;
};
struct ImGuiComboPreviewData{
    struct ImRect PreviewRect;
    struct ImVec2 BackupCursorPos;
    struct ImVec2 BackupCursorMaxPos;
    struct ImVec2 BackupCursorPosPrevLine;
    float BackupPrevLineTextBaseOffset;
    ImGuiLayoutType BackupLayout;
};
struct ImGuiGroupData{
    ImGuiID WindowID;
    struct ImVec2 BackupCursorPos;
    struct ImVec2 BackupCursorMaxPos;
    struct ImVec1 BackupIndent;
    struct ImVec1 BackupGroupOffset;
    struct ImVec2 BackupCurrLineSize;
    float BackupCurrLineTextBaseOffset;
    ImGuiID BackupActiveIdIsAlive;
    bool BackupActiveIdPreviousFrameIsAlive;
    bool BackupHoveredIdIsAlive;
    bool EmitItem;
};
struct ImGuiMenuColumns{
    ImU32 TotalWidth;
    ImU32 NextTotalWidth;
    ImU16 Spacing;
    ImU16 OffsetIcon;
    ImU16 OffsetLabel;
    ImU16 OffsetShortcut;
    ImU16 OffsetMark;
    ImU16 Widths;
};
void ImGuiMenuColumns_Update(
    struct ImGuiMenuColumns* this,
    float spacing,
    bool window_reappearing
) asm("?Update@ImGuiMenuColumns@@QEAAXM_N@Z");
float ImGuiMenuColumns_DeclColumns(
    struct ImGuiMenuColumns* this,
    float w_icon,
    float w_label,
    float w_shortcut,
    float w_mark
) asm("?DeclColumns@ImGuiMenuColumns@@QEAAMMMMM@Z");
void ImGuiMenuColumns_CalcNextTotalWidth(
    struct ImGuiMenuColumns* this,
    bool update_offsets
) asm("?CalcNextTotalWidth@ImGuiMenuColumns@@QEAAX_N@Z");
struct ImGuiInputTextState{
    ImGuiID ID;
    int CurLenW;
    int CurLenA;
    struct ImVector TextW;
    struct ImVector TextA;
    struct ImVector InitialTextA;
    bool TextAIsValid;
    int BufCapacityA;
    float ScrollX;
    STB_TexteditState Stb;
    float CursorAnim;
    bool CursorFollow;
    bool SelectedAllMouseLock;
    bool Edited;
    ImGuiInputTextFlags Flags;
    ImGuiInputTextCallback UserCallback;
    void* UserCallbackData;
};
void ImGuiInputTextState_ClearText(
    struct ImGuiInputTextState* this
) asm("?ClearText@ImGuiInputTextState@@QEAAXXZ");
void ImGuiInputTextState_ClearFreeMemory(
    struct ImGuiInputTextState* this
) asm("?ClearFreeMemory@ImGuiInputTextState@@QEAAXXZ");
int ImGuiInputTextState_GetUndoAvailCount(
    struct ImGuiInputTextState* this
) asm("?GetUndoAvailCount@ImGuiInputTextState@@QEBAHXZ");
int ImGuiInputTextState_GetRedoAvailCount(
    struct ImGuiInputTextState* this
) asm("?GetRedoAvailCount@ImGuiInputTextState@@QEBAHXZ");
void ImGuiInputTextState_OnKeyPressed(
    struct ImGuiInputTextState* this,
    int key
) asm("?OnKeyPressed@ImGuiInputTextState@@QEAAXH@Z");
void ImGuiInputTextState_CursorAnimReset(
    struct ImGuiInputTextState* this
) asm("?CursorAnimReset@ImGuiInputTextState@@QEAAXXZ");
void ImGuiInputTextState_CursorClamp(
    struct ImGuiInputTextState* this
) asm("?CursorClamp@ImGuiInputTextState@@QEAAXXZ");
bool ImGuiInputTextState_HasSelection(
    struct ImGuiInputTextState* this
) asm("?HasSelection@ImGuiInputTextState@@QEBA_NXZ");
void ImGuiInputTextState_ClearSelection(
    struct ImGuiInputTextState* this
) asm("?ClearSelection@ImGuiInputTextState@@QEAAXXZ");
int ImGuiInputTextState_GetCursorPos(
    struct ImGuiInputTextState* this
) asm("?GetCursorPos@ImGuiInputTextState@@QEBAHXZ");
int ImGuiInputTextState_GetSelectionStart(
    struct ImGuiInputTextState* this
) asm("?GetSelectionStart@ImGuiInputTextState@@QEBAHXZ");
int ImGuiInputTextState_GetSelectionEnd(
    struct ImGuiInputTextState* this
) asm("?GetSelectionEnd@ImGuiInputTextState@@QEBAHXZ");
void ImGuiInputTextState_SelectAll(
    struct ImGuiInputTextState* this
) asm("?SelectAll@ImGuiInputTextState@@QEAAXXZ");
struct ImGuiPopupData{
    ImGuiID PopupId;
    struct ImGuiWindow* Window;
    struct ImGuiWindow* SourceWindow;
    int OpenFrameCount;
    ImGuiID OpenParentId;
    struct ImVec2 OpenPopupPos;
    struct ImVec2 OpenMousePos;
};
struct ImGuiNavItemData{
    struct ImGuiWindow* Window;
    ImGuiID ID;
    ImGuiID FocusScopeId;
    struct ImRect RectRel;
    float DistBox;
    float DistCenter;
    float DistAxial;
};
enum ImGuiNextWindowDataFlags_{
    ImGuiNextWindowDataFlags_None = 0,
    ImGuiNextWindowDataFlags_HasPos = 1 << 0,
    ImGuiNextWindowDataFlags_HasSize = 1 << 1,
    ImGuiNextWindowDataFlags_HasContentSize = 1 << 2,
    ImGuiNextWindowDataFlags_HasCollapsed = 1 << 3,
    ImGuiNextWindowDataFlags_HasSizeConstraint = 1 << 4,
    ImGuiNextWindowDataFlags_HasFocus = 1 << 5,
    ImGuiNextWindowDataFlags_HasBgAlpha = 1 << 6,
    ImGuiNextWindowDataFlags_HasScroll = 1 << 7,
    ImGuiNextWindowDataFlags_HasViewport = 1 << 8,
    ImGuiNextWindowDataFlags_HasDock = 1 << 9,
    ImGuiNextWindowDataFlags_HasWindowClass = 1 << 10,
};
struct ImGuiNextWindowData{
    ImGuiNextWindowDataFlags Flags;
    ImGuiCond PosCond;
    ImGuiCond SizeCond;
    ImGuiCond CollapsedCond;
    ImGuiCond DockCond;
    struct ImVec2 PosVal;
    struct ImVec2 PosPivotVal;
    struct ImVec2 SizeVal;
    struct ImVec2 ContentSizeVal;
    struct ImVec2 ScrollVal;
    bool PosUndock;
    bool CollapsedVal;
    struct ImRect SizeConstraintRect;
    ImGuiSizeCallback SizeCallback;
    void* SizeCallbackUserData;
    float BgAlphaVal;
    ImGuiID ViewportId;
    ImGuiID DockId;
    struct ImGuiWindowClass WindowClass;
    struct ImVec2 MenuBarOffsetMinVal;
};
enum ImGuiNextItemDataFlags_{
    ImGuiNextItemDataFlags_None = 0,
    ImGuiNextItemDataFlags_HasWidth = 1 << 0,
    ImGuiNextItemDataFlags_HasOpen = 1 << 1,
};
struct ImGuiNextItemData{
    ImGuiNextItemDataFlags Flags;
    float Width;
    ImGuiID FocusScopeId;
    ImGuiCond OpenCond;
    bool OpenVal;
};
struct ImGuiLastItemData{
    ImGuiID ID;
    ImGuiItemFlags InFlags;
    ImGuiItemStatusFlags StatusFlags;
    struct ImRect Rect;
    struct ImRect DisplayRect;
};
struct ImGuiWindowStackData{
    struct ImGuiWindow* Window;
    struct ImGuiLastItemData ParentLastItemDataBackup;
};
struct ImGuiShrinkWidthItem{
    int Index;
    float Width;
};
struct ImGuiPtrOrIndex{
    void* Ptr;
    int Index;
};
enum ImGuiOldColumnFlags_{
    ImGuiOldColumnFlags_None = 0,
    ImGuiOldColumnFlags_NoBorder = 1 << 0,
    ImGuiOldColumnFlags_NoResize = 1 << 1,
    ImGuiOldColumnFlags_NoPreserveWidths = 1 << 2,
    ImGuiOldColumnFlags_NoForceWithinWindow = 1 << 3,
    ImGuiOldColumnFlags_GrowParentContentsSize = 1 << 4,
    ImGuiColumnsFlags_None = ImGuiOldColumnFlags_None,
    ImGuiColumnsFlags_NoBorder = ImGuiOldColumnFlags_NoBorder,
    ImGuiColumnsFlags_NoResize = ImGuiOldColumnFlags_NoResize,
    ImGuiColumnsFlags_NoPreserveWidths = ImGuiOldColumnFlags_NoPreserveWidths,
    ImGuiColumnsFlags_NoForceWithinWindow = ImGuiOldColumnFlags_NoForceWithinWindow,
    ImGuiColumnsFlags_GrowParentContentsSize = ImGuiOldColumnFlags_GrowParentContentsSize,
};
struct ImGuiOldColumnData{
    float OffsetNorm;
    float OffsetNormBeforeResize;
    ImGuiOldColumnFlags Flags;
    struct ImRect ClipRect;
};
struct ImGuiOldColumns{
    ImGuiID ID;
    ImGuiOldColumnFlags Flags;
    bool IsFirstFrame;
    bool IsBeingResized;
    int Current;
    int Count;
    float OffMinX;
    float OffMaxX;
    float LineMinY;
    float LineMaxY;
    float HostCursorPosY;
    float HostCursorMaxPosX;
    struct ImRect HostInitialClipRect;
    struct ImRect HostBackupClipRect;
    struct ImRect HostBackupParentWorkRect;
    struct ImVector Columns;
    struct ImDrawListSplitter Splitter;
};
enum ImGuiDockNodeFlagsPrivate_{
    ImGuiDockNodeFlags_DockSpace = 1 << 10,
    ImGuiDockNodeFlags_CentralNode = 1 << 11,
    ImGuiDockNodeFlags_NoTabBar = 1 << 12,
    ImGuiDockNodeFlags_HiddenTabBar = 1 << 13,
    ImGuiDockNodeFlags_NoWindowMenuButton = 1 << 14,
    ImGuiDockNodeFlags_NoCloseButton = 1 << 15,
    ImGuiDockNodeFlags_NoDocking = 1 << 16,
    ImGuiDockNodeFlags_NoDockingSplitMe = 1 << 17,
    ImGuiDockNodeFlags_NoDockingSplitOther = 1 << 18,
    ImGuiDockNodeFlags_NoDockingOverMe = 1 << 19,
    ImGuiDockNodeFlags_NoDockingOverOther = 1 << 20,
    ImGuiDockNodeFlags_NoDockingOverEmpty = 1 << 21,
    ImGuiDockNodeFlags_NoResizeX = 1 << 22,
    ImGuiDockNodeFlags_NoResizeY = 1 << 23,
    ImGuiDockNodeFlags_SharedFlagsInheritMask_ = ~0,
    ImGuiDockNodeFlags_NoResizeFlagsMask_ = ImGuiDockNodeFlags_NoResize | ImGuiDockNodeFlags_NoResizeX | ImGuiDockNodeFlags_NoResizeY,
    ImGuiDockNodeFlags_LocalFlagsMask_ = ImGuiDockNodeFlags_NoSplit | ImGuiDockNodeFlags_NoResizeFlagsMask_ | ImGuiDockNodeFlags_AutoHideTabBar | ImGuiDockNodeFlags_DockSpace | ImGuiDockNodeFlags_CentralNode | ImGuiDockNodeFlags_NoTabBar | ImGuiDockNodeFlags_HiddenTabBar | ImGuiDockNodeFlags_NoWindowMenuButton | ImGuiDockNodeFlags_NoCloseButton | ImGuiDockNodeFlags_NoDocking,
    ImGuiDockNodeFlags_LocalFlagsTransferMask_ = ImGuiDockNodeFlags_LocalFlagsMask_ & ~ ImGuiDockNodeFlags_DockSpace,
    ImGuiDockNodeFlags_SavedFlagsMask_ = ImGuiDockNodeFlags_NoResizeFlagsMask_ | ImGuiDockNodeFlags_DockSpace | ImGuiDockNodeFlags_CentralNode | ImGuiDockNodeFlags_NoTabBar | ImGuiDockNodeFlags_HiddenTabBar | ImGuiDockNodeFlags_NoWindowMenuButton | ImGuiDockNodeFlags_NoCloseButton | ImGuiDockNodeFlags_NoDocking,
};
enum ImGuiDataAuthority_{
    ImGuiDataAuthority_Auto = 0,
    ImGuiDataAuthority_DockNode = 1,
    ImGuiDataAuthority_Window = 2,
};
enum ImGuiDockNodeState{
    ImGuiDockNodeState_Unknown = 0,
    ImGuiDockNodeState_HostWindowHiddenBecauseSingleWindow = 1,
    ImGuiDockNodeState_HostWindowHiddenBecauseWindowsAreResizing = 2,
    ImGuiDockNodeState_HostWindowVisible = 3,
};
struct ImGuiDockNode{
    ImGuiID ID;
    ImGuiDockNodeFlags SharedFlags;
    ImGuiDockNodeFlags LocalFlags;
    ImGuiDockNodeFlags LocalFlagsInWindows;
    ImGuiDockNodeFlags MergedFlags;
    enum ImGuiDockNodeState State;
    struct ImGuiDockNode* ParentNode;
    struct ImVector ChildNodes;
    struct ImVector Windows;
    struct ImGuiTabBar* TabBar;
    struct ImVec2 Pos;
    struct ImVec2 Size;
    struct ImVec2 SizeRef;
    enum ImGuiAxis SplitAxis;
    struct ImGuiWindowClass WindowClass;
    struct ImGuiWindow* HostWindow;
    struct ImGuiWindow* VisibleWindow;
    struct ImGuiDockNode* CentralNode;
    struct ImGuiDockNode* OnlyNodeWithWindows;
    int LastFrameAlive;
    int LastFrameActive;
    int LastFrameFocused;
    ImGuiID LastFocusedNodeId;
    ImGuiID SelectedTabId;
    ImGuiID WantCloseTabId;
    ImGuiDataAuthority AuthorityForPos;
    ImGuiDataAuthority AuthorityForSize;
    ImGuiDataAuthority AuthorityForViewport;
    bool IsVisible;
    bool IsFocused;
    bool HasCloseButton;
    bool HasWindowMenuButton;
    bool WantCloseAll;
    bool WantLockSizeOnce;
    bool WantMouseMove;
    bool WantHiddenTabBarUpdate;
    bool WantHiddenTabBarToggle;
    bool MarkedForPosSizeWrite;
};
bool ImGuiDockNode_IsRootNode(
    struct ImGuiDockNode* this
) asm("?IsRootNode@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsDockSpace(
    struct ImGuiDockNode* this
) asm("?IsDockSpace@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsFloatingNode(
    struct ImGuiDockNode* this
) asm("?IsFloatingNode@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsCentralNode(
    struct ImGuiDockNode* this
) asm("?IsCentralNode@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsHiddenTabBar(
    struct ImGuiDockNode* this
) asm("?IsHiddenTabBar@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsNoTabBar(
    struct ImGuiDockNode* this
) asm("?IsNoTabBar@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsSplitNode(
    struct ImGuiDockNode* this
) asm("?IsSplitNode@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsLeafNode(
    struct ImGuiDockNode* this
) asm("?IsLeafNode@ImGuiDockNode@@QEBA_NXZ");
bool ImGuiDockNode_IsEmpty(
    struct ImGuiDockNode* this
) asm("?IsEmpty@ImGuiDockNode@@QEBA_NXZ");
struct ImRect ImGuiDockNode_Rect(
    struct ImGuiDockNode* this
) asm("?Rect@ImGuiDockNode@@QEBA?AUImRect@@XZ");
void ImGuiDockNode_SetLocalFlags(
    struct ImGuiDockNode* this,
    ImGuiDockNodeFlags flags
) asm("?SetLocalFlags@ImGuiDockNode@@QEAAXH@Z");
void ImGuiDockNode_UpdateMergedFlags(
    struct ImGuiDockNode* this
) asm("?UpdateMergedFlags@ImGuiDockNode@@QEAAXXZ");
enum ImGuiWindowDockStyleCol{
    ImGuiWindowDockStyleCol_Text = 0,
    ImGuiWindowDockStyleCol_Tab = 1,
    ImGuiWindowDockStyleCol_TabHovered = 2,
    ImGuiWindowDockStyleCol_TabActive = 3,
    ImGuiWindowDockStyleCol_TabUnfocused = 4,
    ImGuiWindowDockStyleCol_TabUnfocusedActive = 5,
    ImGuiWindowDockStyleCol_COUNT = 6,
};
struct ImGuiWindowDockStyle{
    ImU32 Colors;
};
struct ImGuiDockContext{
    struct ImGuiStorage Nodes;
    struct ImVector Requests;
    struct ImVector NodesSettings;
    bool WantFullRebuild;
};
struct ImGuiViewportP{
    int Idx;
    int LastFrameActive;
    int LastFrontMostStampCount;
    ImGuiID LastNameHash;
    struct ImVec2 LastPos;
    float Alpha;
    float LastAlpha;
    short PlatformMonitor;
    bool PlatformWindowCreated;
    struct ImGuiWindow* Window;
    int DrawListsLastFrame[2];
    struct ImDrawList DrawLists;
    struct ImDrawData DrawDataP;
    struct ImDrawDataBuilder DrawDataBuilder;
    struct ImVec2 LastPlatformPos;
    struct ImVec2 LastPlatformSize;
    struct ImVec2 LastRendererSize;
    struct ImVec2 WorkOffsetMin;
    struct ImVec2 WorkOffsetMax;
    struct ImVec2 BuildWorkOffsetMin;
    struct ImVec2 BuildWorkOffsetMax;
};
struct ImGuiWindowSettings{
    ImGuiID ID;
    struct ImVec2ih Pos;
    struct ImVec2ih Size;
    struct ImVec2ih ViewportPos;
    ImGuiID ViewportId;
    ImGuiID DockId;
    ImGuiID ClassId;
    short DockOrder;
    bool Collapsed;
    bool WantApply;
};
struct ImGuiSettingsHandler{
    const char* TypeName;
    ImGuiID TypeHash;
    void(*ClearAllFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler);
    void(*ReadInitFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler);
    void*(*ReadOpenFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler, const char* name);
    void(*ReadLineFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler, void* entry, const char* line);
    void(*ApplyAllFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler);
    void(*WriteAllFn)(struct ImGuiContext* ctx, struct ImGuiSettingsHandler* handler, struct ImGuiTextBuffer* out_buf);
    void* UserData;
};
struct ImGuiMetricsConfig{
    bool ShowWindowsRects;
    bool ShowWindowsBeginOrder;
    bool ShowTablesRects;
    bool ShowDrawCmdMesh;
    bool ShowDrawCmdBoundingBoxes;
    bool ShowDockingNodes;
    int ShowWindowsRectsType;
    int ShowTablesRectsType;
};
struct ImGuiStackSizes{
    short SizeOfIDStack;
    short SizeOfColorStack;
    short SizeOfStyleVarStack;
    short SizeOfFontStack;
    short SizeOfFocusScopeStack;
    short SizeOfGroupStack;
    short SizeOfBeginPopupStack;
};
void ImGuiStackSizes_SetToCurrentState(
    struct ImGuiStackSizes* this
) asm("?SetToCurrentState@ImGuiStackSizes@@QEAAXXZ");
void ImGuiStackSizes_CompareWithCurrentState(
    struct ImGuiStackSizes* this
) asm("?CompareWithCurrentState@ImGuiStackSizes@@QEAAXXZ");
typedef void(*ImGuiContextHookCallback)(struct ImGuiContext* ctx, struct ImGuiContextHook* hook);
enum ImGuiContextHookType{
    ImGuiContextHookType_NewFramePre = 0,
    ImGuiContextHookType_NewFramePost = 1,
    ImGuiContextHookType_EndFramePre = 2,
    ImGuiContextHookType_EndFramePost = 3,
    ImGuiContextHookType_RenderPre = 4,
    ImGuiContextHookType_RenderPost = 5,
    ImGuiContextHookType_Shutdown = 6,
    ImGuiContextHookType_PendingRemoval_ = 7,
};
struct ImGuiContextHook{
    ImGuiID HookId;
    enum ImGuiContextHookType Type;
    ImGuiID Owner;
    ImGuiContextHookCallback Callback;
    void* UserData;
};
struct ImGuiContext{
    bool Initialized;
    bool FontAtlasOwnedByContext;
    struct ImGuiIO IO;
    struct ImGuiPlatformIO PlatformIO;
    struct ImGuiStyle Style;
    ImGuiConfigFlags ConfigFlagsCurrFrame;
    ImGuiConfigFlags ConfigFlagsLastFrame;
    struct ImFont* Font;
    float FontSize;
    float FontBaseSize;
    struct ImDrawListSharedData DrawListSharedData;
    double Time;
    int FrameCount;
    int FrameCountEnded;
    int FrameCountPlatformEnded;
    int FrameCountRendered;
    bool WithinFrameScope;
    bool WithinFrameScopeWithImplicitWindow;
    bool WithinEndChild;
    bool GcCompactAll;
    bool TestEngineHookItems;
    ImGuiID TestEngineHookIdInfo;
    void* TestEngine;
    struct ImVector Windows;
    struct ImVector WindowsFocusOrder;
    struct ImVector WindowsTempSortBuffer;
    struct ImVector CurrentWindowStack;
    struct ImGuiStorage WindowsById;
    int WindowsActiveCount;
    struct ImVec2 WindowsHoverPadding;
    struct ImGuiWindow* CurrentWindow;
    struct ImGuiWindow* HoveredWindow;
    struct ImGuiWindow* HoveredWindowUnderMovingWindow;
    struct ImGuiDockNode* HoveredDockNode;
    struct ImGuiWindow* MovingWindow;
    struct ImGuiWindow* WheelingWindow;
    struct ImVec2 WheelingWindowRefMousePos;
    float WheelingWindowTimer;
    ImGuiID HoveredId;
    ImGuiID HoveredIdPreviousFrame;
    bool HoveredIdAllowOverlap;
    bool HoveredIdUsingMouseWheel;
    bool HoveredIdPreviousFrameUsingMouseWheel;
    bool HoveredIdDisabled;
    float HoveredIdTimer;
    float HoveredIdNotActiveTimer;
    ImGuiID ActiveId;
    ImGuiID ActiveIdIsAlive;
    float ActiveIdTimer;
    bool ActiveIdIsJustActivated;
    bool ActiveIdAllowOverlap;
    bool ActiveIdNoClearOnFocusLoss;
    bool ActiveIdHasBeenPressedBefore;
    bool ActiveIdHasBeenEditedBefore;
    bool ActiveIdHasBeenEditedThisFrame;
    bool ActiveIdUsingMouseWheel;
    ImU32 ActiveIdUsingNavDirMask;
    ImU32 ActiveIdUsingNavInputMask;
    ImU64 ActiveIdUsingKeyInputMask;
    struct ImVec2 ActiveIdClickOffset;
    struct ImGuiWindow* ActiveIdWindow;
    enum ImGuiInputSource ActiveIdSource;
    int ActiveIdMouseButton;
    ImGuiID ActiveIdPreviousFrame;
    bool ActiveIdPreviousFrameIsAlive;
    bool ActiveIdPreviousFrameHasBeenEditedBefore;
    struct ImGuiWindow* ActiveIdPreviousFrameWindow;
    ImGuiID LastActiveId;
    float LastActiveIdTimer;
    ImGuiItemFlags CurrentItemFlags;
    struct ImGuiNextItemData NextItemData;
    struct ImGuiLastItemData LastItemData;
    struct ImGuiNextWindowData NextWindowData;
    struct ImVector ColorStack;
    struct ImVector StyleVarStack;
    struct ImVector FontStack;
    struct ImVector FocusScopeStack;
    struct ImVector ItemFlagsStack;
    struct ImVector GroupStack;
    struct ImVector OpenPopupStack;
    struct ImVector BeginPopupStack;
    struct ImVector Viewports;
    float CurrentDpiScale;
    struct ImGuiViewportP* CurrentViewport;
    struct ImGuiViewportP* MouseViewport;
    struct ImGuiViewportP* MouseLastHoveredViewport;
    ImGuiID PlatformLastFocusedViewportId;
    struct ImGuiPlatformMonitor FallbackMonitor;
    int ViewportFrontMostStampCount;
    struct ImGuiWindow* NavWindow;
    ImGuiID NavId;
    ImGuiID NavFocusScopeId;
    ImGuiID NavActivateId;
    ImGuiID NavActivateDownId;
    ImGuiID NavActivatePressedId;
    ImGuiID NavInputId;
    ImGuiID NavJustTabbedId;
    ImGuiID NavJustMovedToId;
    ImGuiID NavJustMovedToFocusScopeId;
    ImGuiKeyModFlags NavJustMovedToKeyMods;
    ImGuiID NavNextActivateId;
    enum ImGuiInputSource NavInputSource;
    struct ImRect NavScoringRect;
    int NavScoringCount;
    enum ImGuiNavLayer NavLayer;
    int NavIdTabCounter;
    bool NavIdIsAlive;
    bool NavMousePosDirty;
    bool NavDisableHighlight;
    bool NavDisableMouseHover;
    bool NavAnyRequest;
    bool NavInitRequest;
    bool NavInitRequestFromMove;
    ImGuiID NavInitResultId;
    struct ImRect NavInitResultRectRel;
    bool NavMoveRequest;
    ImGuiNavMoveFlags NavMoveRequestFlags;
    enum ImGuiNavForward NavMoveRequestForward;
    ImGuiKeyModFlags NavMoveRequestKeyMods;
    ImGuiDir NavMoveDir;
    ImGuiDir NavMoveDirLast;
    ImGuiDir NavMoveClipDir;
    struct ImGuiNavItemData NavMoveResultLocal;
    struct ImGuiNavItemData NavMoveResultLocalVisibleSet;
    struct ImGuiNavItemData NavMoveResultOther;
    struct ImGuiWindow* NavWrapRequestWindow;
    ImGuiNavMoveFlags NavWrapRequestFlags;
    struct ImGuiWindow* NavWindowingTarget;
    struct ImGuiWindow* NavWindowingTargetAnim;
    struct ImGuiWindow* NavWindowingListWindow;
    float NavWindowingTimer;
    float NavWindowingHighlightAlpha;
    bool NavWindowingToggleLayer;
    struct ImGuiWindow* TabFocusRequestCurrWindow;
    struct ImGuiWindow* TabFocusRequestNextWindow;
    int TabFocusRequestCurrCounterRegular;
    int TabFocusRequestCurrCounterTabStop;
    int TabFocusRequestNextCounterRegular;
    int TabFocusRequestNextCounterTabStop;
    bool TabFocusPressed;
    float DimBgRatio;
    ImGuiMouseCursor MouseCursor;
    bool DragDropActive;
    bool DragDropWithinSource;
    bool DragDropWithinTarget;
    ImGuiDragDropFlags DragDropSourceFlags;
    int DragDropSourceFrameCount;
    int DragDropMouseButton;
    struct ImGuiPayload DragDropPayload;
    struct ImRect DragDropTargetRect;
    ImGuiID DragDropTargetId;
    ImGuiDragDropFlags DragDropAcceptFlags;
    float DragDropAcceptIdCurrRectSurface;
    ImGuiID DragDropAcceptIdCurr;
    ImGuiID DragDropAcceptIdPrev;
    int DragDropAcceptFrameCount;
    ImGuiID DragDropHoldJustPressedId;
    struct ImVector DragDropPayloadBufHeap;
    unsigned char DragDropPayloadBufLocal[16];
    struct ImGuiTable* CurrentTable;
    int CurrentTableStackIdx;
    struct ImPool Tables;
    struct ImVector TablesTempDataStack;
    struct ImVector TablesLastTimeActive;
    struct ImVector DrawChannelsTempMergeBuffer;
    struct ImGuiTabBar* CurrentTabBar;
    struct ImPool TabBars;
    struct ImVector CurrentTabBarStack;
    struct ImVector ShrinkWidthBuffer;
    struct ImVec2 LastValidMousePos;
    struct ImGuiInputTextState InputTextState;
    struct ImFont InputTextPasswordFont;
    ImGuiID TempInputId;
    ImGuiColorEditFlags ColorEditOptions;
    float ColorEditLastHue;
    float ColorEditLastSat;
    float ColorEditLastColor[3];
    struct ImVec4 ColorPickerRef;
    struct ImGuiComboPreviewData ComboPreviewData;
    float SliderCurrentAccum;
    bool SliderCurrentAccumDirty;
    bool DragCurrentAccumDirty;
    float DragCurrentAccum;
    float DragSpeedDefaultRatio;
    float ScrollbarClickDeltaToGrabCenter;
    int TooltipOverrideCount;
    float TooltipSlowDelay;
    struct ImVector ClipboardHandlerData;
    struct ImVector MenusIdSubmittedThisFrame;
    struct ImVec2 PlatformImePos;
    struct ImVec2 PlatformImeLastPos;
    struct ImGuiViewportP* PlatformImePosViewport;
    char PlatformLocaleDecimalPoint;
    struct ImGuiDockContext DockContext;
    bool SettingsLoaded;
    float SettingsDirtyTimer;
    struct ImGuiTextBuffer SettingsIniData;
    struct ImVector SettingsHandlers;
    struct ImChunkStream SettingsWindows;
    struct ImChunkStream SettingsTables;
    struct ImVector Hooks;
    ImGuiID HookIdNext;
    bool LogEnabled;
    enum ImGuiLogType LogType;
    ImFileHandle LogFile;
    struct ImGuiTextBuffer LogBuffer;
    const char* LogNextPrefix;
    const char* LogNextSuffix;
    float LogLinePosY;
    bool LogLineFirstItem;
    int LogDepthRef;
    int LogDepthToExpand;
    int LogDepthToExpandDefault;
    bool DebugItemPickerActive;
    ImGuiID DebugItemPickerBreakId;
    struct ImGuiMetricsConfig DebugMetricsConfig;
    float FramerateSecPerFrame[120];
    int FramerateSecPerFrameIdx;
    int FramerateSecPerFrameCount;
    float FramerateSecPerFrameAccum;
    int WantCaptureMouseNextFrame;
    int WantCaptureKeyboardNextFrame;
    int WantTextInputNextFrame;
    char TempBuffer[3073];
};
struct ImGuiWindowTempData{
    struct ImVec2 CursorPos;
    struct ImVec2 CursorPosPrevLine;
    struct ImVec2 CursorStartPos;
    struct ImVec2 CursorMaxPos;
    struct ImVec2 IdealMaxPos;
    struct ImVec2 CurrLineSize;
    struct ImVec2 PrevLineSize;
    float CurrLineTextBaseOffset;
    float PrevLineTextBaseOffset;
    struct ImVec1 Indent;
    struct ImVec1 ColumnsOffset;
    struct ImVec1 GroupOffset;
    enum ImGuiNavLayer NavLayerCurrent;
    short NavLayersActiveMask;
    short NavLayersActiveMaskNext;
    ImGuiID NavFocusScopeIdCurrent;
    bool NavHideHighlightOneFrame;
    bool NavHasScroll;
    bool MenuBarAppending;
    struct ImVec2 MenuBarOffset;
    struct ImGuiMenuColumns MenuColumns;
    int TreeDepth;
    ImU32 TreeJumpToParentOnPopMask;
    struct ImVector ChildWindows;
    struct ImGuiStorage* StateStorage;
    struct ImGuiOldColumns* CurrentColumns;
    int CurrentTableIdx;
    ImGuiLayoutType LayoutType;
    ImGuiLayoutType ParentLayoutType;
    int FocusCounterRegular;
    int FocusCounterTabStop;
    float ItemWidth;
    float TextWrapPos;
    struct ImVector ItemWidthStack;
    struct ImVector TextWrapPosStack;
    struct ImGuiStackSizes StackSizesOnBegin;
};
struct ImGuiWindow{
    char* Name;
    ImGuiID ID;
    ImGuiWindowFlags Flags;
    ImGuiWindowFlags FlagsPreviousFrame;
    struct ImGuiWindowClass WindowClass;
    struct ImGuiViewportP* Viewport;
    ImGuiID ViewportId;
    struct ImVec2 ViewportPos;
    int ViewportAllowPlatformMonitorExtend;
    struct ImVec2 Pos;
    struct ImVec2 Size;
    struct ImVec2 SizeFull;
    struct ImVec2 ContentSize;
    struct ImVec2 ContentSizeIdeal;
    struct ImVec2 ContentSizeExplicit;
    struct ImVec2 WindowPadding;
    float WindowRounding;
    float WindowBorderSize;
    int NameBufLen;
    ImGuiID MoveId;
    ImGuiID ChildId;
    struct ImVec2 Scroll;
    struct ImVec2 ScrollMax;
    struct ImVec2 ScrollTarget;
    struct ImVec2 ScrollTargetCenterRatio;
    struct ImVec2 ScrollTargetEdgeSnapDist;
    struct ImVec2 ScrollbarSizes;
    bool ScrollbarX;
    bool ScrollbarY;
    bool ViewportOwned;
    bool Active;
    bool WasActive;
    bool WriteAccessed;
    bool Collapsed;
    bool WantCollapseToggle;
    bool SkipItems;
    bool Appearing;
    bool Hidden;
    bool IsFallbackWindow;
    bool HasCloseButton;
    char ResizeBorderHeld;
    short BeginCount;
    short BeginOrderWithinParent;
    short BeginOrderWithinContext;
    short FocusOrder;
    ImGuiID PopupId;
    ImS8 AutoFitFramesX;
    ImS8 AutoFitFramesY;
    ImS8 AutoFitChildAxises;
    bool AutoFitOnlyGrows;
    ImGuiDir AutoPosLastDirection;
    ImS8 HiddenFramesCanSkipItems;
    ImS8 HiddenFramesCannotSkipItems;
    ImS8 HiddenFramesForRenderOnly;
    ImS8 DisableInputsFrames;
    ImGuiCond SetWindowPosAllowFlags;
    ImGuiCond SetWindowSizeAllowFlags;
    ImGuiCond SetWindowCollapsedAllowFlags;
    ImGuiCond SetWindowDockAllowFlags;
    struct ImVec2 SetWindowPosVal;
    struct ImVec2 SetWindowPosPivot;
    struct ImVector IDStack;
    struct ImGuiWindowTempData DC;
    struct ImRect OuterRectClipped;
    struct ImRect InnerRect;
    struct ImRect InnerClipRect;
    struct ImRect WorkRect;
    struct ImRect ParentWorkRect;
    struct ImRect ClipRect;
    struct ImRect ContentRegionRect;
    struct ImVec2ih HitTestHoleSize;
    struct ImVec2ih HitTestHoleOffset;
    int LastFrameActive;
    int LastFrameJustFocused;
    float LastTimeActive;
    float ItemWidthDefault;
    struct ImGuiStorage StateStorage;
    struct ImVector ColumnsStorage;
    float FontWindowScale;
    float FontDpiScale;
    int SettingsOffset;
    struct ImDrawList* DrawList;
    struct ImDrawList DrawListInst;
    struct ImGuiWindow* ParentWindow;
    struct ImGuiWindow* RootWindow;
    struct ImGuiWindow* RootWindowDockTree;
    struct ImGuiWindow* RootWindowForTitleBarHighlight;
    struct ImGuiWindow* RootWindowForNav;
    struct ImGuiWindow* NavLastChildNavWindow;
    ImGuiID NavLastIds;
    struct ImRect NavRectRel;
    int MemoryDrawListIdxCapacity;
    int MemoryDrawListVtxCapacity;
    bool MemoryCompacted;
    bool DockIsActive;
    bool DockNodeIsVisible;
    bool DockTabIsVisible;
    bool DockTabWantClose;
    short DockOrder;
    struct ImGuiWindowDockStyle DockStyle;
    struct ImGuiDockNode* DockNode;
    struct ImGuiDockNode* DockNodeAsHost;
    ImGuiID DockId;
    ImGuiItemStatusFlags DockTabItemStatusFlags;
    struct ImRect DockTabItemRect;
};
ImGuiID ImGuiWindow_GetID(
    struct ImGuiWindow* this,
    const char* str,
    const char* str_end
) asm("?GetID@ImGuiWindow@@QEAAIPEBD0@Z");
ImGuiID ImGuiWindow_GetID(
    struct ImGuiWindow* this,
    const void* ptr
) asm("?GetID@ImGuiWindow@@QEAAIPEBX@Z");
ImGuiID ImGuiWindow_GetID(
    struct ImGuiWindow* this,
    int n
) asm("?GetID@ImGuiWindow@@QEAAIH@Z");
ImGuiID ImGuiWindow_GetIDNoKeepAlive(
    struct ImGuiWindow* this,
    const char* str,
    const char* str_end
) asm("?GetIDNoKeepAlive@ImGuiWindow@@QEAAIPEBD0@Z");
ImGuiID ImGuiWindow_GetIDNoKeepAlive(
    struct ImGuiWindow* this,
    const void* ptr
) asm("?GetIDNoKeepAlive@ImGuiWindow@@QEAAIPEBX@Z");
ImGuiID ImGuiWindow_GetIDNoKeepAlive(
    struct ImGuiWindow* this,
    int n
) asm("?GetIDNoKeepAlive@ImGuiWindow@@QEAAIH@Z");
ImGuiID ImGuiWindow_GetIDFromRectangle(
    struct ImGuiWindow* this,
    const struct ImRect* r_abs
) asm("?GetIDFromRectangle@ImGuiWindow@@QEAAIAEBUImRect@@@Z");
struct ImRect ImGuiWindow_Rect(
    struct ImGuiWindow* this
) asm("?Rect@ImGuiWindow@@QEBA?AUImRect@@XZ");
float ImGuiWindow_CalcFontSize(
    struct ImGuiWindow* this
) asm("?CalcFontSize@ImGuiWindow@@QEBAMXZ");
float ImGuiWindow_TitleBarHeight(
    struct ImGuiWindow* this
) asm("?TitleBarHeight@ImGuiWindow@@QEBAMXZ");
struct ImRect ImGuiWindow_TitleBarRect(
    struct ImGuiWindow* this
) asm("?TitleBarRect@ImGuiWindow@@QEBA?AUImRect@@XZ");
float ImGuiWindow_MenuBarHeight(
    struct ImGuiWindow* this
) asm("?MenuBarHeight@ImGuiWindow@@QEBAMXZ");
struct ImRect ImGuiWindow_MenuBarRect(
    struct ImGuiWindow* this
) asm("?MenuBarRect@ImGuiWindow@@QEBA?AUImRect@@XZ");
enum ImGuiTabBarFlagsPrivate_{
    ImGuiTabBarFlags_DockNode = 1 << 20,
    ImGuiTabBarFlags_IsFocused = 1 << 21,
    ImGuiTabBarFlags_SaveSettings = 1 << 22,
};
enum ImGuiTabItemFlagsPrivate_{
    ImGuiTabItemFlags_SectionMask_ = ImGuiTabItemFlags_Leading | ImGuiTabItemFlags_Trailing,
    ImGuiTabItemFlags_NoCloseButton = 1 << 20,
    ImGuiTabItemFlags_Button = 1 << 21,
    ImGuiTabItemFlags_Unsorted = 1 << 22,
    ImGuiTabItemFlags_Preview = 1 << 23,
};
struct ImGuiTabItem{
    ImGuiID ID;
    ImGuiTabItemFlags Flags;
    struct ImGuiWindow* Window;
    int LastFrameVisible;
    int LastFrameSelected;
    float Offset;
    float Width;
    float ContentWidth;
    ImS32 NameOffset;
    ImS16 BeginOrder;
    ImS16 IndexDuringLayout;
    bool WantClose;
};
struct ImGuiTabBar{
    struct ImVector Tabs;
    ImGuiTabBarFlags Flags;
    ImGuiID ID;
    ImGuiID SelectedTabId;
    ImGuiID NextSelectedTabId;
    ImGuiID VisibleTabId;
    int CurrFrameVisible;
    int PrevFrameVisible;
    struct ImRect BarRect;
    float CurrTabsContentsHeight;
    float PrevTabsContentsHeight;
    float WidthAllTabs;
    float WidthAllTabsIdeal;
    float ScrollingAnim;
    float ScrollingTarget;
    float ScrollingTargetDistToVisibility;
    float ScrollingSpeed;
    float ScrollingRectMinX;
    float ScrollingRectMaxX;
    ImGuiID ReorderRequestTabId;
    ImS16 ReorderRequestOffset;
    ImS8 BeginCount;
    bool WantLayout;
    bool VisibleTabWasSubmitted;
    bool TabsAddedNew;
    ImS16 TabsActiveCount;
    ImS16 LastTabItemIdx;
    float ItemSpacingY;
    struct ImVec2 FramePadding;
    struct ImVec2 BackupCursorPos;
    struct ImGuiTextBuffer TabsNames;
};
int ImGuiTabBar_GetTabOrder(
    struct ImGuiTabBar* this,
    const struct ImGuiTabItem* tab
) asm("?GetTabOrder@ImGuiTabBar@@QEBAHPEBUImGuiTabItem@@@Z");
const char* ImGuiTabBar_GetTabName(
    struct ImGuiTabBar* this,
    const struct ImGuiTabItem* tab
) asm("?GetTabName@ImGuiTabBar@@QEBAPEBDPEBUImGuiTabItem@@@Z");
typedef ImS8 ImGuiTableColumnIdx;
typedef ImU8 ImGuiTableDrawChannelIdx;
struct ImGuiTableColumn{
    ImGuiTableColumnFlags Flags;
    float WidthGiven;
    float MinX;
    float MaxX;
    float WidthRequest;
    float WidthAuto;
    float StretchWeight;
    float InitStretchWeightOrWidth;
    struct ImRect ClipRect;
    ImGuiID UserID;
    float WorkMinX;
    float WorkMaxX;
    float ItemWidth;
    float ContentMaxXFrozen;
    float ContentMaxXUnfrozen;
    float ContentMaxXHeadersUsed;
    float ContentMaxXHeadersIdeal;
    ImS16 NameOffset;
    ImGuiTableColumnIdx DisplayOrder;
    ImGuiTableColumnIdx IndexWithinEnabledSet;
    ImGuiTableColumnIdx PrevEnabledColumn;
    ImGuiTableColumnIdx NextEnabledColumn;
    ImGuiTableColumnIdx SortOrder;
    ImGuiTableDrawChannelIdx DrawChannelCurrent;
    ImGuiTableDrawChannelIdx DrawChannelFrozen;
    ImGuiTableDrawChannelIdx DrawChannelUnfrozen;
    bool IsEnabled;
    bool IsUserEnabled;
    bool IsUserEnabledNextFrame;
    bool IsVisibleX;
    bool IsVisibleY;
    bool IsRequestOutput;
    bool IsSkipItems;
    bool IsPreserveWidthAuto;
    ImS8 NavLayerCurrent;
    ImU8 AutoFitQueue;
    ImU8 CannotSkipItemsQueue;
    ImU8 SortDirection;
    ImU8 SortDirectionsAvailCount;
    ImU8 SortDirectionsAvailMask;
    ImU8 SortDirectionsAvailList;
};
struct ImGuiTableCellData{
    ImU32 BgColor;
    ImGuiTableColumnIdx Column;
};
struct ImGuiTable{
    ImGuiID ID;
    ImGuiTableFlags Flags;
    void* RawData;
    struct ImGuiTableTempData* TempData;
    struct ImSpan Columns;
    struct ImSpan DisplayOrderToIndex;
    struct ImSpan RowCellData;
    ImU64 EnabledMaskByDisplayOrder;
    ImU64 EnabledMaskByIndex;
    ImU64 VisibleMaskByIndex;
    ImU64 RequestOutputMaskByIndex;
    ImGuiTableFlags SettingsLoadedFlags;
    int SettingsOffset;
    int LastFrameActive;
    int ColumnsCount;
    int CurrentRow;
    int CurrentColumn;
    ImS16 InstanceCurrent;
    ImS16 InstanceInteracted;
    float RowPosY1;
    float RowPosY2;
    float RowMinHeight;
    float RowTextBaseline;
    float RowIndentOffsetX;
    ImGuiTableRowFlags RowFlags;
    ImGuiTableRowFlags LastRowFlags;
    int RowBgColorCounter;
    ImU32 RowBgColor;
    ImU32 BorderColorStrong;
    ImU32 BorderColorLight;
    float BorderX1;
    float BorderX2;
    float HostIndentX;
    float MinColumnWidth;
    float OuterPaddingX;
    float CellPaddingX;
    float CellPaddingY;
    float CellSpacingX1;
    float CellSpacingX2;
    float LastOuterHeight;
    float LastFirstRowHeight;
    float InnerWidth;
    float ColumnsGivenWidth;
    float ColumnsAutoFitWidth;
    float ResizedColumnNextWidth;
    float ResizeLockMinContentsX2;
    float RefScale;
    struct ImRect OuterRect;
    struct ImRect InnerRect;
    struct ImRect WorkRect;
    struct ImRect InnerClipRect;
    struct ImRect BgClipRect;
    struct ImRect Bg0ClipRectForDrawCmd;
    struct ImRect Bg2ClipRectForDrawCmd;
    struct ImRect HostClipRect;
    struct ImRect HostBackupInnerClipRect;
    struct ImGuiWindow* OuterWindow;
    struct ImGuiWindow* InnerWindow;
    struct ImGuiTextBuffer ColumnsNames;
    struct ImDrawListSplitter* DrawSplitter;
    struct ImGuiTableColumnSortSpecs SortSpecsSingle;
    struct ImVector SortSpecsMulti;
    struct ImGuiTableSortSpecs SortSpecs;
    ImGuiTableColumnIdx SortSpecsCount;
    ImGuiTableColumnIdx ColumnsEnabledCount;
    ImGuiTableColumnIdx ColumnsEnabledFixedCount;
    ImGuiTableColumnIdx DeclColumnsCount;
    ImGuiTableColumnIdx HoveredColumnBody;
    ImGuiTableColumnIdx HoveredColumnBorder;
    ImGuiTableColumnIdx AutoFitSingleColumn;
    ImGuiTableColumnIdx ResizedColumn;
    ImGuiTableColumnIdx LastResizedColumn;
    ImGuiTableColumnIdx HeldHeaderColumn;
    ImGuiTableColumnIdx ReorderColumn;
    ImGuiTableColumnIdx ReorderColumnDir;
    ImGuiTableColumnIdx LeftMostEnabledColumn;
    ImGuiTableColumnIdx RightMostEnabledColumn;
    ImGuiTableColumnIdx LeftMostStretchedColumn;
    ImGuiTableColumnIdx RightMostStretchedColumn;
    ImGuiTableColumnIdx ContextPopupColumn;
    ImGuiTableColumnIdx FreezeRowsRequest;
    ImGuiTableColumnIdx FreezeRowsCount;
    ImGuiTableColumnIdx FreezeColumnsRequest;
    ImGuiTableColumnIdx FreezeColumnsCount;
    ImGuiTableColumnIdx RowCellDataCurrent;
    ImGuiTableDrawChannelIdx DummyDrawChannel;
    ImGuiTableDrawChannelIdx Bg2DrawChannelCurrent;
    ImGuiTableDrawChannelIdx Bg2DrawChannelUnfrozen;
    bool IsLayoutLocked;
    bool IsInsideRow;
    bool IsInitializing;
    bool IsSortSpecsDirty;
    bool IsUsingHeaders;
    bool IsContextPopupOpen;
    bool IsSettingsRequestLoad;
    bool IsSettingsDirty;
    bool IsDefaultDisplayOrder;
    bool IsResetAllRequest;
    bool IsResetDisplayOrderRequest;
    bool IsUnfrozenRows;
    bool IsDefaultSizingPolicy;
    bool MemoryCompacted;
    bool HostSkipItems;
};
struct ImGuiTableTempData{
    int TableIndex;
    float LastTimeActive;
    struct ImVec2 UserOuterSize;
    struct ImDrawListSplitter DrawSplitter;
    struct ImRect HostBackupWorkRect;
    struct ImRect HostBackupParentWorkRect;
    struct ImVec2 HostBackupPrevLineSize;
    struct ImVec2 HostBackupCurrLineSize;
    struct ImVec2 HostBackupCursorMaxPos;
    struct ImVec1 HostBackupColumnsOffset;
    float HostBackupItemWidth;
    int HostBackupItemWidthStackSize;
};
struct ImGuiTableColumnSettings{
    float WidthOrWeight;
    ImGuiID UserID;
    ImGuiTableColumnIdx Index;
    ImGuiTableColumnIdx DisplayOrder;
    ImGuiTableColumnIdx SortOrder;
    ImU8 SortDirection;
    ImU8 IsEnabled;
    ImU8 IsStretch;
};
struct ImGuiTableSettings{
    ImGuiID ID;
    ImGuiTableFlags SaveFlags;
    float RefScale;
    ImGuiTableColumnIdx ColumnsCount;
    ImGuiTableColumnIdx ColumnsCountMax;
    bool WantApply;
};
struct ImFontBuilderIO{
    bool(*FontBuilder_Build)(struct ImFontAtlas* atlas);
};
void DockContextInitialize(
    struct ImGuiContext* ctx
) asm("?DockContextInitialize@ImGui@@YAXPEAUImGuiContext@@@Z");
void DockContextShutdown(
    struct ImGuiContext* ctx
) asm("?DockContextShutdown@ImGui@@YAXPEAUImGuiContext@@@Z");
void DockContextClearNodes(
    struct ImGuiContext* ctx,
    ImGuiID root_id,
    bool clear_settings_refs
) asm("?DockContextClearNodes@ImGui@@YAXPEAUImGuiContext@@I_N@Z");
void DockContextRebuildNodes(
    struct ImGuiContext* ctx
) asm("?DockContextRebuildNodes@ImGui@@YAXPEAUImGuiContext@@@Z");
void DockContextNewFrameUpdateUndocking(
    struct ImGuiContext* ctx
) asm("?DockContextNewFrameUpdateUndocking@ImGui@@YAXPEAUImGuiContext@@@Z");
void DockContextNewFrameUpdateDocking(
    struct ImGuiContext* ctx
) asm("?DockContextNewFrameUpdateDocking@ImGui@@YAXPEAUImGuiContext@@@Z");
ImGuiID DockContextGenNodeID(
    struct ImGuiContext* ctx
) asm("?DockContextGenNodeID@ImGui@@YAIPEAUImGuiContext@@@Z");
void DockContextQueueDock(
    struct ImGuiContext* ctx,
    struct ImGuiWindow* target,
    struct ImGuiDockNode* target_node,
    struct ImGuiWindow* payload,
    ImGuiDir split_dir,
    float split_ratio,
    bool split_outer
) asm("?DockContextQueueDock@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiWindow@@PEAUImGuiDockNode@@1HM_N@Z");
void DockContextQueueUndockWindow(
    struct ImGuiContext* ctx,
    struct ImGuiWindow* window
) asm("?DockContextQueueUndockWindow@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiWindow@@@Z");
void DockContextQueueUndockNode(
    struct ImGuiContext* ctx,
    struct ImGuiDockNode* node
) asm("?DockContextQueueUndockNode@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiDockNode@@@Z");
bool DockContextCalcDropPosForDocking(
    struct ImGuiWindow* target,
    struct ImGuiDockNode* target_node,
    struct ImGuiWindow* payload,
    ImGuiDir split_dir,
    bool split_outer,
    struct ImVec2* out_pos
) asm("?DockContextCalcDropPosForDocking@ImGui@@YA_NPEAUImGuiWindow@@PEAUImGuiDockNode@@0H_NPEAUImVec2@@@Z");
bool DockNodeBeginAmendTabBar(
    struct ImGuiDockNode* node
) asm("?DockNodeBeginAmendTabBar@ImGui@@YA_NPEAUImGuiDockNode@@@Z");
void DockNodeEndAmendTabBar(
) asm("?DockNodeEndAmendTabBar@ImGui@@YAXXZ");
void BeginDocked(
    struct ImGuiWindow* window,
    bool* p_open
) asm("?BeginDocked@ImGui@@YAXPEAUImGuiWindow@@PEA_N@Z");
void BeginDockableDragDropSource(
    struct ImGuiWindow* window
) asm("?BeginDockableDragDropSource@ImGui@@YAXPEAUImGuiWindow@@@Z");
void BeginDockableDragDropTarget(
    struct ImGuiWindow* window
) asm("?BeginDockableDragDropTarget@ImGui@@YAXPEAUImGuiWindow@@@Z");
void SetWindowDock(
    struct ImGuiWindow* window,
    ImGuiID dock_id,
    ImGuiCond cond
) asm("?SetWindowDock@ImGui@@YAXPEAUImGuiWindow@@IH@Z");
void DockBuilderDockWindow(
    const char* window_name,
    ImGuiID node_id
) asm("?DockBuilderDockWindow@ImGui@@YAXPEBDI@Z");
struct ImGuiDockNode* DockBuilderGetNode(
    ImGuiID node_id
) asm("?DockBuilderGetNode@ImGui@@YAPEAUImGuiDockNode@@I@Z");
ImGuiID DockBuilderAddNode(
    ImGuiID node_id,
    ImGuiDockNodeFlags flags
) asm("?DockBuilderAddNode@ImGui@@YAIIH@Z");
void DockBuilderRemoveNode(
    ImGuiID node_id
) asm("?DockBuilderRemoveNode@ImGui@@YAXI@Z");
void DockBuilderRemoveNodeDockedWindows(
    ImGuiID node_id,
    bool clear_settings_refs
) asm("?DockBuilderRemoveNodeDockedWindows@ImGui@@YAXI_N@Z");
void DockBuilderRemoveNodeChildNodes(
    ImGuiID node_id
) asm("?DockBuilderRemoveNodeChildNodes@ImGui@@YAXI@Z");
void DockBuilderSetNodePos(
    ImGuiID node_id,
    struct ImVec2 pos
) asm("?DockBuilderSetNodePos@ImGui@@YAXIUImVec2@@@Z");
void DockBuilderSetNodeSize(
    ImGuiID node_id,
    struct ImVec2 size
) asm("?DockBuilderSetNodeSize@ImGui@@YAXIUImVec2@@@Z");
ImGuiID DockBuilderSplitNode(
    ImGuiID node_id,
    ImGuiDir split_dir,
    float size_ratio_for_node_at_dir,
    ImGuiID* out_id_at_dir,
    ImGuiID* out_id_at_opposite_dir
) asm("?DockBuilderSplitNode@ImGui@@YAIIHMPEAI0@Z");
void DockBuilderCopyDockSpace(
    ImGuiID src_dockspace_id,
    ImGuiID dst_dockspace_id,
    struct ImVector* in_window_remap_pairs
) asm("?DockBuilderCopyDockSpace@ImGui@@YAXIIPEAU?$ImVector@PEBD@@@Z");
void DockBuilderCopyNode(
    ImGuiID src_node_id,
    ImGuiID dst_node_id,
    ImGuiID* out_node_remap_pairs
) asm("?DockBuilderCopyNode@ImGui@@YAXIIPEAU?$ImVector@I@@@Z");
void DockBuilderCopyWindowSettings(
    const char* src_name,
    const char* dst_name
) asm("?DockBuilderCopyWindowSettings@ImGui@@YAXPEBD0@Z");
void DockBuilderFinish(
    ImGuiID node_id
) asm("?DockBuilderFinish@ImGui@@YAXI@Z");
void RenderArrowDockMenu(
    struct ImDrawList* draw_list,
    struct ImVec2 p_min,
    float sz,
    ImU32 col
) asm("?RenderArrowDockMenu@ImGui@@YAXPEAUImDrawList@@UImVec2@@MI@Z");
void DebugNodeDockNode(
    struct ImGuiDockNode* node,
    const char* label
) asm("?DebugNodeDockNode@ImGui@@YAXPEAUImGuiDockNode@@PEBD@Z");
]]
