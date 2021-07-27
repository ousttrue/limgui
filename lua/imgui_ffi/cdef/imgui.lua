-- generated from imgui.h
local ffi = require 'ffi'
ffi.cdef[[
typedef int ImGuiCol;
typedef int ImGuiCond;
typedef int ImGuiDataType;
typedef int ImGuiDir;
typedef int ImGuiKey;
typedef int ImGuiMouseButton;
typedef int ImGuiMouseCursor;
typedef int ImGuiSortDirection;
typedef int ImGuiStyleVar;
typedef int ImGuiTableBgTarget;
typedef int ImDrawFlags;
typedef int ImDrawListFlags;
typedef int ImFontAtlasFlags;
typedef int ImGuiBackendFlags;
typedef int ImGuiButtonFlags;
typedef int ImGuiColorEditFlags;
typedef int ImGuiConfigFlags;
typedef int ImGuiComboFlags;
typedef int ImGuiDockNodeFlags;
typedef int ImGuiDragDropFlags;
typedef int ImGuiFocusedFlags;
typedef int ImGuiHoveredFlags;
typedef int ImGuiInputTextFlags;
typedef int ImGuiKeyModFlags;
typedef int ImGuiPopupFlags;
typedef int ImGuiSelectableFlags;
typedef int ImGuiSliderFlags;
typedef int ImGuiTabBarFlags;
typedef int ImGuiTabItemFlags;
typedef int ImGuiTableFlags;
typedef int ImGuiTableColumnFlags;
typedef int ImGuiTableRowFlags;
typedef int ImGuiTreeNodeFlags;
typedef int ImGuiViewportFlags;
typedef int ImGuiWindowFlags;
typedef void* ImTextureID;
typedef unsigned int ImGuiID;
typedef int(*ImGuiInputTextCallback)(struct ImGuiInputTextCallbackData* data);
typedef void(*ImGuiSizeCallback)(struct ImGuiSizeCallbackData* data);
typedef void*(*ImGuiMemAllocFunc)(size_t sz, void* user_data);
typedef void(*ImGuiMemFreeFunc)(void* ptr, void* user_data);
typedef unsigned short ImWchar16;
typedef ImWchar16 ImWchar;
typedef char ImS8;
typedef unsigned char ImU8;
typedef short ImS16;
typedef unsigned short ImU16;
typedef int ImS32;
typedef unsigned int ImU32;
typedef unsigned long long ImU64;
struct ImVec2{
    float x;
    float y;
};
struct ImVec4{
    float x;
    float y;
    float z;
    float w;
};
enum ImGuiWindowFlags_{
    ImGuiWindowFlags_None = 0,
    ImGuiWindowFlags_NoTitleBar = 1 << 0,
    ImGuiWindowFlags_NoResize = 1 << 1,
    ImGuiWindowFlags_NoMove = 1 << 2,
    ImGuiWindowFlags_NoScrollbar = 1 << 3,
    ImGuiWindowFlags_NoScrollWithMouse = 1 << 4,
    ImGuiWindowFlags_NoCollapse = 1 << 5,
    ImGuiWindowFlags_AlwaysAutoResize = 1 << 6,
    ImGuiWindowFlags_NoBackground = 1 << 7,
    ImGuiWindowFlags_NoSavedSettings = 1 << 8,
    ImGuiWindowFlags_NoMouseInputs = 1 << 9,
    ImGuiWindowFlags_MenuBar = 1 << 10,
    ImGuiWindowFlags_HorizontalScrollbar = 1 << 11,
    ImGuiWindowFlags_NoFocusOnAppearing = 1 << 12,
    ImGuiWindowFlags_NoBringToFrontOnFocus = 1 << 13,
    ImGuiWindowFlags_AlwaysVerticalScrollbar = 1 << 14,
    ImGuiWindowFlags_AlwaysHorizontalScrollbar = 1 << 15,
    ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16,
    ImGuiWindowFlags_NoNavInputs = 1 << 18,
    ImGuiWindowFlags_NoNavFocus = 1 << 19,
    ImGuiWindowFlags_UnsavedDocument = 1 << 20,
    ImGuiWindowFlags_NoDocking = 1 << 21,
    ImGuiWindowFlags_NoNav = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
    ImGuiWindowFlags_NoDecoration = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse,
    ImGuiWindowFlags_NoInputs = ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
    ImGuiWindowFlags_NavFlattened = 1 << 23,
    ImGuiWindowFlags_ChildWindow = 1 << 24,
    ImGuiWindowFlags_Tooltip = 1 << 25,
    ImGuiWindowFlags_Popup = 1 << 26,
    ImGuiWindowFlags_Modal = 1 << 27,
    ImGuiWindowFlags_ChildMenu = 1 << 28,
    ImGuiWindowFlags_DockNodeHost = 1 << 29,
};
enum ImGuiInputTextFlags_{
    ImGuiInputTextFlags_None = 0,
    ImGuiInputTextFlags_CharsDecimal = 1 << 0,
    ImGuiInputTextFlags_CharsHexadecimal = 1 << 1,
    ImGuiInputTextFlags_CharsUppercase = 1 << 2,
    ImGuiInputTextFlags_CharsNoBlank = 1 << 3,
    ImGuiInputTextFlags_AutoSelectAll = 1 << 4,
    ImGuiInputTextFlags_EnterReturnsTrue = 1 << 5,
    ImGuiInputTextFlags_CallbackCompletion = 1 << 6,
    ImGuiInputTextFlags_CallbackHistory = 1 << 7,
    ImGuiInputTextFlags_CallbackAlways = 1 << 8,
    ImGuiInputTextFlags_CallbackCharFilter = 1 << 9,
    ImGuiInputTextFlags_AllowTabInput = 1 << 10,
    ImGuiInputTextFlags_CtrlEnterForNewLine = 1 << 11,
    ImGuiInputTextFlags_NoHorizontalScroll = 1 << 12,
    ImGuiInputTextFlags_AlwaysOverwrite = 1 << 13,
    ImGuiInputTextFlags_ReadOnly = 1 << 14,
    ImGuiInputTextFlags_Password = 1 << 15,
    ImGuiInputTextFlags_NoUndoRedo = 1 << 16,
    ImGuiInputTextFlags_CharsScientific = 1 << 17,
    ImGuiInputTextFlags_CallbackResize = 1 << 18,
    ImGuiInputTextFlags_CallbackEdit = 1 << 19,
    ImGuiInputTextFlags_AlwaysInsertMode = ImGuiInputTextFlags_AlwaysOverwrite,
};
enum ImGuiTreeNodeFlags_{
    ImGuiTreeNodeFlags_None = 0,
    ImGuiTreeNodeFlags_Selected = 1 << 0,
    ImGuiTreeNodeFlags_Framed = 1 << 1,
    ImGuiTreeNodeFlags_AllowItemOverlap = 1 << 2,
    ImGuiTreeNodeFlags_NoTreePushOnOpen = 1 << 3,
    ImGuiTreeNodeFlags_NoAutoOpenOnLog = 1 << 4,
    ImGuiTreeNodeFlags_DefaultOpen = 1 << 5,
    ImGuiTreeNodeFlags_OpenOnDoubleClick = 1 << 6,
    ImGuiTreeNodeFlags_OpenOnArrow = 1 << 7,
    ImGuiTreeNodeFlags_Leaf = 1 << 8,
    ImGuiTreeNodeFlags_Bullet = 1 << 9,
    ImGuiTreeNodeFlags_FramePadding = 1 << 10,
    ImGuiTreeNodeFlags_SpanAvailWidth = 1 << 11,
    ImGuiTreeNodeFlags_SpanFullWidth = 1 << 12,
    ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 1 << 13,
    ImGuiTreeNodeFlags_CollapsingHeader = ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoTreePushOnOpen | ImGuiTreeNodeFlags_NoAutoOpenOnLog,
};
enum ImGuiPopupFlags_{
    ImGuiPopupFlags_None = 0,
    ImGuiPopupFlags_MouseButtonLeft = 0,
    ImGuiPopupFlags_MouseButtonRight = 1,
    ImGuiPopupFlags_MouseButtonMiddle = 2,
    ImGuiPopupFlags_MouseButtonMask_ = 0x1F,
    ImGuiPopupFlags_MouseButtonDefault_ = 1,
    ImGuiPopupFlags_NoOpenOverExistingPopup = 1 << 5,
    ImGuiPopupFlags_NoOpenOverItems = 1 << 6,
    ImGuiPopupFlags_AnyPopupId = 1 << 7,
    ImGuiPopupFlags_AnyPopupLevel = 1 << 8,
    ImGuiPopupFlags_AnyPopup = ImGuiPopupFlags_AnyPopupId | ImGuiPopupFlags_AnyPopupLevel,
};
enum ImGuiSelectableFlags_{
    ImGuiSelectableFlags_None = 0,
    ImGuiSelectableFlags_DontClosePopups = 1 << 0,
    ImGuiSelectableFlags_SpanAllColumns = 1 << 1,
    ImGuiSelectableFlags_AllowDoubleClick = 1 << 2,
    ImGuiSelectableFlags_Disabled = 1 << 3,
    ImGuiSelectableFlags_AllowItemOverlap = 1 << 4,
};
enum ImGuiComboFlags_{
    ImGuiComboFlags_None = 0,
    ImGuiComboFlags_PopupAlignLeft = 1 << 0,
    ImGuiComboFlags_HeightSmall = 1 << 1,
    ImGuiComboFlags_HeightRegular = 1 << 2,
    ImGuiComboFlags_HeightLarge = 1 << 3,
    ImGuiComboFlags_HeightLargest = 1 << 4,
    ImGuiComboFlags_NoArrowButton = 1 << 5,
    ImGuiComboFlags_NoPreview = 1 << 6,
    ImGuiComboFlags_HeightMask_ = ImGuiComboFlags_HeightSmall | ImGuiComboFlags_HeightRegular | ImGuiComboFlags_HeightLarge | ImGuiComboFlags_HeightLargest,
};
enum ImGuiTabBarFlags_{
    ImGuiTabBarFlags_None = 0,
    ImGuiTabBarFlags_Reorderable = 1 << 0,
    ImGuiTabBarFlags_AutoSelectNewTabs = 1 << 1,
    ImGuiTabBarFlags_TabListPopupButton = 1 << 2,
    ImGuiTabBarFlags_NoCloseWithMiddleMouseButton = 1 << 3,
    ImGuiTabBarFlags_NoTabListScrollingButtons = 1 << 4,
    ImGuiTabBarFlags_NoTooltip = 1 << 5,
    ImGuiTabBarFlags_FittingPolicyResizeDown = 1 << 6,
    ImGuiTabBarFlags_FittingPolicyScroll = 1 << 7,
    ImGuiTabBarFlags_FittingPolicyMask_ = ImGuiTabBarFlags_FittingPolicyResizeDown | ImGuiTabBarFlags_FittingPolicyScroll,
    ImGuiTabBarFlags_FittingPolicyDefault_ = ImGuiTabBarFlags_FittingPolicyResizeDown,
};
enum ImGuiTabItemFlags_{
    ImGuiTabItemFlags_None = 0,
    ImGuiTabItemFlags_UnsavedDocument = 1 << 0,
    ImGuiTabItemFlags_SetSelected = 1 << 1,
    ImGuiTabItemFlags_NoCloseWithMiddleMouseButton = 1 << 2,
    ImGuiTabItemFlags_NoPushId = 1 << 3,
    ImGuiTabItemFlags_NoTooltip = 1 << 4,
    ImGuiTabItemFlags_NoReorder = 1 << 5,
    ImGuiTabItemFlags_Leading = 1 << 6,
    ImGuiTabItemFlags_Trailing = 1 << 7,
};
enum ImGuiTableFlags_{
    ImGuiTableFlags_None = 0,
    ImGuiTableFlags_Resizable = 1 << 0,
    ImGuiTableFlags_Reorderable = 1 << 1,
    ImGuiTableFlags_Hideable = 1 << 2,
    ImGuiTableFlags_Sortable = 1 << 3,
    ImGuiTableFlags_NoSavedSettings = 1 << 4,
    ImGuiTableFlags_ContextMenuInBody = 1 << 5,
    ImGuiTableFlags_RowBg = 1 << 6,
    ImGuiTableFlags_BordersInnerH = 1 << 7,
    ImGuiTableFlags_BordersOuterH = 1 << 8,
    ImGuiTableFlags_BordersInnerV = 1 << 9,
    ImGuiTableFlags_BordersOuterV = 1 << 10,
    ImGuiTableFlags_BordersH = ImGuiTableFlags_BordersInnerH | ImGuiTableFlags_BordersOuterH,
    ImGuiTableFlags_BordersV = ImGuiTableFlags_BordersInnerV | ImGuiTableFlags_BordersOuterV,
    ImGuiTableFlags_BordersInner = ImGuiTableFlags_BordersInnerV | ImGuiTableFlags_BordersInnerH,
    ImGuiTableFlags_BordersOuter = ImGuiTableFlags_BordersOuterV | ImGuiTableFlags_BordersOuterH,
    ImGuiTableFlags_Borders = ImGuiTableFlags_BordersInner | ImGuiTableFlags_BordersOuter,
    ImGuiTableFlags_NoBordersInBody = 1 << 11,
    ImGuiTableFlags_NoBordersInBodyUntilResize = 1 << 12,
    ImGuiTableFlags_SizingFixedFit = 1 << 13,
    ImGuiTableFlags_SizingFixedSame = 2 << 13,
    ImGuiTableFlags_SizingStretchProp = 3 << 13,
    ImGuiTableFlags_SizingStretchSame = 4 << 13,
    ImGuiTableFlags_NoHostExtendX = 1 << 16,
    ImGuiTableFlags_NoHostExtendY = 1 << 17,
    ImGuiTableFlags_NoKeepColumnsVisible = 1 << 18,
    ImGuiTableFlags_PreciseWidths = 1 << 19,
    ImGuiTableFlags_NoClip = 1 << 20,
    ImGuiTableFlags_PadOuterX = 1 << 21,
    ImGuiTableFlags_NoPadOuterX = 1 << 22,
    ImGuiTableFlags_NoPadInnerX = 1 << 23,
    ImGuiTableFlags_ScrollX = 1 << 24,
    ImGuiTableFlags_ScrollY = 1 << 25,
    ImGuiTableFlags_SortMulti = 1 << 26,
    ImGuiTableFlags_SortTristate = 1 << 27,
    ImGuiTableFlags_SizingMask_ = ImGuiTableFlags_SizingFixedFit | ImGuiTableFlags_SizingFixedSame | ImGuiTableFlags_SizingStretchProp | ImGuiTableFlags_SizingStretchSame,
};
enum ImGuiTableColumnFlags_{
    ImGuiTableColumnFlags_None = 0,
    ImGuiTableColumnFlags_Disabled = 1 << 0,
    ImGuiTableColumnFlags_DefaultHide = 1 << 1,
    ImGuiTableColumnFlags_DefaultSort = 1 << 2,
    ImGuiTableColumnFlags_WidthStretch = 1 << 3,
    ImGuiTableColumnFlags_WidthFixed = 1 << 4,
    ImGuiTableColumnFlags_NoResize = 1 << 5,
    ImGuiTableColumnFlags_NoReorder = 1 << 6,
    ImGuiTableColumnFlags_NoHide = 1 << 7,
    ImGuiTableColumnFlags_NoClip = 1 << 8,
    ImGuiTableColumnFlags_NoSort = 1 << 9,
    ImGuiTableColumnFlags_NoSortAscending = 1 << 10,
    ImGuiTableColumnFlags_NoSortDescending = 1 << 11,
    ImGuiTableColumnFlags_NoHeaderLabel = 1 << 12,
    ImGuiTableColumnFlags_NoHeaderWidth = 1 << 13,
    ImGuiTableColumnFlags_PreferSortAscending = 1 << 14,
    ImGuiTableColumnFlags_PreferSortDescending = 1 << 15,
    ImGuiTableColumnFlags_IndentEnable = 1 << 16,
    ImGuiTableColumnFlags_IndentDisable = 1 << 17,
    ImGuiTableColumnFlags_IsEnabled = 1 << 24,
    ImGuiTableColumnFlags_IsVisible = 1 << 25,
    ImGuiTableColumnFlags_IsSorted = 1 << 26,
    ImGuiTableColumnFlags_IsHovered = 1 << 27,
    ImGuiTableColumnFlags_WidthMask_ = ImGuiTableColumnFlags_WidthStretch | ImGuiTableColumnFlags_WidthFixed,
    ImGuiTableColumnFlags_IndentMask_ = ImGuiTableColumnFlags_IndentEnable | ImGuiTableColumnFlags_IndentDisable,
    ImGuiTableColumnFlags_StatusMask_ = ImGuiTableColumnFlags_IsEnabled | ImGuiTableColumnFlags_IsVisible | ImGuiTableColumnFlags_IsSorted | ImGuiTableColumnFlags_IsHovered,
    ImGuiTableColumnFlags_NoDirectResize_ = 1 << 30,
};
enum ImGuiTableRowFlags_{
    ImGuiTableRowFlags_None = 0,
    ImGuiTableRowFlags_Headers = 1 << 0,
};
enum ImGuiTableBgTarget_{
    ImGuiTableBgTarget_None = 0,
    ImGuiTableBgTarget_RowBg0 = 1,
    ImGuiTableBgTarget_RowBg1 = 2,
    ImGuiTableBgTarget_CellBg = 3,
};
enum ImGuiFocusedFlags_{
    ImGuiFocusedFlags_None = 0,
    ImGuiFocusedFlags_ChildWindows = 1 << 0,
    ImGuiFocusedFlags_RootWindow = 1 << 1,
    ImGuiFocusedFlags_AnyWindow = 1 << 2,
    ImGuiFocusedFlags_RootAndChildWindows = ImGuiFocusedFlags_RootWindow | ImGuiFocusedFlags_ChildWindows,
};
enum ImGuiHoveredFlags_{
    ImGuiHoveredFlags_None = 0,
    ImGuiHoveredFlags_ChildWindows = 1 << 0,
    ImGuiHoveredFlags_RootWindow = 1 << 1,
    ImGuiHoveredFlags_AnyWindow = 1 << 2,
    ImGuiHoveredFlags_AllowWhenBlockedByPopup = 1 << 3,
    ImGuiHoveredFlags_AllowWhenBlockedByActiveItem = 1 << 5,
    ImGuiHoveredFlags_AllowWhenOverlapped = 1 << 6,
    ImGuiHoveredFlags_AllowWhenDisabled = 1 << 7,
    ImGuiHoveredFlags_RectOnly = ImGuiHoveredFlags_AllowWhenBlockedByPopup | ImGuiHoveredFlags_AllowWhenBlockedByActiveItem | ImGuiHoveredFlags_AllowWhenOverlapped,
    ImGuiHoveredFlags_RootAndChildWindows = ImGuiHoveredFlags_RootWindow | ImGuiHoveredFlags_ChildWindows,
};
enum ImGuiDockNodeFlags_{
    ImGuiDockNodeFlags_None = 0,
    ImGuiDockNodeFlags_KeepAliveOnly = 1 << 0,
    ImGuiDockNodeFlags_NoDockingInCentralNode = 1 << 2,
    ImGuiDockNodeFlags_PassthruCentralNode = 1 << 3,
    ImGuiDockNodeFlags_NoSplit = 1 << 4,
    ImGuiDockNodeFlags_NoResize = 1 << 5,
    ImGuiDockNodeFlags_AutoHideTabBar = 1 << 6,
};
enum ImGuiDragDropFlags_{
    ImGuiDragDropFlags_None = 0,
    ImGuiDragDropFlags_SourceNoPreviewTooltip = 1 << 0,
    ImGuiDragDropFlags_SourceNoDisableHover = 1 << 1,
    ImGuiDragDropFlags_SourceNoHoldToOpenOthers = 1 << 2,
    ImGuiDragDropFlags_SourceAllowNullID = 1 << 3,
    ImGuiDragDropFlags_SourceExtern = 1 << 4,
    ImGuiDragDropFlags_SourceAutoExpirePayload = 1 << 5,
    ImGuiDragDropFlags_AcceptBeforeDelivery = 1 << 10,
    ImGuiDragDropFlags_AcceptNoDrawDefaultRect = 1 << 11,
    ImGuiDragDropFlags_AcceptNoPreviewTooltip = 1 << 12,
    ImGuiDragDropFlags_AcceptPeekOnly = ImGuiDragDropFlags_AcceptBeforeDelivery | ImGuiDragDropFlags_AcceptNoDrawDefaultRect,
};
enum ImGuiDataType_{
    ImGuiDataType_S8 = 0,
    ImGuiDataType_U8 = 1,
    ImGuiDataType_S16 = 2,
    ImGuiDataType_U16 = 3,
    ImGuiDataType_S32 = 4,
    ImGuiDataType_U32 = 5,
    ImGuiDataType_S64 = 6,
    ImGuiDataType_U64 = 7,
    ImGuiDataType_Float = 8,
    ImGuiDataType_Double = 9,
    ImGuiDataType_COUNT = 10,
};
enum ImGuiDir_{
    ImGuiDir_None = -1,
    ImGuiDir_Left = 0,
    ImGuiDir_Right = 1,
    ImGuiDir_Up = 2,
    ImGuiDir_Down = 3,
    ImGuiDir_COUNT = 4,
};
enum ImGuiSortDirection_{
    ImGuiSortDirection_None = 0,
    ImGuiSortDirection_Ascending = 1,
    ImGuiSortDirection_Descending = 2,
};
enum ImGuiKey_{
    ImGuiKey_Tab = 0,
    ImGuiKey_LeftArrow = 1,
    ImGuiKey_RightArrow = 2,
    ImGuiKey_UpArrow = 3,
    ImGuiKey_DownArrow = 4,
    ImGuiKey_PageUp = 5,
    ImGuiKey_PageDown = 6,
    ImGuiKey_Home = 7,
    ImGuiKey_End = 8,
    ImGuiKey_Insert = 9,
    ImGuiKey_Delete = 10,
    ImGuiKey_Backspace = 11,
    ImGuiKey_Space = 12,
    ImGuiKey_Enter = 13,
    ImGuiKey_Escape = 14,
    ImGuiKey_KeyPadEnter = 15,
    ImGuiKey_A = 16,
    ImGuiKey_C = 17,
    ImGuiKey_V = 18,
    ImGuiKey_X = 19,
    ImGuiKey_Y = 20,
    ImGuiKey_Z = 21,
    ImGuiKey_COUNT = 22,
};
enum ImGuiKeyModFlags_{
    ImGuiKeyModFlags_None = 0,
    ImGuiKeyModFlags_Ctrl = 1 << 0,
    ImGuiKeyModFlags_Shift = 1 << 1,
    ImGuiKeyModFlags_Alt = 1 << 2,
    ImGuiKeyModFlags_Super = 1 << 3,
};
enum ImGuiNavInput_{
    ImGuiNavInput_Activate = 0,
    ImGuiNavInput_Cancel = 1,
    ImGuiNavInput_Input = 2,
    ImGuiNavInput_Menu = 3,
    ImGuiNavInput_DpadLeft = 4,
    ImGuiNavInput_DpadRight = 5,
    ImGuiNavInput_DpadUp = 6,
    ImGuiNavInput_DpadDown = 7,
    ImGuiNavInput_LStickLeft = 8,
    ImGuiNavInput_LStickRight = 9,
    ImGuiNavInput_LStickUp = 10,
    ImGuiNavInput_LStickDown = 11,
    ImGuiNavInput_FocusPrev = 12,
    ImGuiNavInput_FocusNext = 13,
    ImGuiNavInput_TweakSlow = 14,
    ImGuiNavInput_TweakFast = 15,
    ImGuiNavInput_KeyMenu_ = 16,
    ImGuiNavInput_KeyLeft_ = 17,
    ImGuiNavInput_KeyRight_ = 18,
    ImGuiNavInput_KeyUp_ = 19,
    ImGuiNavInput_KeyDown_ = 20,
    ImGuiNavInput_COUNT = 21,
    ImGuiNavInput_InternalStart_ = ImGuiNavInput_KeyMenu_,
};
enum ImGuiConfigFlags_{
    ImGuiConfigFlags_None = 0,
    ImGuiConfigFlags_NavEnableKeyboard = 1 << 0,
    ImGuiConfigFlags_NavEnableGamepad = 1 << 1,
    ImGuiConfigFlags_NavEnableSetMousePos = 1 << 2,
    ImGuiConfigFlags_NavNoCaptureKeyboard = 1 << 3,
    ImGuiConfigFlags_NoMouse = 1 << 4,
    ImGuiConfigFlags_NoMouseCursorChange = 1 << 5,
    ImGuiConfigFlags_DockingEnable = 1 << 6,
    ImGuiConfigFlags_ViewportsEnable = 1 << 10,
    ImGuiConfigFlags_DpiEnableScaleViewports = 1 << 14,
    ImGuiConfigFlags_DpiEnableScaleFonts = 1 << 15,
    ImGuiConfigFlags_IsSRGB = 1 << 20,
    ImGuiConfigFlags_IsTouchScreen = 1 << 21,
};
enum ImGuiBackendFlags_{
    ImGuiBackendFlags_None = 0,
    ImGuiBackendFlags_HasGamepad = 1 << 0,
    ImGuiBackendFlags_HasMouseCursors = 1 << 1,
    ImGuiBackendFlags_HasSetMousePos = 1 << 2,
    ImGuiBackendFlags_RendererHasVtxOffset = 1 << 3,
    ImGuiBackendFlags_PlatformHasViewports = 1 << 10,
    ImGuiBackendFlags_HasMouseHoveredViewport = 1 << 11,
    ImGuiBackendFlags_RendererHasViewports = 1 << 12,
};
enum ImGuiCol_{
    ImGuiCol_Text = 0,
    ImGuiCol_TextDisabled = 1,
    ImGuiCol_WindowBg = 2,
    ImGuiCol_ChildBg = 3,
    ImGuiCol_PopupBg = 4,
    ImGuiCol_Border = 5,
    ImGuiCol_BorderShadow = 6,
    ImGuiCol_FrameBg = 7,
    ImGuiCol_FrameBgHovered = 8,
    ImGuiCol_FrameBgActive = 9,
    ImGuiCol_TitleBg = 10,
    ImGuiCol_TitleBgActive = 11,
    ImGuiCol_TitleBgCollapsed = 12,
    ImGuiCol_MenuBarBg = 13,
    ImGuiCol_ScrollbarBg = 14,
    ImGuiCol_ScrollbarGrab = 15,
    ImGuiCol_ScrollbarGrabHovered = 16,
    ImGuiCol_ScrollbarGrabActive = 17,
    ImGuiCol_CheckMark = 18,
    ImGuiCol_SliderGrab = 19,
    ImGuiCol_SliderGrabActive = 20,
    ImGuiCol_Button = 21,
    ImGuiCol_ButtonHovered = 22,
    ImGuiCol_ButtonActive = 23,
    ImGuiCol_Header = 24,
    ImGuiCol_HeaderHovered = 25,
    ImGuiCol_HeaderActive = 26,
    ImGuiCol_Separator = 27,
    ImGuiCol_SeparatorHovered = 28,
    ImGuiCol_SeparatorActive = 29,
    ImGuiCol_ResizeGrip = 30,
    ImGuiCol_ResizeGripHovered = 31,
    ImGuiCol_ResizeGripActive = 32,
    ImGuiCol_Tab = 33,
    ImGuiCol_TabHovered = 34,
    ImGuiCol_TabActive = 35,
    ImGuiCol_TabUnfocused = 36,
    ImGuiCol_TabUnfocusedActive = 37,
    ImGuiCol_DockingPreview = 38,
    ImGuiCol_DockingEmptyBg = 39,
    ImGuiCol_PlotLines = 40,
    ImGuiCol_PlotLinesHovered = 41,
    ImGuiCol_PlotHistogram = 42,
    ImGuiCol_PlotHistogramHovered = 43,
    ImGuiCol_TableHeaderBg = 44,
    ImGuiCol_TableBorderStrong = 45,
    ImGuiCol_TableBorderLight = 46,
    ImGuiCol_TableRowBg = 47,
    ImGuiCol_TableRowBgAlt = 48,
    ImGuiCol_TextSelectedBg = 49,
    ImGuiCol_DragDropTarget = 50,
    ImGuiCol_NavHighlight = 51,
    ImGuiCol_NavWindowingHighlight = 52,
    ImGuiCol_NavWindowingDimBg = 53,
    ImGuiCol_ModalWindowDimBg = 54,
    ImGuiCol_COUNT = 55,
};
enum ImGuiStyleVar_{
    ImGuiStyleVar_Alpha = 0,
    ImGuiStyleVar_WindowPadding = 1,
    ImGuiStyleVar_WindowRounding = 2,
    ImGuiStyleVar_WindowBorderSize = 3,
    ImGuiStyleVar_WindowMinSize = 4,
    ImGuiStyleVar_WindowTitleAlign = 5,
    ImGuiStyleVar_ChildRounding = 6,
    ImGuiStyleVar_ChildBorderSize = 7,
    ImGuiStyleVar_PopupRounding = 8,
    ImGuiStyleVar_PopupBorderSize = 9,
    ImGuiStyleVar_FramePadding = 10,
    ImGuiStyleVar_FrameRounding = 11,
    ImGuiStyleVar_FrameBorderSize = 12,
    ImGuiStyleVar_ItemSpacing = 13,
    ImGuiStyleVar_ItemInnerSpacing = 14,
    ImGuiStyleVar_IndentSpacing = 15,
    ImGuiStyleVar_CellPadding = 16,
    ImGuiStyleVar_ScrollbarSize = 17,
    ImGuiStyleVar_ScrollbarRounding = 18,
    ImGuiStyleVar_GrabMinSize = 19,
    ImGuiStyleVar_GrabRounding = 20,
    ImGuiStyleVar_TabRounding = 21,
    ImGuiStyleVar_ButtonTextAlign = 22,
    ImGuiStyleVar_SelectableTextAlign = 23,
    ImGuiStyleVar_COUNT = 24,
};
enum ImGuiButtonFlags_{
    ImGuiButtonFlags_None = 0,
    ImGuiButtonFlags_MouseButtonLeft = 1 << 0,
    ImGuiButtonFlags_MouseButtonRight = 1 << 1,
    ImGuiButtonFlags_MouseButtonMiddle = 1 << 2,
    ImGuiButtonFlags_MouseButtonMask_ = ImGuiButtonFlags_MouseButtonLeft | ImGuiButtonFlags_MouseButtonRight | ImGuiButtonFlags_MouseButtonMiddle,
    ImGuiButtonFlags_MouseButtonDefault_ = ImGuiButtonFlags_MouseButtonLeft,
};
enum ImGuiColorEditFlags_{
    ImGuiColorEditFlags_None = 0,
    ImGuiColorEditFlags_NoAlpha = 1 << 1,
    ImGuiColorEditFlags_NoPicker = 1 << 2,
    ImGuiColorEditFlags_NoOptions = 1 << 3,
    ImGuiColorEditFlags_NoSmallPreview = 1 << 4,
    ImGuiColorEditFlags_NoInputs = 1 << 5,
    ImGuiColorEditFlags_NoTooltip = 1 << 6,
    ImGuiColorEditFlags_NoLabel = 1 << 7,
    ImGuiColorEditFlags_NoSidePreview = 1 << 8,
    ImGuiColorEditFlags_NoDragDrop = 1 << 9,
    ImGuiColorEditFlags_NoBorder = 1 << 10,
    ImGuiColorEditFlags_AlphaBar = 1 << 16,
    ImGuiColorEditFlags_AlphaPreview = 1 << 17,
    ImGuiColorEditFlags_AlphaPreviewHalf = 1 << 18,
    ImGuiColorEditFlags_HDR = 1 << 19,
    ImGuiColorEditFlags_DisplayRGB = 1 << 20,
    ImGuiColorEditFlags_DisplayHSV = 1 << 21,
    ImGuiColorEditFlags_DisplayHex = 1 << 22,
    ImGuiColorEditFlags_Uint8 = 1 << 23,
    ImGuiColorEditFlags_Float = 1 << 24,
    ImGuiColorEditFlags_PickerHueBar = 1 << 25,
    ImGuiColorEditFlags_PickerHueWheel = 1 << 26,
    ImGuiColorEditFlags_InputRGB = 1 << 27,
    ImGuiColorEditFlags_InputHSV = 1 << 28,
    ImGuiColorEditFlags__OptionsDefault = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_PickerHueBar,
    ImGuiColorEditFlags__DisplayMask = ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_DisplayHSV | ImGuiColorEditFlags_DisplayHex,
    ImGuiColorEditFlags__DataTypeMask = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_Float,
    ImGuiColorEditFlags__PickerMask = ImGuiColorEditFlags_PickerHueWheel | ImGuiColorEditFlags_PickerHueBar,
    ImGuiColorEditFlags__InputMask = ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_InputHSV,
    ImGuiColorEditFlags_RGB = ImGuiColorEditFlags_DisplayRGB,
    ImGuiColorEditFlags_HSV = ImGuiColorEditFlags_DisplayHSV,
    ImGuiColorEditFlags_HEX = ImGuiColorEditFlags_DisplayHex,
};
enum ImGuiSliderFlags_{
    ImGuiSliderFlags_None = 0,
    ImGuiSliderFlags_AlwaysClamp = 1 << 4,
    ImGuiSliderFlags_Logarithmic = 1 << 5,
    ImGuiSliderFlags_NoRoundToFormat = 1 << 6,
    ImGuiSliderFlags_NoInput = 1 << 7,
    ImGuiSliderFlags_InvalidMask_ = 0x7000000F,
    ImGuiSliderFlags_ClampOnInput = ImGuiSliderFlags_AlwaysClamp,
};
enum ImGuiMouseButton_{
    ImGuiMouseButton_Left = 0,
    ImGuiMouseButton_Right = 1,
    ImGuiMouseButton_Middle = 2,
    ImGuiMouseButton_COUNT = 5,
};
enum ImGuiMouseCursor_{
    ImGuiMouseCursor_None = -1,
    ImGuiMouseCursor_Arrow = 0,
    ImGuiMouseCursor_TextInput = 1,
    ImGuiMouseCursor_ResizeAll = 2,
    ImGuiMouseCursor_ResizeNS = 3,
    ImGuiMouseCursor_ResizeEW = 4,
    ImGuiMouseCursor_ResizeNESW = 5,
    ImGuiMouseCursor_ResizeNWSE = 6,
    ImGuiMouseCursor_Hand = 7,
    ImGuiMouseCursor_NotAllowed = 8,
    ImGuiMouseCursor_COUNT = 9,
};
enum ImGuiCond_{
    ImGuiCond_None = 0,
    ImGuiCond_Always = 1 << 0,
    ImGuiCond_Once = 1 << 1,
    ImGuiCond_FirstUseEver = 1 << 2,
    ImGuiCond_Appearing = 1 << 3,
};
struct ImVector{
    int Size;
    int Capacity;
    void* Data;
};
struct ImGuiStyle{
    float Alpha;
    struct ImVec2 WindowPadding;
    float WindowRounding;
    float WindowBorderSize;
    struct ImVec2 WindowMinSize;
    struct ImVec2 WindowTitleAlign;
    ImGuiDir WindowMenuButtonPosition;
    float ChildRounding;
    float ChildBorderSize;
    float PopupRounding;
    float PopupBorderSize;
    struct ImVec2 FramePadding;
    float FrameRounding;
    float FrameBorderSize;
    struct ImVec2 ItemSpacing;
    struct ImVec2 ItemInnerSpacing;
    struct ImVec2 CellPadding;
    struct ImVec2 TouchExtraPadding;
    float IndentSpacing;
    float ColumnsMinSpacing;
    float ScrollbarSize;
    float ScrollbarRounding;
    float GrabMinSize;
    float GrabRounding;
    float LogSliderDeadzone;
    float TabRounding;
    float TabBorderSize;
    float TabMinWidthForCloseButton;
    ImGuiDir ColorButtonPosition;
    struct ImVec2 ButtonTextAlign;
    struct ImVec2 SelectableTextAlign;
    struct ImVec2 DisplayWindowPadding;
    struct ImVec2 DisplaySafeAreaPadding;
    float MouseCursorScale;
    bool AntiAliasedLines;
    bool AntiAliasedLinesUseTex;
    bool AntiAliasedFill;
    float CurveTessellationTol;
    float CircleTessellationMaxError;
    struct ImVec4 Colors;
};
void ImGuiStyle_ScaleAllSizes(
    struct ImGuiStyle* this,
    float scale_factor
) asm("?ScaleAllSizes@ImGuiStyle@@QEAAXM@Z");
struct ImGuiIO{
    ImGuiConfigFlags ConfigFlags;
    ImGuiBackendFlags BackendFlags;
    struct ImVec2 DisplaySize;
    float DeltaTime;
    float IniSavingRate;
    const char* IniFilename;
    const char* LogFilename;
    float MouseDoubleClickTime;
    float MouseDoubleClickMaxDist;
    float MouseDragThreshold;
    int KeyMap[22];
    float KeyRepeatDelay;
    float KeyRepeatRate;
    void* UserData;
    struct ImFontAtlas* Fonts;
    float FontGlobalScale;
    bool FontAllowUserScaling;
    struct ImFont* FontDefault;
    struct ImVec2 DisplayFramebufferScale;
    bool ConfigDockingNoSplit;
    bool ConfigDockingAlwaysTabBar;
    bool ConfigDockingTransparentPayload;
    bool ConfigViewportsNoAutoMerge;
    bool ConfigViewportsNoTaskBarIcon;
    bool ConfigViewportsNoDecoration;
    bool ConfigViewportsNoDefaultParent;
    bool MouseDrawCursor;
    bool ConfigMacOSXBehaviors;
    bool ConfigInputTextCursorBlink;
    bool ConfigDragClickToInputText;
    bool ConfigWindowsResizeFromEdges;
    bool ConfigWindowsMoveFromTitleBarOnly;
    float ConfigMemoryCompactTimer;
    const char* BackendPlatformName;
    const char* BackendRendererName;
    void* BackendPlatformUserData;
    void* BackendRendererUserData;
    void* BackendLanguageUserData;
    const char*(*GetClipboardTextFn)(void* user_data);
    void(*SetClipboardTextFn)(void* user_data, const char* text);
    void* ClipboardUserData;
    struct ImVec2 MousePos;
    bool MouseDown[5];
    float MouseWheel;
    float MouseWheelH;
    ImGuiID MouseHoveredViewport;
    bool KeyCtrl;
    bool KeyShift;
    bool KeyAlt;
    bool KeySuper;
    bool KeysDown[512];
    float NavInputs[21];
    bool WantCaptureMouse;
    bool WantCaptureKeyboard;
    bool WantTextInput;
    bool WantSetMousePos;
    bool WantSaveIniSettings;
    bool NavActive;
    bool NavVisible;
    float Framerate;
    int MetricsRenderVertices;
    int MetricsRenderIndices;
    int MetricsRenderWindows;
    int MetricsActiveWindows;
    int MetricsActiveAllocations;
    struct ImVec2 MouseDelta;
    ImGuiKeyModFlags KeyMods;
    struct ImVec2 MousePosPrev;
    struct ImVec2 MouseClickedPos;
    double MouseClickedTime[5];
    bool MouseClicked[5];
    bool MouseDoubleClicked[5];
    bool MouseReleased[5];
    bool MouseDownOwned[5];
    bool MouseDownWasDoubleClick[5];
    float MouseDownDuration[5];
    float MouseDownDurationPrev[5];
    struct ImVec2 MouseDragMaxDistanceAbs;
    float MouseDragMaxDistanceSqr[5];
    float KeysDownDuration[512];
    float KeysDownDurationPrev[512];
    float NavInputsDownDuration[21];
    float NavInputsDownDurationPrev[21];
    float PenPressure;
    ImWchar16 InputQueueSurrogate;
    struct ImVector InputQueueCharacters;
};
void ImGuiIO_AddInputCharacter(
    struct ImGuiIO* this,
    unsigned int c
) asm("?AddInputCharacter@ImGuiIO@@QEAAXI@Z");
void ImGuiIO_AddInputCharacterUTF16(
    struct ImGuiIO* this,
    ImWchar16 c
) asm("?AddInputCharacterUTF16@ImGuiIO@@QEAAXG@Z");
void ImGuiIO_AddInputCharactersUTF8(
    struct ImGuiIO* this,
    const char* str
) asm("?AddInputCharactersUTF8@ImGuiIO@@QEAAXPEBD@Z");
void ImGuiIO_ClearInputCharacters(
    struct ImGuiIO* this
) asm("?ClearInputCharacters@ImGuiIO@@QEAAXXZ");
struct ImGuiInputTextCallbackData{
    ImGuiInputTextFlags EventFlag;
    ImGuiInputTextFlags Flags;
    void* UserData;
    ImWchar EventChar;
    ImGuiKey EventKey;
    char* Buf;
    int BufTextLen;
    int BufSize;
    bool BufDirty;
    int CursorPos;
    int SelectionStart;
    int SelectionEnd;
};
void ImGuiInputTextCallbackData_DeleteChars(
    struct ImGuiInputTextCallbackData* this,
    int pos,
    int bytes_count
) asm("?DeleteChars@ImGuiInputTextCallbackData@@QEAAXHH@Z");
void ImGuiInputTextCallbackData_InsertChars(
    struct ImGuiInputTextCallbackData* this,
    int pos,
    const char* text,
    const char* text_end
) asm("?InsertChars@ImGuiInputTextCallbackData@@QEAAXHPEBD0@Z");
struct ImGuiSizeCallbackData{
    void* UserData;
    struct ImVec2 Pos;
    struct ImVec2 CurrentSize;
    struct ImVec2 DesiredSize;
};
struct ImGuiWindowClass{
    ImGuiID ClassId;
    ImGuiID ParentViewportId;
    ImGuiViewportFlags ViewportFlagsOverrideSet;
    ImGuiViewportFlags ViewportFlagsOverrideClear;
    ImGuiTabItemFlags TabItemFlagsOverrideSet;
    ImGuiDockNodeFlags DockNodeFlagsOverrideSet;
    bool DockingAlwaysTabBar;
    bool DockingAllowUnclassed;
};
struct ImGuiPayload{
    void* Data;
    int DataSize;
    ImGuiID SourceId;
    ImGuiID SourceParentId;
    int DataFrameCount;
    char DataType[33];
    bool Preview;
    bool Delivery;
};
struct ImGuiTableColumnSortSpecs{
    ImGuiID ColumnUserID;
    ImS16 ColumnIndex;
    ImS16 SortOrder;
    ImGuiSortDirection SortDirection;
};
struct ImGuiTableSortSpecs{
    const struct ImGuiTableColumnSortSpecs* Specs;
    int SpecsCount;
    bool SpecsDirty;
};
struct ImGuiTextBuffer{
    struct ImVector Buf;
};
void ImGuiTextBuffer_append(
    struct ImGuiTextBuffer* this,
    const char* str,
    const char* str_end
) asm("?append@ImGuiTextBuffer@@QEAAXPEBD0@Z");
void ImGuiTextBuffer_appendf(
    struct ImGuiTextBuffer* this,
    const char* fmt
, ...
) asm("?appendf@ImGuiTextBuffer@@QEAAXPEBDZZ");
void ImGuiTextBuffer_appendfv(
    struct ImGuiTextBuffer* this,
    const char* fmt,
    va_list args
) asm("?appendfv@ImGuiTextBuffer@@QEAAXPEBDPEAD@Z");
struct ImGuiStoragePair{
    ImGuiID key;
};
struct ImGuiStorage{
    struct ImVector Data;
};
int ImGuiStorage_GetInt(
    struct ImGuiStorage* this,
    ImGuiID key,
    int default_val
) asm("?GetInt@ImGuiStorage@@QEBAHIH@Z");
void ImGuiStorage_SetInt(
    struct ImGuiStorage* this,
    ImGuiID key,
    int val
) asm("?SetInt@ImGuiStorage@@QEAAXIH@Z");
bool ImGuiStorage_GetBool(
    struct ImGuiStorage* this,
    ImGuiID key,
    bool default_val
) asm("?GetBool@ImGuiStorage@@QEBA_NI_N@Z");
void ImGuiStorage_SetBool(
    struct ImGuiStorage* this,
    ImGuiID key,
    bool val
) asm("?SetBool@ImGuiStorage@@QEAAXI_N@Z");
float ImGuiStorage_GetFloat(
    struct ImGuiStorage* this,
    ImGuiID key,
    float default_val
) asm("?GetFloat@ImGuiStorage@@QEBAMIM@Z");
void ImGuiStorage_SetFloat(
    struct ImGuiStorage* this,
    ImGuiID key,
    float val
) asm("?SetFloat@ImGuiStorage@@QEAAXIM@Z");
void* ImGuiStorage_GetVoidPtr(
    struct ImGuiStorage* this,
    ImGuiID key
) asm("?GetVoidPtr@ImGuiStorage@@QEBAPEAXI@Z");
void ImGuiStorage_SetVoidPtr(
    struct ImGuiStorage* this,
    ImGuiID key,
    void* val
) asm("?SetVoidPtr@ImGuiStorage@@QEAAXIPEAX@Z");
int* ImGuiStorage_GetIntRef(
    struct ImGuiStorage* this,
    ImGuiID key,
    int default_val
) asm("?GetIntRef@ImGuiStorage@@QEAAPEAHIH@Z");
bool* ImGuiStorage_GetBoolRef(
    struct ImGuiStorage* this,
    ImGuiID key,
    bool default_val
) asm("?GetBoolRef@ImGuiStorage@@QEAAPEA_NI_N@Z");
float* ImGuiStorage_GetFloatRef(
    struct ImGuiStorage* this,
    ImGuiID key,
    float default_val
) asm("?GetFloatRef@ImGuiStorage@@QEAAPEAMIM@Z");
void** ImGuiStorage_GetVoidPtrRef(
    struct ImGuiStorage* this,
    ImGuiID key,
    void* default_val
) asm("?GetVoidPtrRef@ImGuiStorage@@QEAAPEAPEAXIPEAX@Z");
void ImGuiStorage_SetAllInt(
    struct ImGuiStorage* this,
    int val
) asm("?SetAllInt@ImGuiStorage@@QEAAXH@Z");
void ImGuiStorage_BuildSortByKey(
    struct ImGuiStorage* this
) asm("?BuildSortByKey@ImGuiStorage@@QEAAXXZ");
typedef void(*ImDrawCallback)(const struct ImDrawList* parent_list, const struct ImDrawCmd* cmd);
struct ImDrawCmd{
    struct ImVec4 ClipRect;
    ImTextureID TextureId;
    unsigned int VtxOffset;
    unsigned int IdxOffset;
    unsigned int ElemCount;
    ImDrawCallback UserCallback;
    void* UserCallbackData;
};
typedef unsigned short ImDrawIdx;
struct ImDrawVert{
    struct ImVec2 pos;
    struct ImVec2 uv;
    ImU32 col;
};
struct ImDrawCmdHeader{
    struct ImVec4 ClipRect;
    ImTextureID TextureId;
    unsigned int VtxOffset;
};
struct ImDrawChannel{
    struct ImVector _CmdBuffer;
    struct ImVector _IdxBuffer;
};
struct ImDrawListSplitter{
    int _Current;
    int _Count;
    struct ImVector _Channels;
};
void ImDrawListSplitter_ClearFreeMemory(
    struct ImDrawListSplitter* this
) asm("?ClearFreeMemory@ImDrawListSplitter@@QEAAXXZ");
void ImDrawListSplitter_Split(
    struct ImDrawListSplitter* this,
    struct ImDrawList* draw_list,
    int count
) asm("?Split@ImDrawListSplitter@@QEAAXPEAUImDrawList@@H@Z");
void ImDrawListSplitter_Merge(
    struct ImDrawListSplitter* this,
    struct ImDrawList* draw_list
) asm("?Merge@ImDrawListSplitter@@QEAAXPEAUImDrawList@@@Z");
void ImDrawListSplitter_SetCurrentChannel(
    struct ImDrawListSplitter* this,
    struct ImDrawList* draw_list,
    int channel_idx
) asm("?SetCurrentChannel@ImDrawListSplitter@@QEAAXPEAUImDrawList@@H@Z");
enum ImDrawFlags_{
    ImDrawFlags_None = 0,
    ImDrawFlags_Closed = 1 << 0,
    ImDrawFlags_RoundCornersTopLeft = 1 << 4,
    ImDrawFlags_RoundCornersTopRight = 1 << 5,
    ImDrawFlags_RoundCornersBottomLeft = 1 << 6,
    ImDrawFlags_RoundCornersBottomRight = 1 << 7,
    ImDrawFlags_RoundCornersNone = 1 << 8,
    ImDrawFlags_RoundCornersTop = ImDrawFlags_RoundCornersTopLeft | ImDrawFlags_RoundCornersTopRight,
    ImDrawFlags_RoundCornersBottom = ImDrawFlags_RoundCornersBottomLeft | ImDrawFlags_RoundCornersBottomRight,
    ImDrawFlags_RoundCornersLeft = ImDrawFlags_RoundCornersBottomLeft | ImDrawFlags_RoundCornersTopLeft,
    ImDrawFlags_RoundCornersRight = ImDrawFlags_RoundCornersBottomRight | ImDrawFlags_RoundCornersTopRight,
    ImDrawFlags_RoundCornersAll = ImDrawFlags_RoundCornersTopLeft | ImDrawFlags_RoundCornersTopRight | ImDrawFlags_RoundCornersBottomLeft | ImDrawFlags_RoundCornersBottomRight,
    ImDrawFlags_RoundCornersDefault_ = ImDrawFlags_RoundCornersAll,
    ImDrawFlags_RoundCornersMask_ = ImDrawFlags_RoundCornersAll | ImDrawFlags_RoundCornersNone,
};
enum ImDrawListFlags_{
    ImDrawListFlags_None = 0,
    ImDrawListFlags_AntiAliasedLines = 1 << 0,
    ImDrawListFlags_AntiAliasedLinesUseTex = 1 << 1,
    ImDrawListFlags_AntiAliasedFill = 1 << 2,
    ImDrawListFlags_AllowVtxOffset = 1 << 3,
};
struct ImDrawList{
    struct ImVector CmdBuffer;
    struct ImVector IdxBuffer;
    struct ImVector VtxBuffer;
    ImDrawListFlags Flags;
    unsigned int _VtxCurrentIdx;
    const struct ImDrawListSharedData* _Data;
    const char* _OwnerName;
    struct ImDrawVert* _VtxWritePtr;
    ImDrawIdx* _IdxWritePtr;
    struct ImVector _ClipRectStack;
    struct ImVector _TextureIdStack;
    struct ImVector _Path;
    struct ImDrawCmdHeader _CmdHeader;
    struct ImDrawListSplitter _Splitter;
    float _FringeScale;
};
void ImDrawList_PushClipRect(
    struct ImDrawList* this,
    struct ImVec2 clip_rect_min,
    struct ImVec2 clip_rect_max,
    bool intersect_with_current_clip_rect
) asm("?PushClipRect@ImDrawList@@QEAAXUImVec2@@0_N@Z");
void ImDrawList_PushClipRectFullScreen(
    struct ImDrawList* this
) asm("?PushClipRectFullScreen@ImDrawList@@QEAAXXZ");
void ImDrawList_PopClipRect(
    struct ImDrawList* this
) asm("?PopClipRect@ImDrawList@@QEAAXXZ");
void ImDrawList_PushTextureID(
    struct ImDrawList* this,
    ImTextureID texture_id
) asm("?PushTextureID@ImDrawList@@QEAAXPEAX@Z");
void ImDrawList_PopTextureID(
    struct ImDrawList* this
) asm("?PopTextureID@ImDrawList@@QEAAXXZ");
void ImDrawList_AddLine(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    ImU32 col,
    float thickness
) asm("?AddLine@ImDrawList@@QEAAXAEBUImVec2@@0IM@Z");
void ImDrawList_AddRect(
    struct ImDrawList* this,
    const struct ImVec2* p_min,
    const struct ImVec2* p_max,
    ImU32 col,
    float rounding,
    ImDrawFlags flags,
    float thickness
) asm("?AddRect@ImDrawList@@QEAAXAEBUImVec2@@0IMHM@Z");
void ImDrawList_AddRectFilled(
    struct ImDrawList* this,
    const struct ImVec2* p_min,
    const struct ImVec2* p_max,
    ImU32 col,
    float rounding,
    ImDrawFlags flags
) asm("?AddRectFilled@ImDrawList@@QEAAXAEBUImVec2@@0IMH@Z");
void ImDrawList_AddRectFilledMultiColor(
    struct ImDrawList* this,
    const struct ImVec2* p_min,
    const struct ImVec2* p_max,
    ImU32 col_upr_left,
    ImU32 col_upr_right,
    ImU32 col_bot_right,
    ImU32 col_bot_left
) asm("?AddRectFilledMultiColor@ImDrawList@@QEAAXAEBUImVec2@@0IIII@Z");
void ImDrawList_AddQuad(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    const struct ImVec2* p4,
    ImU32 col,
    float thickness
) asm("?AddQuad@ImDrawList@@QEAAXAEBUImVec2@@000IM@Z");
void ImDrawList_AddQuadFilled(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    const struct ImVec2* p4,
    ImU32 col
) asm("?AddQuadFilled@ImDrawList@@QEAAXAEBUImVec2@@000I@Z");
void ImDrawList_AddTriangle(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    ImU32 col,
    float thickness
) asm("?AddTriangle@ImDrawList@@QEAAXAEBUImVec2@@00IM@Z");
void ImDrawList_AddTriangleFilled(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    ImU32 col
) asm("?AddTriangleFilled@ImDrawList@@QEAAXAEBUImVec2@@00I@Z");
void ImDrawList_AddCircle(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    ImU32 col,
    int num_segments,
    float thickness
) asm("?AddCircle@ImDrawList@@QEAAXAEBUImVec2@@MIHM@Z");
void ImDrawList_AddCircleFilled(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    ImU32 col,
    int num_segments
) asm("?AddCircleFilled@ImDrawList@@QEAAXAEBUImVec2@@MIH@Z");
void ImDrawList_AddNgon(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    ImU32 col,
    int num_segments,
    float thickness
) asm("?AddNgon@ImDrawList@@QEAAXAEBUImVec2@@MIHM@Z");
void ImDrawList_AddNgonFilled(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    ImU32 col,
    int num_segments
) asm("?AddNgonFilled@ImDrawList@@QEAAXAEBUImVec2@@MIH@Z");
void ImDrawList_AddText(
    struct ImDrawList* this,
    const struct ImVec2* pos,
    ImU32 col,
    const char* text_begin,
    const char* text_end
) asm("?AddText@ImDrawList@@QEAAXAEBUImVec2@@IPEBD1@Z");
void ImDrawList_AddText(
    struct ImDrawList* this,
    const struct ImFont* font,
    float font_size,
    const struct ImVec2* pos,
    ImU32 col,
    const char* text_begin,
    const char* text_end,
    float wrap_width,
    const struct ImVec4* cpu_fine_clip_rect
) asm("?AddText@ImDrawList@@QEAAXPEBUImFont@@MAEBUImVec2@@IPEBD2MPEBUImVec4@@@Z");
void ImDrawList_AddPolyline(
    struct ImDrawList* this,
    const struct ImVec2* points,
    int num_points,
    ImU32 col,
    ImDrawFlags flags,
    float thickness
) asm("?AddPolyline@ImDrawList@@QEAAXPEBUImVec2@@HIHM@Z");
void ImDrawList_AddConvexPolyFilled(
    struct ImDrawList* this,
    const struct ImVec2* points,
    int num_points,
    ImU32 col
) asm("?AddConvexPolyFilled@ImDrawList@@QEAAXPEBUImVec2@@HI@Z");
void ImDrawList_AddBezierCubic(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    const struct ImVec2* p4,
    ImU32 col,
    float thickness,
    int num_segments
) asm("?AddBezierCubic@ImDrawList@@QEAAXAEBUImVec2@@000IMH@Z");
void ImDrawList_AddBezierQuadratic(
    struct ImDrawList* this,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    ImU32 col,
    float thickness,
    int num_segments
) asm("?AddBezierQuadratic@ImDrawList@@QEAAXAEBUImVec2@@00IMH@Z");
void ImDrawList_AddImage(
    struct ImDrawList* this,
    ImTextureID user_texture_id,
    const struct ImVec2* p_min,
    const struct ImVec2* p_max,
    const struct ImVec2* uv_min,
    const struct ImVec2* uv_max,
    ImU32 col
) asm("?AddImage@ImDrawList@@QEAAXPEAXAEBUImVec2@@111I@Z");
void ImDrawList_AddImageQuad(
    struct ImDrawList* this,
    ImTextureID user_texture_id,
    const struct ImVec2* p1,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    const struct ImVec2* p4,
    const struct ImVec2* uv1,
    const struct ImVec2* uv2,
    const struct ImVec2* uv3,
    const struct ImVec2* uv4,
    ImU32 col
) asm("?AddImageQuad@ImDrawList@@QEAAXPEAXAEBUImVec2@@1111111I@Z");
void ImDrawList_AddImageRounded(
    struct ImDrawList* this,
    ImTextureID user_texture_id,
    const struct ImVec2* p_min,
    const struct ImVec2* p_max,
    const struct ImVec2* uv_min,
    const struct ImVec2* uv_max,
    ImU32 col,
    float rounding,
    ImDrawFlags flags
) asm("?AddImageRounded@ImDrawList@@QEAAXPEAXAEBUImVec2@@111IMH@Z");
void ImDrawList_PathArcTo(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    float a_min,
    float a_max,
    int num_segments
) asm("?PathArcTo@ImDrawList@@QEAAXAEBUImVec2@@MMMH@Z");
void ImDrawList_PathArcToFast(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    int a_min_of_12,
    int a_max_of_12
) asm("?PathArcToFast@ImDrawList@@QEAAXAEBUImVec2@@MHH@Z");
void ImDrawList_PathBezierCubicCurveTo(
    struct ImDrawList* this,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    const struct ImVec2* p4,
    int num_segments
) asm("?PathBezierCubicCurveTo@ImDrawList@@QEAAXAEBUImVec2@@00H@Z");
void ImDrawList_PathBezierQuadraticCurveTo(
    struct ImDrawList* this,
    const struct ImVec2* p2,
    const struct ImVec2* p3,
    int num_segments
) asm("?PathBezierQuadraticCurveTo@ImDrawList@@QEAAXAEBUImVec2@@0H@Z");
void ImDrawList_PathRect(
    struct ImDrawList* this,
    const struct ImVec2* rect_min,
    const struct ImVec2* rect_max,
    float rounding,
    ImDrawFlags flags
) asm("?PathRect@ImDrawList@@QEAAXAEBUImVec2@@0MH@Z");
void ImDrawList_AddCallback(
    struct ImDrawList* this,
    ImDrawCallback callback,
    void* callback_data
) asm("?AddCallback@ImDrawList@@QEAAXP6AXPEBU1@PEBUImDrawCmd@@@ZPEAX@Z");
void ImDrawList_AddDrawCmd(
    struct ImDrawList* this
) asm("?AddDrawCmd@ImDrawList@@QEAAXXZ");
struct ImDrawList* ImDrawList_CloneOutput(
    struct ImDrawList* this
) asm("?CloneOutput@ImDrawList@@QEBAPEAU1@XZ");
void ImDrawList_PrimReserve(
    struct ImDrawList* this,
    int idx_count,
    int vtx_count
) asm("?PrimReserve@ImDrawList@@QEAAXHH@Z");
void ImDrawList_PrimUnreserve(
    struct ImDrawList* this,
    int idx_count,
    int vtx_count
) asm("?PrimUnreserve@ImDrawList@@QEAAXHH@Z");
void ImDrawList_PrimRect(
    struct ImDrawList* this,
    const struct ImVec2* a,
    const struct ImVec2* b,
    ImU32 col
) asm("?PrimRect@ImDrawList@@QEAAXAEBUImVec2@@0I@Z");
void ImDrawList_PrimRectUV(
    struct ImDrawList* this,
    const struct ImVec2* a,
    const struct ImVec2* b,
    const struct ImVec2* uv_a,
    const struct ImVec2* uv_b,
    ImU32 col
) asm("?PrimRectUV@ImDrawList@@QEAAXAEBUImVec2@@000I@Z");
void ImDrawList_PrimQuadUV(
    struct ImDrawList* this,
    const struct ImVec2* a,
    const struct ImVec2* b,
    const struct ImVec2* c,
    const struct ImVec2* d,
    const struct ImVec2* uv_a,
    const struct ImVec2* uv_b,
    const struct ImVec2* uv_c,
    const struct ImVec2* uv_d,
    ImU32 col
) asm("?PrimQuadUV@ImDrawList@@QEAAXAEBUImVec2@@0000000I@Z");
void ImDrawList__ResetForNewFrame(
    struct ImDrawList* this
) asm("?_ResetForNewFrame@ImDrawList@@QEAAXXZ");
void ImDrawList__ClearFreeMemory(
    struct ImDrawList* this
) asm("?_ClearFreeMemory@ImDrawList@@QEAAXXZ");
void ImDrawList__PopUnusedDrawCmd(
    struct ImDrawList* this
) asm("?_PopUnusedDrawCmd@ImDrawList@@QEAAXXZ");
void ImDrawList__TryMergeDrawCmds(
    struct ImDrawList* this
) asm("?_TryMergeDrawCmds@ImDrawList@@QEAAXXZ");
void ImDrawList__OnChangedClipRect(
    struct ImDrawList* this
) asm("?_OnChangedClipRect@ImDrawList@@QEAAXXZ");
void ImDrawList__OnChangedTextureID(
    struct ImDrawList* this
) asm("?_OnChangedTextureID@ImDrawList@@QEAAXXZ");
void ImDrawList__OnChangedVtxOffset(
    struct ImDrawList* this
) asm("?_OnChangedVtxOffset@ImDrawList@@QEAAXXZ");
int ImDrawList__CalcCircleAutoSegmentCount(
    struct ImDrawList* this,
    float radius
) asm("?_CalcCircleAutoSegmentCount@ImDrawList@@QEBAHM@Z");
void ImDrawList__PathArcToFastEx(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    int a_min_sample,
    int a_max_sample,
    int a_step
) asm("?_PathArcToFastEx@ImDrawList@@QEAAXAEBUImVec2@@MHHH@Z");
void ImDrawList__PathArcToN(
    struct ImDrawList* this,
    const struct ImVec2* center,
    float radius,
    float a_min,
    float a_max,
    int num_segments
) asm("?_PathArcToN@ImDrawList@@QEAAXAEBUImVec2@@MMMH@Z");
struct ImDrawData{
    bool Valid;
    int CmdListsCount;
    int TotalIdxCount;
    int TotalVtxCount;
    struct ImDrawList* CmdLists;
    struct ImVec2 DisplayPos;
    struct ImVec2 DisplaySize;
    struct ImVec2 FramebufferScale;
    struct ImGuiViewport* OwnerViewport;
};
void ImDrawData_DeIndexAllBuffers(
    struct ImDrawData* this
) asm("?DeIndexAllBuffers@ImDrawData@@QEAAXXZ");
void ImDrawData_ScaleClipRects(
    struct ImDrawData* this,
    const struct ImVec2* fb_scale
) asm("?ScaleClipRects@ImDrawData@@QEAAXAEBUImVec2@@@Z");
struct ImFontConfig{
    void* FontData;
    int FontDataSize;
    bool FontDataOwnedByAtlas;
    int FontNo;
    float SizePixels;
    int OversampleH;
    int OversampleV;
    bool PixelSnapH;
    struct ImVec2 GlyphExtraSpacing;
    struct ImVec2 GlyphOffset;
    ImWchar* GlyphRanges;
    float GlyphMinAdvanceX;
    float GlyphMaxAdvanceX;
    bool MergeMode;
    unsigned int FontBuilderFlags;
    float RasterizerMultiply;
    ImWchar EllipsisChar;
    char Name[40];
    struct ImFont* DstFont;
};
struct ImFontGlyph{
    unsigned int Colored;
    unsigned int Visible;
    unsigned int Codepoint;
    float AdvanceX;
    float X0;
    float Y0;
    float X1;
    float Y1;
    float U0;
    float V0;
    float U1;
    float V1;
};
struct ImFontAtlasCustomRect{
    unsigned short Width;
    unsigned short Height;
    unsigned short X;
    unsigned short Y;
    unsigned int GlyphID;
    float GlyphAdvanceX;
    struct ImVec2 GlyphOffset;
    struct ImFont* Font;
};
enum ImFontAtlasFlags_{
    ImFontAtlasFlags_None = 0,
    ImFontAtlasFlags_NoPowerOfTwoHeight = 1 << 0,
    ImFontAtlasFlags_NoMouseCursors = 1 << 1,
    ImFontAtlasFlags_NoBakedLines = 1 << 2,
};
struct ImFontAtlas{
    ImFontAtlasFlags Flags;
    ImTextureID TexID;
    int TexDesiredWidth;
    int TexGlyphPadding;
    bool Locked;
    bool TexReady;
    bool TexPixelsUseColors;
    unsigned char* TexPixelsAlpha8;
    unsigned int* TexPixelsRGBA32;
    int TexWidth;
    int TexHeight;
    struct ImVec2 TexUvScale;
    struct ImVec2 TexUvWhitePixel;
    struct ImVector Fonts;
    struct ImVector CustomRects;
    struct ImVector ConfigData;
    struct ImVec4 TexUvLines;
    const struct ImFontBuilderIO* FontBuilderIO;
    unsigned int FontBuilderFlags;
    int PackIdMouseCursors;
    int PackIdLines;
};
struct ImFont* ImFontAtlas_AddFont(
    struct ImFontAtlas* this,
    const struct ImFontConfig* font_cfg
) asm("?AddFont@ImFontAtlas@@QEAAPEAUImFont@@PEBUImFontConfig@@@Z");
struct ImFont* ImFontAtlas_AddFontDefault(
    struct ImFontAtlas* this,
    const struct ImFontConfig* font_cfg
) asm("?AddFontDefault@ImFontAtlas@@QEAAPEAUImFont@@PEBUImFontConfig@@@Z");
struct ImFont* ImFontAtlas_AddFontFromFileTTF(
    struct ImFontAtlas* this,
    const char* filename,
    float size_pixels,
    const struct ImFontConfig* font_cfg,
    ImWchar* glyph_ranges
) asm("?AddFontFromFileTTF@ImFontAtlas@@QEAAPEAUImFont@@PEBDMPEBUImFontConfig@@PEBG@Z");
struct ImFont* ImFontAtlas_AddFontFromMemoryTTF(
    struct ImFontAtlas* this,
    void* font_data,
    int font_size,
    float size_pixels,
    const struct ImFontConfig* font_cfg,
    ImWchar* glyph_ranges
) asm("?AddFontFromMemoryTTF@ImFontAtlas@@QEAAPEAUImFont@@PEAXHMPEBUImFontConfig@@PEBG@Z");
struct ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(
    struct ImFontAtlas* this,
    const void* compressed_font_data,
    int compressed_font_size,
    float size_pixels,
    const struct ImFontConfig* font_cfg,
    ImWchar* glyph_ranges
) asm("?AddFontFromMemoryCompressedTTF@ImFontAtlas@@QEAAPEAUImFont@@PEBXHMPEBUImFontConfig@@PEBG@Z");
struct ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(
    struct ImFontAtlas* this,
    const char* compressed_font_data_base85,
    float size_pixels,
    const struct ImFontConfig* font_cfg,
    ImWchar* glyph_ranges
) asm("?AddFontFromMemoryCompressedBase85TTF@ImFontAtlas@@QEAAPEAUImFont@@PEBDMPEBUImFontConfig@@PEBG@Z");
void ImFontAtlas_ClearInputData(
    struct ImFontAtlas* this
) asm("?ClearInputData@ImFontAtlas@@QEAAXXZ");
void ImFontAtlas_ClearTexData(
    struct ImFontAtlas* this
) asm("?ClearTexData@ImFontAtlas@@QEAAXXZ");
void ImFontAtlas_ClearFonts(
    struct ImFontAtlas* this
) asm("?ClearFonts@ImFontAtlas@@QEAAXXZ");
void ImFontAtlas_Clear(
    struct ImFontAtlas* this
) asm("?Clear@ImFontAtlas@@QEAAXXZ");
bool ImFontAtlas_Build(
    struct ImFontAtlas* this
) asm("?Build@ImFontAtlas@@QEAA_NXZ");
void ImFontAtlas_GetTexDataAsAlpha8(
    struct ImFontAtlas* this,
    unsigned char** out_pixels,
    int* out_width,
    int* out_height,
    int* out_bytes_per_pixel
) asm("?GetTexDataAsAlpha8@ImFontAtlas@@QEAAXPEAPEAEPEAH11@Z");
void ImFontAtlas_GetTexDataAsRGBA32(
    struct ImFontAtlas* this,
    unsigned char** out_pixels,
    int* out_width,
    int* out_height,
    int* out_bytes_per_pixel
) asm("?GetTexDataAsRGBA32@ImFontAtlas@@QEAAXPEAPEAEPEAH11@Z");
ImWchar* ImFontAtlas_GetGlyphRangesDefault(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesDefault@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesKorean(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesKorean@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesJapanese(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesJapanese@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesChineseFull@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesChineseSimplifiedCommon@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesCyrillic@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesThai(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesThai@ImFontAtlas@@QEAAPEBGXZ");
ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(
    struct ImFontAtlas* this
) asm("?GetGlyphRangesVietnamese@ImFontAtlas@@QEAAPEBGXZ");
int ImFontAtlas_AddCustomRectRegular(
    struct ImFontAtlas* this,
    int width,
    int height
) asm("?AddCustomRectRegular@ImFontAtlas@@QEAAHHH@Z");
int ImFontAtlas_AddCustomRectFontGlyph(
    struct ImFontAtlas* this,
    struct ImFont* font,
    ImWchar id,
    int width,
    int height,
    float advance_x,
    const struct ImVec2* offset
) asm("?AddCustomRectFontGlyph@ImFontAtlas@@QEAAHPEAUImFont@@GHHMAEBUImVec2@@@Z");
void ImFontAtlas_CalcCustomRectUV(
    struct ImFontAtlas* this,
    const struct ImFontAtlasCustomRect* rect,
    struct ImVec2* out_uv_min,
    struct ImVec2* out_uv_max
) asm("?CalcCustomRectUV@ImFontAtlas@@QEBAXPEBUImFontAtlasCustomRect@@PEAUImVec2@@1@Z");
bool ImFontAtlas_GetMouseCursorTexData(
    struct ImFontAtlas* this,
    ImGuiMouseCursor cursor,
    struct ImVec2* out_offset,
    struct ImVec2* out_size,
    struct ImVec2 out_uv_border,
    struct ImVec2 out_uv_fill
) asm("?GetMouseCursorTexData@ImFontAtlas@@QEAA_NHPEAUImVec2@@0QEAU2@1@Z");
struct ImFont{
    struct ImVector IndexAdvanceX;
    float FallbackAdvanceX;
    float FontSize;
    struct ImVector IndexLookup;
    struct ImVector Glyphs;
    const struct ImFontGlyph* FallbackGlyph;
    struct ImFontAtlas* ContainerAtlas;
    const struct ImFontConfig* ConfigData;
    short ConfigDataCount;
    ImWchar FallbackChar;
    ImWchar EllipsisChar;
    ImWchar DotChar;
    bool DirtyLookupTables;
    float Scale;
    float Ascent;
    float Descent;
    int MetricsTotalSurface;
    ImU8 Used4kPagesMap;
};
const struct ImFontGlyph* ImFont_FindGlyph(
    struct ImFont* this,
    ImWchar c
) asm("?FindGlyph@ImFont@@QEBAPEBUImFontGlyph@@G@Z");
const struct ImFontGlyph* ImFont_FindGlyphNoFallback(
    struct ImFont* this,
    ImWchar c
) asm("?FindGlyphNoFallback@ImFont@@QEBAPEBUImFontGlyph@@G@Z");
struct ImVec2 ImFont_CalcTextSizeA(
    struct ImFont* this,
    float size,
    float max_width,
    float wrap_width,
    const char* text_begin,
    const char* text_end,
    const char** remaining
) asm("?CalcTextSizeA@ImFont@@QEBA?AUImVec2@@MMMPEBD0PEAPEBD@Z");
const char* ImFont_CalcWordWrapPositionA(
    struct ImFont* this,
    float scale,
    const char* text,
    const char* text_end,
    float wrap_width
) asm("?CalcWordWrapPositionA@ImFont@@QEBAPEBDMPEBD0M@Z");
void ImFont_RenderChar(
    struct ImFont* this,
    struct ImDrawList* draw_list,
    float size,
    struct ImVec2 pos,
    ImU32 col,
    ImWchar c
) asm("?RenderChar@ImFont@@QEBAXPEAUImDrawList@@MUImVec2@@IG@Z");
void ImFont_RenderText(
    struct ImFont* this,
    struct ImDrawList* draw_list,
    float size,
    struct ImVec2 pos,
    ImU32 col,
    const struct ImVec4* clip_rect,
    const char* text_begin,
    const char* text_end,
    float wrap_width,
    bool cpu_fine_clip
) asm("?RenderText@ImFont@@QEBAXPEAUImDrawList@@MUImVec2@@IAEBUImVec4@@PEBD3M_N@Z");
void ImFont_BuildLookupTable(
    struct ImFont* this
) asm("?BuildLookupTable@ImFont@@QEAAXXZ");
void ImFont_ClearOutputData(
    struct ImFont* this
) asm("?ClearOutputData@ImFont@@QEAAXXZ");
void ImFont_GrowIndex(
    struct ImFont* this,
    int new_size
) asm("?GrowIndex@ImFont@@QEAAXH@Z");
void ImFont_AddGlyph(
    struct ImFont* this,
    const struct ImFontConfig* src_cfg,
    ImWchar c,
    float x0,
    float y0,
    float x1,
    float y1,
    float u0,
    float v0,
    float u1,
    float v1,
    float advance_x
) asm("?AddGlyph@ImFont@@QEAAXPEBUImFontConfig@@GMMMMMMMMM@Z");
void ImFont_AddRemapChar(
    struct ImFont* this,
    ImWchar dst,
    ImWchar src,
    bool overwrite_dst
) asm("?AddRemapChar@ImFont@@QEAAXGG_N@Z");
void ImFont_SetGlyphVisible(
    struct ImFont* this,
    ImWchar c,
    bool visible
) asm("?SetGlyphVisible@ImFont@@QEAAXG_N@Z");
bool ImFont_IsGlyphRangeUnused(
    struct ImFont* this,
    unsigned int c_begin,
    unsigned int c_last
) asm("?IsGlyphRangeUnused@ImFont@@QEAA_NII@Z");
enum ImGuiViewportFlags_{
    ImGuiViewportFlags_None = 0,
    ImGuiViewportFlags_IsPlatformWindow = 1 << 0,
    ImGuiViewportFlags_IsPlatformMonitor = 1 << 1,
    ImGuiViewportFlags_OwnedByApp = 1 << 2,
    ImGuiViewportFlags_NoDecoration = 1 << 3,
    ImGuiViewportFlags_NoTaskBarIcon = 1 << 4,
    ImGuiViewportFlags_NoFocusOnAppearing = 1 << 5,
    ImGuiViewportFlags_NoFocusOnClick = 1 << 6,
    ImGuiViewportFlags_NoInputs = 1 << 7,
    ImGuiViewportFlags_NoRendererClear = 1 << 8,
    ImGuiViewportFlags_TopMost = 1 << 9,
    ImGuiViewportFlags_Minimized = 1 << 10,
    ImGuiViewportFlags_NoAutoMerge = 1 << 11,
    ImGuiViewportFlags_CanHostOtherWindows = 1 << 12,
};
struct ImGuiViewport{
    ImGuiID ID;
    ImGuiViewportFlags Flags;
    struct ImVec2 Pos;
    struct ImVec2 Size;
    struct ImVec2 WorkPos;
    struct ImVec2 WorkSize;
    float DpiScale;
    ImGuiID ParentViewportId;
    struct ImDrawData* DrawData;
    void* RendererUserData;
    void* PlatformUserData;
    void* PlatformHandle;
    void* PlatformHandleRaw;
    bool PlatformRequestMove;
    bool PlatformRequestResize;
    bool PlatformRequestClose;
};
struct ImGuiPlatformIO{
    void(*Platform_CreateWindow)(struct ImGuiViewport* vp);
    void(*Platform_DestroyWindow)(struct ImGuiViewport* vp);
    void(*Platform_ShowWindow)(struct ImGuiViewport* vp);
    void(*Platform_SetWindowPos)(struct ImGuiViewport* vp, struct ImVec2 pos);
    struct ImVec2* Platform_GetWindowPos;
    void(*Platform_SetWindowSize)(struct ImGuiViewport* vp, struct ImVec2 size);
    struct ImVec2* Platform_GetWindowSize;
    void(*Platform_SetWindowFocus)(struct ImGuiViewport* vp);
    bool(*Platform_GetWindowFocus)(struct ImGuiViewport* vp);
    bool(*Platform_GetWindowMinimized)(struct ImGuiViewport* vp);
    void(*Platform_SetWindowTitle)(struct ImGuiViewport* vp, const char* str);
    void(*Platform_SetWindowAlpha)(struct ImGuiViewport* vp, float alpha);
    void(*Platform_UpdateWindow)(struct ImGuiViewport* vp);
    void(*Platform_RenderWindow)(struct ImGuiViewport* vp, void* render_arg);
    void(*Platform_SwapBuffers)(struct ImGuiViewport* vp, void* render_arg);
    float(*Platform_GetWindowDpiScale)(struct ImGuiViewport* vp);
    void(*Platform_OnChangedViewport)(struct ImGuiViewport* vp);
    void(*Platform_SetImeInputPos)(struct ImGuiViewport* vp, struct ImVec2 pos);
    int(*Platform_CreateVkSurface)(struct ImGuiViewport* vp, ImU64 vk_inst, const void* vk_allocators, ImU64* out_vk_surface);
    void(*Renderer_CreateWindow)(struct ImGuiViewport* vp);
    void(*Renderer_DestroyWindow)(struct ImGuiViewport* vp);
    void(*Renderer_SetWindowSize)(struct ImGuiViewport* vp, struct ImVec2 size);
    void(*Renderer_RenderWindow)(struct ImGuiViewport* vp, void* render_arg);
    void(*Renderer_SwapBuffers)(struct ImGuiViewport* vp, void* render_arg);
    struct ImVector Monitors;
    struct ImVector Viewports;
};
struct ImGuiPlatformMonitor{
    struct ImVec2 MainPos;
    struct ImVec2 MainSize;
    struct ImVec2 WorkPos;
    struct ImVec2 WorkSize;
    float DpiScale;
};
enum ImDrawCornerFlags_{
    ImDrawCornerFlags_None = 256,
    ImDrawCornerFlags_TopLeft = 16,
    ImDrawCornerFlags_TopRight = 32,
    ImDrawCornerFlags_BotLeft = 64,
    ImDrawCornerFlags_BotRight = 128,
    ImDrawCornerFlags_All = 240,
    ImDrawCornerFlags_Top = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_TopRight,
    ImDrawCornerFlags_Bot = ImDrawCornerFlags_BotLeft | ImDrawCornerFlags_BotRight,
    ImDrawCornerFlags_Left = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_BotLeft,
    ImDrawCornerFlags_Right = ImDrawCornerFlags_TopRight | ImDrawCornerFlags_BotRight,
};
struct ImGuiContext* CreateContext(
    struct ImFontAtlas* shared_font_atlas
) asm("?CreateContext@ImGui@@YAPEAUImGuiContext@@PEAUImFontAtlas@@@Z");
void DestroyContext(
    struct ImGuiContext* ctx
) asm("?DestroyContext@ImGui@@YAXPEAUImGuiContext@@@Z");
struct ImGuiContext* GetCurrentContext(
) asm("?GetCurrentContext@ImGui@@YAPEAUImGuiContext@@XZ");
void SetCurrentContext(
    struct ImGuiContext* ctx
) asm("?SetCurrentContext@ImGui@@YAXPEAUImGuiContext@@@Z");
struct ImGuiIO* GetIO(
) asm("?GetIO@ImGui@@YAAEAUImGuiIO@@XZ");
struct ImGuiStyle* GetStyle(
) asm("?GetStyle@ImGui@@YAAEAUImGuiStyle@@XZ");
void NewFrame(
) asm("?NewFrame@ImGui@@YAXXZ");
void EndFrame(
) asm("?EndFrame@ImGui@@YAXXZ");
void Render(
) asm("?Render@ImGui@@YAXXZ");
struct ImDrawData* GetDrawData(
) asm("?GetDrawData@ImGui@@YAPEAUImDrawData@@XZ");
void ShowDemoWindow(
    bool* p_open
) asm("?ShowDemoWindow@ImGui@@YAXPEA_N@Z");
void ShowMetricsWindow(
    bool* p_open
) asm("?ShowMetricsWindow@ImGui@@YAXPEA_N@Z");
void ShowAboutWindow(
    bool* p_open
) asm("?ShowAboutWindow@ImGui@@YAXPEA_N@Z");
void ShowStyleEditor(
    struct ImGuiStyle* ref
) asm("?ShowStyleEditor@ImGui@@YAXPEAUImGuiStyle@@@Z");
bool ShowStyleSelector(
    const char* label
) asm("?ShowStyleSelector@ImGui@@YA_NPEBD@Z");
void ShowFontSelector(
    const char* label
) asm("?ShowFontSelector@ImGui@@YAXPEBD@Z");
void ShowUserGuide(
) asm("?ShowUserGuide@ImGui@@YAXXZ");
const char* GetVersion(
) asm("?GetVersion@ImGui@@YAPEBDXZ");
void StyleColorsDark(
    struct ImGuiStyle* dst
) asm("?StyleColorsDark@ImGui@@YAXPEAUImGuiStyle@@@Z");
void StyleColorsLight(
    struct ImGuiStyle* dst
) asm("?StyleColorsLight@ImGui@@YAXPEAUImGuiStyle@@@Z");
void StyleColorsClassic(
    struct ImGuiStyle* dst
) asm("?StyleColorsClassic@ImGui@@YAXPEAUImGuiStyle@@@Z");
bool Begin(
    const char* name,
    bool* p_open,
    ImGuiWindowFlags flags
) asm("?Begin@ImGui@@YA_NPEBDPEA_NH@Z");
void End(
) asm("?End@ImGui@@YAXXZ");
bool BeginChild(
    const char* str_id,
    const struct ImVec2* size,
    bool border,
    ImGuiWindowFlags flags
) asm("?BeginChild@ImGui@@YA_NPEBDAEBUImVec2@@_NH@Z");
bool BeginChild__1(
    ImGuiID id,
    const struct ImVec2* size,
    bool border,
    ImGuiWindowFlags flags
) asm("?BeginChild@ImGui@@YA_NIAEBUImVec2@@_NH@Z");
void EndChild(
) asm("?EndChild@ImGui@@YAXXZ");
bool IsWindowAppearing(
) asm("?IsWindowAppearing@ImGui@@YA_NXZ");
bool IsWindowCollapsed(
) asm("?IsWindowCollapsed@ImGui@@YA_NXZ");
bool IsWindowFocused(
    ImGuiFocusedFlags flags
) asm("?IsWindowFocused@ImGui@@YA_NH@Z");
bool IsWindowHovered(
    ImGuiHoveredFlags flags
) asm("?IsWindowHovered@ImGui@@YA_NH@Z");
struct ImDrawList* GetWindowDrawList(
) asm("?GetWindowDrawList@ImGui@@YAPEAUImDrawList@@XZ");
float GetWindowDpiScale(
) asm("?GetWindowDpiScale@ImGui@@YAMXZ");
struct ImVec2 GetWindowPos(
) asm("?GetWindowPos@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetWindowSize(
) asm("?GetWindowSize@ImGui@@YA?AUImVec2@@XZ");
float GetWindowWidth(
) asm("?GetWindowWidth@ImGui@@YAMXZ");
float GetWindowHeight(
) asm("?GetWindowHeight@ImGui@@YAMXZ");
struct ImGuiViewport* GetWindowViewport(
) asm("?GetWindowViewport@ImGui@@YAPEAUImGuiViewport@@XZ");
void SetNextWindowPos(
    const struct ImVec2* pos,
    ImGuiCond cond,
    const struct ImVec2* pivot
) asm("?SetNextWindowPos@ImGui@@YAXAEBUImVec2@@H0@Z");
void SetNextWindowSize(
    const struct ImVec2* size,
    ImGuiCond cond
) asm("?SetNextWindowSize@ImGui@@YAXAEBUImVec2@@H@Z");
void SetNextWindowSizeConstraints(
    const struct ImVec2* size_min,
    const struct ImVec2* size_max,
    ImGuiSizeCallback custom_callback,
    void* custom_callback_data
) asm("?SetNextWindowSizeConstraints@ImGui@@YAXAEBUImVec2@@0P6AXPEAUImGuiSizeCallbackData@@@ZPEAX@Z");
void SetNextWindowContentSize(
    const struct ImVec2* size
) asm("?SetNextWindowContentSize@ImGui@@YAXAEBUImVec2@@@Z");
void SetNextWindowCollapsed(
    bool collapsed,
    ImGuiCond cond
) asm("?SetNextWindowCollapsed@ImGui@@YAX_NH@Z");
void SetNextWindowFocus(
) asm("?SetNextWindowFocus@ImGui@@YAXXZ");
void SetNextWindowBgAlpha(
    float alpha
) asm("?SetNextWindowBgAlpha@ImGui@@YAXM@Z");
void SetNextWindowViewport(
    ImGuiID viewport_id
) asm("?SetNextWindowViewport@ImGui@@YAXI@Z");
void SetWindowPos(
    const struct ImVec2* pos,
    ImGuiCond cond
) asm("?SetWindowPos@ImGui@@YAXAEBUImVec2@@H@Z");
void SetWindowPos__1(
    const char* name,
    const struct ImVec2* pos,
    ImGuiCond cond
) asm("?SetWindowPos@ImGui@@YAXPEBDAEBUImVec2@@H@Z");
void SetWindowSize(
    const struct ImVec2* size,
    ImGuiCond cond
) asm("?SetWindowSize@ImGui@@YAXAEBUImVec2@@H@Z");
void SetWindowSize__1(
    const char* name,
    const struct ImVec2* size,
    ImGuiCond cond
) asm("?SetWindowSize@ImGui@@YAXPEBDAEBUImVec2@@H@Z");
void SetWindowCollapsed(
    bool collapsed,
    ImGuiCond cond
) asm("?SetWindowCollapsed@ImGui@@YAX_NH@Z");
void SetWindowCollapsed__1(
    const char* name,
    bool collapsed,
    ImGuiCond cond
) asm("?SetWindowCollapsed@ImGui@@YAXPEBD_NH@Z");
void SetWindowFocus(
) asm("?SetWindowFocus@ImGui@@YAXXZ");
void SetWindowFocus__1(
    const char* name
) asm("?SetWindowFocus@ImGui@@YAXPEBD@Z");
void SetWindowFontScale(
    float scale
) asm("?SetWindowFontScale@ImGui@@YAXM@Z");
struct ImVec2 GetContentRegionAvail(
) asm("?GetContentRegionAvail@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetContentRegionMax(
) asm("?GetContentRegionMax@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetWindowContentRegionMin(
) asm("?GetWindowContentRegionMin@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetWindowContentRegionMax(
) asm("?GetWindowContentRegionMax@ImGui@@YA?AUImVec2@@XZ");
float GetWindowContentRegionWidth(
) asm("?GetWindowContentRegionWidth@ImGui@@YAMXZ");
float GetScrollX(
) asm("?GetScrollX@ImGui@@YAMXZ");
float GetScrollY(
) asm("?GetScrollY@ImGui@@YAMXZ");
void SetScrollX(
    float scroll_x
) asm("?SetScrollX@ImGui@@YAXM@Z");
void SetScrollY(
    float scroll_y
) asm("?SetScrollY@ImGui@@YAXM@Z");
float GetScrollMaxX(
) asm("?GetScrollMaxX@ImGui@@YAMXZ");
float GetScrollMaxY(
) asm("?GetScrollMaxY@ImGui@@YAMXZ");
void SetScrollHereX(
    float center_x_ratio
) asm("?SetScrollHereX@ImGui@@YAXM@Z");
void SetScrollHereY(
    float center_y_ratio
) asm("?SetScrollHereY@ImGui@@YAXM@Z");
void SetScrollFromPosX(
    float local_x,
    float center_x_ratio
) asm("?SetScrollFromPosX@ImGui@@YAXMM@Z");
void SetScrollFromPosY(
    float local_y,
    float center_y_ratio
) asm("?SetScrollFromPosY@ImGui@@YAXMM@Z");
void PushFont(
    struct ImFont* font
) asm("?PushFont@ImGui@@YAXPEAUImFont@@@Z");
void PopFont(
) asm("?PopFont@ImGui@@YAXXZ");
void PushStyleColor(
    ImGuiCol idx,
    ImU32 col
) asm("?PushStyleColor@ImGui@@YAXHI@Z");
void PushStyleColor__1(
    ImGuiCol idx,
    const struct ImVec4* col
) asm("?PushStyleColor@ImGui@@YAXHAEBUImVec4@@@Z");
void PopStyleColor(
    int count
) asm("?PopStyleColor@ImGui@@YAXH@Z");
void PushStyleVar(
    ImGuiStyleVar idx,
    float val
) asm("?PushStyleVar@ImGui@@YAXHM@Z");
void PushStyleVar__1(
    ImGuiStyleVar idx,
    const struct ImVec2* val
) asm("?PushStyleVar@ImGui@@YAXHAEBUImVec2@@@Z");
void PopStyleVar(
    int count
) asm("?PopStyleVar@ImGui@@YAXH@Z");
void PushAllowKeyboardFocus(
    bool allow_keyboard_focus
) asm("?PushAllowKeyboardFocus@ImGui@@YAX_N@Z");
void PopAllowKeyboardFocus(
) asm("?PopAllowKeyboardFocus@ImGui@@YAXXZ");
void PushButtonRepeat(
    bool repeat
) asm("?PushButtonRepeat@ImGui@@YAX_N@Z");
void PopButtonRepeat(
) asm("?PopButtonRepeat@ImGui@@YAXXZ");
void PushItemWidth(
    float item_width
) asm("?PushItemWidth@ImGui@@YAXM@Z");
void PopItemWidth(
) asm("?PopItemWidth@ImGui@@YAXXZ");
void SetNextItemWidth(
    float item_width
) asm("?SetNextItemWidth@ImGui@@YAXM@Z");
float CalcItemWidth(
) asm("?CalcItemWidth@ImGui@@YAMXZ");
void PushTextWrapPos(
    float wrap_local_pos_x
) asm("?PushTextWrapPos@ImGui@@YAXM@Z");
void PopTextWrapPos(
) asm("?PopTextWrapPos@ImGui@@YAXXZ");
struct ImFont* GetFont(
) asm("?GetFont@ImGui@@YAPEAUImFont@@XZ");
float GetFontSize(
) asm("?GetFontSize@ImGui@@YAMXZ");
struct ImVec2 GetFontTexUvWhitePixel(
) asm("?GetFontTexUvWhitePixel@ImGui@@YA?AUImVec2@@XZ");
ImU32 GetColorU32(
    ImGuiCol idx,
    float alpha_mul
) asm("?GetColorU32@ImGui@@YAIHM@Z");
ImU32 GetColorU32__1(
    const struct ImVec4* col
) asm("?GetColorU32@ImGui@@YAIAEBUImVec4@@@Z");
ImU32 GetColorU32__2(
    ImU32 col
) asm("?GetColorU32@ImGui@@YAII@Z");
const struct ImVec4* GetStyleColorVec4(
    ImGuiCol idx
) asm("?GetStyleColorVec4@ImGui@@YAAEBUImVec4@@H@Z");
void Separator(
) asm("?Separator@ImGui@@YAXXZ");
void SameLine(
    float offset_from_start_x,
    float spacing
) asm("?SameLine@ImGui@@YAXMM@Z");
void NewLine(
) asm("?NewLine@ImGui@@YAXXZ");
void Spacing(
) asm("?Spacing@ImGui@@YAXXZ");
void Dummy(
    const struct ImVec2* size
) asm("?Dummy@ImGui@@YAXAEBUImVec2@@@Z");
void Indent(
    float indent_w
) asm("?Indent@ImGui@@YAXM@Z");
void Unindent(
    float indent_w
) asm("?Unindent@ImGui@@YAXM@Z");
void BeginGroup(
) asm("?BeginGroup@ImGui@@YAXXZ");
void EndGroup(
) asm("?EndGroup@ImGui@@YAXXZ");
struct ImVec2 GetCursorPos(
) asm("?GetCursorPos@ImGui@@YA?AUImVec2@@XZ");
float GetCursorPosX(
) asm("?GetCursorPosX@ImGui@@YAMXZ");
float GetCursorPosY(
) asm("?GetCursorPosY@ImGui@@YAMXZ");
void SetCursorPos(
    const struct ImVec2* local_pos
) asm("?SetCursorPos@ImGui@@YAXAEBUImVec2@@@Z");
void SetCursorPosX(
    float local_x
) asm("?SetCursorPosX@ImGui@@YAXM@Z");
void SetCursorPosY(
    float local_y
) asm("?SetCursorPosY@ImGui@@YAXM@Z");
struct ImVec2 GetCursorStartPos(
) asm("?GetCursorStartPos@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetCursorScreenPos(
) asm("?GetCursorScreenPos@ImGui@@YA?AUImVec2@@XZ");
void SetCursorScreenPos(
    const struct ImVec2* pos
) asm("?SetCursorScreenPos@ImGui@@YAXAEBUImVec2@@@Z");
void AlignTextToFramePadding(
) asm("?AlignTextToFramePadding@ImGui@@YAXXZ");
float GetTextLineHeight(
) asm("?GetTextLineHeight@ImGui@@YAMXZ");
float GetTextLineHeightWithSpacing(
) asm("?GetTextLineHeightWithSpacing@ImGui@@YAMXZ");
float GetFrameHeight(
) asm("?GetFrameHeight@ImGui@@YAMXZ");
float GetFrameHeightWithSpacing(
) asm("?GetFrameHeightWithSpacing@ImGui@@YAMXZ");
void PushID(
    const char* str_id
) asm("?PushID@ImGui@@YAXPEBD@Z");
void PushID__1(
    const char* str_id_begin,
    const char* str_id_end
) asm("?PushID@ImGui@@YAXPEBD0@Z");
void PushID__2(
    const void* ptr_id
) asm("?PushID@ImGui@@YAXPEBX@Z");
void PushID__3(
    int int_id
) asm("?PushID@ImGui@@YAXH@Z");
void PopID(
) asm("?PopID@ImGui@@YAXXZ");
ImGuiID GetID(
    const char* str_id
) asm("?GetID@ImGui@@YAIPEBD@Z");
ImGuiID GetID__1(
    const char* str_id_begin,
    const char* str_id_end
) asm("?GetID@ImGui@@YAIPEBD0@Z");
ImGuiID GetID__2(
    const void* ptr_id
) asm("?GetID@ImGui@@YAIPEBX@Z");
void TextUnformatted(
    const char* text,
    const char* text_end
) asm("?TextUnformatted@ImGui@@YAXPEBD0@Z");
void Text(
    const char* fmt
, ...
) asm("?Text@ImGui@@YAXPEBDZZ");
void TextV(
    const char* fmt,
    va_list args
) asm("?TextV@ImGui@@YAXPEBDPEAD@Z");
void TextColored(
    const struct ImVec4* col,
    const char* fmt
, ...
) asm("?TextColored@ImGui@@YAXAEBUImVec4@@PEBDZZ");
void TextColoredV(
    const struct ImVec4* col,
    const char* fmt,
    va_list args
) asm("?TextColoredV@ImGui@@YAXAEBUImVec4@@PEBDPEAD@Z");
void TextDisabled(
    const char* fmt
, ...
) asm("?TextDisabled@ImGui@@YAXPEBDZZ");
void TextDisabledV(
    const char* fmt,
    va_list args
) asm("?TextDisabledV@ImGui@@YAXPEBDPEAD@Z");
void TextWrapped(
    const char* fmt
, ...
) asm("?TextWrapped@ImGui@@YAXPEBDZZ");
void TextWrappedV(
    const char* fmt,
    va_list args
) asm("?TextWrappedV@ImGui@@YAXPEBDPEAD@Z");
void LabelText(
    const char* label,
    const char* fmt
, ...
) asm("?LabelText@ImGui@@YAXPEBD0ZZ");
void LabelTextV(
    const char* label,
    const char* fmt,
    va_list args
) asm("?LabelTextV@ImGui@@YAXPEBD0PEAD@Z");
void BulletText(
    const char* fmt
, ...
) asm("?BulletText@ImGui@@YAXPEBDZZ");
void BulletTextV(
    const char* fmt,
    va_list args
) asm("?BulletTextV@ImGui@@YAXPEBDPEAD@Z");
bool Button(
    const char* label,
    const struct ImVec2* size
) asm("?Button@ImGui@@YA_NPEBDAEBUImVec2@@@Z");
bool SmallButton(
    const char* label
) asm("?SmallButton@ImGui@@YA_NPEBD@Z");
bool InvisibleButton(
    const char* str_id,
    const struct ImVec2* size,
    ImGuiButtonFlags flags
) asm("?InvisibleButton@ImGui@@YA_NPEBDAEBUImVec2@@H@Z");
bool ArrowButton(
    const char* str_id,
    ImGuiDir dir
) asm("?ArrowButton@ImGui@@YA_NPEBDH@Z");
void Image(
    ImTextureID user_texture_id,
    const struct ImVec2* size,
    const struct ImVec2* uv0,
    const struct ImVec2* uv1,
    const struct ImVec4* tint_col,
    const struct ImVec4* border_col
) asm("?Image@ImGui@@YAXPEAXAEBUImVec2@@11AEBUImVec4@@2@Z");
bool ImageButton(
    ImTextureID user_texture_id,
    const struct ImVec2* size,
    const struct ImVec2* uv0,
    const struct ImVec2* uv1,
    int frame_padding,
    const struct ImVec4* bg_col,
    const struct ImVec4* tint_col
) asm("?ImageButton@ImGui@@YA_NPEAXAEBUImVec2@@11HAEBUImVec4@@2@Z");
bool Checkbox(
    const char* label,
    bool* v
) asm("?Checkbox@ImGui@@YA_NPEBDPEA_N@Z");
bool CheckboxFlags(
    const char* label,
    int* flags,
    int flags_value
) asm("?CheckboxFlags@ImGui@@YA_NPEBDPEAHH@Z");
bool CheckboxFlags__1(
    const char* label,
    unsigned int* flags,
    unsigned int flags_value
) asm("?CheckboxFlags@ImGui@@YA_NPEBDPEAII@Z");
bool RadioButton(
    const char* label,
    bool active
) asm("?RadioButton@ImGui@@YA_NPEBD_N@Z");
bool RadioButton__1(
    const char* label,
    int* v,
    int v_button
) asm("?RadioButton@ImGui@@YA_NPEBDPEAHH@Z");
void ProgressBar(
    float fraction,
    const struct ImVec2* size_arg,
    const char* overlay
) asm("?ProgressBar@ImGui@@YAXMAEBUImVec2@@PEBD@Z");
void Bullet(
) asm("?Bullet@ImGui@@YAXXZ");
bool BeginCombo(
    const char* label,
    const char* preview_value,
    ImGuiComboFlags flags
) asm("?BeginCombo@ImGui@@YA_NPEBD0H@Z");
void EndCombo(
) asm("?EndCombo@ImGui@@YAXXZ");
bool Combo(
    const char* label,
    int* current_item,
    const char* const* items,
    int items_count,
    int popup_max_height_in_items
) asm("?Combo@ImGui@@YA_NPEBDPEAHQEBQEBDHH@Z");
bool Combo__1(
    const char* label,
    int* current_item,
    const char* items_separated_by_zeros,
    int popup_max_height_in_items
) asm("?Combo@ImGui@@YA_NPEBDPEAH0H@Z");
bool Combo__2(
    const char* label,
    int* current_item,
    bool(*items_getter)(void* data, int idx, const char** out_text),
    void* data,
    int items_count,
    int popup_max_height_in_items
) asm("?Combo@ImGui@@YA_NPEBDPEAHP6A_NPEAXHPEAPEBD@Z2HH@Z");
bool DragFloat(
    const char* label,
    float* v,
    float v_speed,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragFloat@ImGui@@YA_NPEBDPEAMMMM0H@Z");
bool DragFloat2(
    const char* label,
    float v[2],
    float v_speed,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragFloat2@ImGui@@YA_NPEBDQEAMMMM0H@Z");
bool DragFloat3(
    const char* label,
    float v[3],
    float v_speed,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragFloat3@ImGui@@YA_NPEBDQEAMMMM0H@Z");
bool DragFloat4(
    const char* label,
    float v[4],
    float v_speed,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragFloat4@ImGui@@YA_NPEBDQEAMMMM0H@Z");
bool DragFloatRange2(
    const char* label,
    float* v_current_min,
    float* v_current_max,
    float v_speed,
    float v_min,
    float v_max,
    const char* format,
    const char* format_max,
    ImGuiSliderFlags flags
) asm("?DragFloatRange2@ImGui@@YA_NPEBDPEAM1MMM00H@Z");
bool DragInt(
    const char* label,
    int* v,
    float v_speed,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragInt@ImGui@@YA_NPEBDPEAHMHH0H@Z");
bool DragInt2(
    const char* label,
    int v[2],
    float v_speed,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragInt2@ImGui@@YA_NPEBDQEAHMHH0H@Z");
bool DragInt3(
    const char* label,
    int v[3],
    float v_speed,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragInt3@ImGui@@YA_NPEBDQEAHMHH0H@Z");
bool DragInt4(
    const char* label,
    int v[4],
    float v_speed,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragInt4@ImGui@@YA_NPEBDQEAHMHH0H@Z");
bool DragIntRange2(
    const char* label,
    int* v_current_min,
    int* v_current_max,
    float v_speed,
    int v_min,
    int v_max,
    const char* format,
    const char* format_max,
    ImGuiSliderFlags flags
) asm("?DragIntRange2@ImGui@@YA_NPEBDPEAH1MHH00H@Z");
bool DragScalar(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    float v_speed,
    const void* p_min,
    const void* p_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragScalar@ImGui@@YA_NPEBDHPEAXMPEBX20H@Z");
bool DragScalar__1(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    float v_speed,
    const void* p_min,
    const void* p_max,
    const char* format,
    float power
) asm("?DragScalar@ImGui@@YA_NPEBDHPEAXMPEBX20M@Z");
bool DragScalarN(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    int components,
    float v_speed,
    const void* p_min,
    const void* p_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?DragScalarN@ImGui@@YA_NPEBDHPEAXHMPEBX20H@Z");
bool DragScalarN__1(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    int components,
    float v_speed,
    const void* p_min,
    const void* p_max,
    const char* format,
    float power
) asm("?DragScalarN@ImGui@@YA_NPEBDHPEAXHMPEBX20M@Z");
bool SliderFloat(
    const char* label,
    float* v,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderFloat@ImGui@@YA_NPEBDPEAMMM0H@Z");
bool SliderFloat2(
    const char* label,
    float v[2],
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderFloat2@ImGui@@YA_NPEBDQEAMMM0H@Z");
bool SliderFloat3(
    const char* label,
    float v[3],
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderFloat3@ImGui@@YA_NPEBDQEAMMM0H@Z");
bool SliderFloat4(
    const char* label,
    float v[4],
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderFloat4@ImGui@@YA_NPEBDQEAMMM0H@Z");
bool SliderAngle(
    const char* label,
    float* v_rad,
    float v_degrees_min,
    float v_degrees_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderAngle@ImGui@@YA_NPEBDPEAMMM0H@Z");
bool SliderInt(
    const char* label,
    int* v,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderInt@ImGui@@YA_NPEBDPEAHHH0H@Z");
bool SliderInt2(
    const char* label,
    int v[2],
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderInt2@ImGui@@YA_NPEBDQEAHHH0H@Z");
bool SliderInt3(
    const char* label,
    int v[3],
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderInt3@ImGui@@YA_NPEBDQEAHHH0H@Z");
bool SliderInt4(
    const char* label,
    int v[4],
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderInt4@ImGui@@YA_NPEBDQEAHHH0H@Z");
bool SliderScalar(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    const void* p_min,
    const void* p_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderScalar@ImGui@@YA_NPEBDHPEAXPEBX20H@Z");
bool SliderScalar__1(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    const void* p_min,
    const void* p_max,
    const char* format,
    float power
) asm("?SliderScalar@ImGui@@YA_NPEBDHPEAXPEBX20M@Z");
bool SliderScalarN(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    int components,
    const void* p_min,
    const void* p_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?SliderScalarN@ImGui@@YA_NPEBDHPEAXHPEBX20H@Z");
bool SliderScalarN__1(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    int components,
    const void* p_min,
    const void* p_max,
    const char* format,
    float power
) asm("?SliderScalarN@ImGui@@YA_NPEBDHPEAXHPEBX20M@Z");
bool VSliderFloat(
    const char* label,
    const struct ImVec2* size,
    float* v,
    float v_min,
    float v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?VSliderFloat@ImGui@@YA_NPEBDAEBUImVec2@@PEAMMM0H@Z");
bool VSliderInt(
    const char* label,
    const struct ImVec2* size,
    int* v,
    int v_min,
    int v_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?VSliderInt@ImGui@@YA_NPEBDAEBUImVec2@@PEAHHH0H@Z");
bool VSliderScalar(
    const char* label,
    const struct ImVec2* size,
    ImGuiDataType data_type,
    void* p_data,
    const void* p_min,
    const void* p_max,
    const char* format,
    ImGuiSliderFlags flags
) asm("?VSliderScalar@ImGui@@YA_NPEBDAEBUImVec2@@HPEAXPEBX30H@Z");
bool InputText(
    const char* label,
    char* buf,
    size_t buf_size,
    ImGuiInputTextFlags flags,
    ImGuiInputTextCallback callback,
    void* user_data
) asm("?InputText@ImGui@@YA_NPEBDPEAD_KHP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z");
bool InputTextMultiline(
    const char* label,
    char* buf,
    size_t buf_size,
    const struct ImVec2* size,
    ImGuiInputTextFlags flags,
    ImGuiInputTextCallback callback,
    void* user_data
) asm("?InputTextMultiline@ImGui@@YA_NPEBDPEAD_KAEBUImVec2@@HP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z");
bool InputTextWithHint(
    const char* label,
    const char* hint,
    char* buf,
    size_t buf_size,
    ImGuiInputTextFlags flags,
    ImGuiInputTextCallback callback,
    void* user_data
) asm("?InputTextWithHint@ImGui@@YA_NPEBD0PEAD_KHP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z");
bool InputFloat(
    const char* label,
    float* v,
    float step,
    float step_fast,
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputFloat@ImGui@@YA_NPEBDPEAMMM0H@Z");
bool InputFloat2(
    const char* label,
    float v[2],
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputFloat2@ImGui@@YA_NPEBDQEAM0H@Z");
bool InputFloat3(
    const char* label,
    float v[3],
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputFloat3@ImGui@@YA_NPEBDQEAM0H@Z");
bool InputFloat4(
    const char* label,
    float v[4],
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputFloat4@ImGui@@YA_NPEBDQEAM0H@Z");
bool InputInt(
    const char* label,
    int* v,
    int step,
    int step_fast,
    ImGuiInputTextFlags flags
) asm("?InputInt@ImGui@@YA_NPEBDPEAHHHH@Z");
bool InputInt2(
    const char* label,
    int v[2],
    ImGuiInputTextFlags flags
) asm("?InputInt2@ImGui@@YA_NPEBDQEAHH@Z");
bool InputInt3(
    const char* label,
    int v[3],
    ImGuiInputTextFlags flags
) asm("?InputInt3@ImGui@@YA_NPEBDQEAHH@Z");
bool InputInt4(
    const char* label,
    int v[4],
    ImGuiInputTextFlags flags
) asm("?InputInt4@ImGui@@YA_NPEBDQEAHH@Z");
bool InputDouble(
    const char* label,
    double* v,
    double step,
    double step_fast,
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputDouble@ImGui@@YA_NPEBDPEANNN0H@Z");
bool InputScalar(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    const void* p_step,
    const void* p_step_fast,
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputScalar@ImGui@@YA_NPEBDHPEAXPEBX20H@Z");
bool InputScalarN(
    const char* label,
    ImGuiDataType data_type,
    void* p_data,
    int components,
    const void* p_step,
    const void* p_step_fast,
    const char* format,
    ImGuiInputTextFlags flags
) asm("?InputScalarN@ImGui@@YA_NPEBDHPEAXHPEBX20H@Z");
bool ColorEdit3(
    const char* label,
    float col[3],
    ImGuiColorEditFlags flags
) asm("?ColorEdit3@ImGui@@YA_NPEBDQEAMH@Z");
bool ColorEdit4(
    const char* label,
    float col[4],
    ImGuiColorEditFlags flags
) asm("?ColorEdit4@ImGui@@YA_NPEBDQEAMH@Z");
bool ColorPicker3(
    const char* label,
    float col[3],
    ImGuiColorEditFlags flags
) asm("?ColorPicker3@ImGui@@YA_NPEBDQEAMH@Z");
bool ColorPicker4(
    const char* label,
    float col[4],
    ImGuiColorEditFlags flags,
    const float* ref_col
) asm("?ColorPicker4@ImGui@@YA_NPEBDQEAMHPEBM@Z");
bool ColorButton(
    const char* desc_id,
    const struct ImVec4* col,
    ImGuiColorEditFlags flags,
    struct ImVec2 size
) asm("?ColorButton@ImGui@@YA_NPEBDAEBUImVec4@@HUImVec2@@@Z");
void SetColorEditOptions(
    ImGuiColorEditFlags flags
) asm("?SetColorEditOptions@ImGui@@YAXH@Z");
bool TreeNode(
    const char* label
) asm("?TreeNode@ImGui@@YA_NPEBD@Z");
bool TreeNode__1(
    const char* str_id,
    const char* fmt
, ...
) asm("?TreeNode@ImGui@@YA_NPEBD0ZZ");
bool TreeNode__2(
    const void* ptr_id,
    const char* fmt
, ...
) asm("?TreeNode@ImGui@@YA_NPEBXPEBDZZ");
bool TreeNodeV(
    const char* str_id,
    const char* fmt,
    va_list args
) asm("?TreeNodeV@ImGui@@YA_NPEBD0PEAD@Z");
bool TreeNodeV__1(
    const void* ptr_id,
    const char* fmt,
    va_list args
) asm("?TreeNodeV@ImGui@@YA_NPEBXPEBDPEAD@Z");
bool TreeNodeEx(
    const char* label,
    ImGuiTreeNodeFlags flags
) asm("?TreeNodeEx@ImGui@@YA_NPEBDH@Z");
bool TreeNodeEx__1(
    const char* str_id,
    ImGuiTreeNodeFlags flags,
    const char* fmt
, ...
) asm("?TreeNodeEx@ImGui@@YA_NPEBDH0ZZ");
bool TreeNodeEx__2(
    const void* ptr_id,
    ImGuiTreeNodeFlags flags,
    const char* fmt
, ...
) asm("?TreeNodeEx@ImGui@@YA_NPEBXHPEBDZZ");
bool TreeNodeExV(
    const char* str_id,
    ImGuiTreeNodeFlags flags,
    const char* fmt,
    va_list args
) asm("?TreeNodeExV@ImGui@@YA_NPEBDH0PEAD@Z");
bool TreeNodeExV__1(
    const void* ptr_id,
    ImGuiTreeNodeFlags flags,
    const char* fmt,
    va_list args
) asm("?TreeNodeExV@ImGui@@YA_NPEBXHPEBDPEAD@Z");
void TreePush(
    const char* str_id
) asm("?TreePush@ImGui@@YAXPEBD@Z");
void TreePush__1(
    const void* ptr_id
) asm("?TreePush@ImGui@@YAXPEBX@Z");
void TreePop(
) asm("?TreePop@ImGui@@YAXXZ");
float GetTreeNodeToLabelSpacing(
) asm("?GetTreeNodeToLabelSpacing@ImGui@@YAMXZ");
bool CollapsingHeader(
    const char* label,
    ImGuiTreeNodeFlags flags
) asm("?CollapsingHeader@ImGui@@YA_NPEBDH@Z");
bool CollapsingHeader__1(
    const char* label,
    bool* p_visible,
    ImGuiTreeNodeFlags flags
) asm("?CollapsingHeader@ImGui@@YA_NPEBDPEA_NH@Z");
void SetNextItemOpen(
    bool is_open,
    ImGuiCond cond
) asm("?SetNextItemOpen@ImGui@@YAX_NH@Z");
bool Selectable(
    const char* label,
    bool selected,
    ImGuiSelectableFlags flags,
    const struct ImVec2* size
) asm("?Selectable@ImGui@@YA_NPEBD_NHAEBUImVec2@@@Z");
bool Selectable__1(
    const char* label,
    bool* p_selected,
    ImGuiSelectableFlags flags,
    const struct ImVec2* size
) asm("?Selectable@ImGui@@YA_NPEBDPEA_NHAEBUImVec2@@@Z");
bool BeginListBox(
    const char* label,
    const struct ImVec2* size
) asm("?BeginListBox@ImGui@@YA_NPEBDAEBUImVec2@@@Z");
void EndListBox(
) asm("?EndListBox@ImGui@@YAXXZ");
bool ListBox(
    const char* label,
    int* current_item,
    const char* const* items,
    int items_count,
    int height_in_items
) asm("?ListBox@ImGui@@YA_NPEBDPEAHQEBQEBDHH@Z");
bool ListBox__1(
    const char* label,
    int* current_item,
    bool(*items_getter)(void* data, int idx, const char** out_text),
    void* data,
    int items_count,
    int height_in_items
) asm("?ListBox@ImGui@@YA_NPEBDPEAHP6A_NPEAXHPEAPEBD@Z2HH@Z");
void PlotLines(
    const char* label,
    const float* values,
    int values_count,
    int values_offset,
    const char* overlay_text,
    float scale_min,
    float scale_max,
    struct ImVec2 graph_size,
    int stride
) asm("?PlotLines@ImGui@@YAXPEBDPEBMHH0MMUImVec2@@H@Z");
void PlotLines__1(
    const char* label,
    float(*values_getter)(void* data, int idx),
    void* data,
    int values_count,
    int values_offset,
    const char* overlay_text,
    float scale_min,
    float scale_max,
    struct ImVec2 graph_size
) asm("?PlotLines@ImGui@@YAXPEBDP6AMPEAXH@Z1HH0MMUImVec2@@@Z");
void PlotHistogram(
    const char* label,
    const float* values,
    int values_count,
    int values_offset,
    const char* overlay_text,
    float scale_min,
    float scale_max,
    struct ImVec2 graph_size,
    int stride
) asm("?PlotHistogram@ImGui@@YAXPEBDPEBMHH0MMUImVec2@@H@Z");
void PlotHistogram__1(
    const char* label,
    float(*values_getter)(void* data, int idx),
    void* data,
    int values_count,
    int values_offset,
    const char* overlay_text,
    float scale_min,
    float scale_max,
    struct ImVec2 graph_size
) asm("?PlotHistogram@ImGui@@YAXPEBDP6AMPEAXH@Z1HH0MMUImVec2@@@Z");
void Value(
    const char* prefix,
    bool b
) asm("?Value@ImGui@@YAXPEBD_N@Z");
void Value__1(
    const char* prefix,
    int v
) asm("?Value@ImGui@@YAXPEBDH@Z");
void Value__2(
    const char* prefix,
    unsigned int v
) asm("?Value@ImGui@@YAXPEBDI@Z");
void Value__3(
    const char* prefix,
    float v,
    const char* float_format
) asm("?Value@ImGui@@YAXPEBDM0@Z");
bool BeginMenuBar(
) asm("?BeginMenuBar@ImGui@@YA_NXZ");
void EndMenuBar(
) asm("?EndMenuBar@ImGui@@YAXXZ");
bool BeginMainMenuBar(
) asm("?BeginMainMenuBar@ImGui@@YA_NXZ");
void EndMainMenuBar(
) asm("?EndMainMenuBar@ImGui@@YAXXZ");
bool BeginMenu(
    const char* label,
    bool enabled
) asm("?BeginMenu@ImGui@@YA_NPEBD_N@Z");
void EndMenu(
) asm("?EndMenu@ImGui@@YAXXZ");
bool MenuItem(
    const char* label,
    const char* shortcut,
    bool selected,
    bool enabled
) asm("?MenuItem@ImGui@@YA_NPEBD0_N1@Z");
bool MenuItem__1(
    const char* label,
    const char* shortcut,
    bool* p_selected,
    bool enabled
) asm("?MenuItem@ImGui@@YA_NPEBD0PEA_N_N@Z");
void BeginTooltip(
) asm("?BeginTooltip@ImGui@@YAXXZ");
void EndTooltip(
) asm("?EndTooltip@ImGui@@YAXXZ");
void SetTooltip(
    const char* fmt
, ...
) asm("?SetTooltip@ImGui@@YAXPEBDZZ");
void SetTooltipV(
    const char* fmt,
    va_list args
) asm("?SetTooltipV@ImGui@@YAXPEBDPEAD@Z");
bool BeginPopup(
    const char* str_id,
    ImGuiWindowFlags flags
) asm("?BeginPopup@ImGui@@YA_NPEBDH@Z");
bool BeginPopupModal(
    const char* name,
    bool* p_open,
    ImGuiWindowFlags flags
) asm("?BeginPopupModal@ImGui@@YA_NPEBDPEA_NH@Z");
void EndPopup(
) asm("?EndPopup@ImGui@@YAXXZ");
void OpenPopup(
    const char* str_id,
    ImGuiPopupFlags popup_flags
) asm("?OpenPopup@ImGui@@YAXPEBDH@Z");
void OpenPopup__1(
    ImGuiID id,
    ImGuiPopupFlags popup_flags
) asm("?OpenPopup@ImGui@@YAXIH@Z");
void OpenPopupOnItemClick(
    const char* str_id,
    ImGuiPopupFlags popup_flags
) asm("?OpenPopupOnItemClick@ImGui@@YAXPEBDH@Z");
void CloseCurrentPopup(
) asm("?CloseCurrentPopup@ImGui@@YAXXZ");
bool BeginPopupContextItem(
    const char* str_id,
    ImGuiPopupFlags popup_flags
) asm("?BeginPopupContextItem@ImGui@@YA_NPEBDH@Z");
bool BeginPopupContextWindow(
    const char* str_id,
    ImGuiPopupFlags popup_flags
) asm("?BeginPopupContextWindow@ImGui@@YA_NPEBDH@Z");
bool BeginPopupContextVoid(
    const char* str_id,
    ImGuiPopupFlags popup_flags
) asm("?BeginPopupContextVoid@ImGui@@YA_NPEBDH@Z");
bool IsPopupOpen(
    const char* str_id,
    ImGuiPopupFlags flags
) asm("?IsPopupOpen@ImGui@@YA_NPEBDH@Z");
bool BeginTable(
    const char* str_id,
    int column,
    ImGuiTableFlags flags,
    const struct ImVec2* outer_size,
    float inner_width
) asm("?BeginTable@ImGui@@YA_NPEBDHHAEBUImVec2@@M@Z");
void EndTable(
) asm("?EndTable@ImGui@@YAXXZ");
void TableNextRow(
    ImGuiTableRowFlags row_flags,
    float min_row_height
) asm("?TableNextRow@ImGui@@YAXHM@Z");
bool TableNextColumn(
) asm("?TableNextColumn@ImGui@@YA_NXZ");
bool TableSetColumnIndex(
    int column_n
) asm("?TableSetColumnIndex@ImGui@@YA_NH@Z");
void TableSetupColumn(
    const char* label,
    ImGuiTableColumnFlags flags,
    float init_width_or_weight,
    ImGuiID user_id
) asm("?TableSetupColumn@ImGui@@YAXPEBDHMI@Z");
void TableSetupScrollFreeze(
    int cols,
    int rows
) asm("?TableSetupScrollFreeze@ImGui@@YAXHH@Z");
void TableHeadersRow(
) asm("?TableHeadersRow@ImGui@@YAXXZ");
void TableHeader(
    const char* label
) asm("?TableHeader@ImGui@@YAXPEBD@Z");
struct ImGuiTableSortSpecs* TableGetSortSpecs(
) asm("?TableGetSortSpecs@ImGui@@YAPEAUImGuiTableSortSpecs@@XZ");
int TableGetColumnCount(
) asm("?TableGetColumnCount@ImGui@@YAHXZ");
int TableGetColumnIndex(
) asm("?TableGetColumnIndex@ImGui@@YAHXZ");
int TableGetRowIndex(
) asm("?TableGetRowIndex@ImGui@@YAHXZ");
const char* TableGetColumnName(
    int column_n
) asm("?TableGetColumnName@ImGui@@YAPEBDH@Z");
ImGuiTableColumnFlags TableGetColumnFlags(
    int column_n
) asm("?TableGetColumnFlags@ImGui@@YAHH@Z");
void TableSetColumnEnabled(
    int column_n,
    bool v
) asm("?TableSetColumnEnabled@ImGui@@YAXH_N@Z");
void TableSetBgColor(
    ImGuiTableBgTarget target,
    ImU32 color,
    int column_n
) asm("?TableSetBgColor@ImGui@@YAXHIH@Z");
void Columns(
    int count,
    const char* id,
    bool border
) asm("?Columns@ImGui@@YAXHPEBD_N@Z");
void NextColumn(
) asm("?NextColumn@ImGui@@YAXXZ");
int GetColumnIndex(
) asm("?GetColumnIndex@ImGui@@YAHXZ");
float GetColumnWidth(
    int column_index
) asm("?GetColumnWidth@ImGui@@YAMH@Z");
void SetColumnWidth(
    int column_index,
    float width
) asm("?SetColumnWidth@ImGui@@YAXHM@Z");
float GetColumnOffset(
    int column_index
) asm("?GetColumnOffset@ImGui@@YAMH@Z");
void SetColumnOffset(
    int column_index,
    float offset_x
) asm("?SetColumnOffset@ImGui@@YAXHM@Z");
int GetColumnsCount(
) asm("?GetColumnsCount@ImGui@@YAHXZ");
bool BeginTabBar(
    const char* str_id,
    ImGuiTabBarFlags flags
) asm("?BeginTabBar@ImGui@@YA_NPEBDH@Z");
void EndTabBar(
) asm("?EndTabBar@ImGui@@YAXXZ");
bool BeginTabItem(
    const char* label,
    bool* p_open,
    ImGuiTabItemFlags flags
) asm("?BeginTabItem@ImGui@@YA_NPEBDPEA_NH@Z");
void EndTabItem(
) asm("?EndTabItem@ImGui@@YAXXZ");
bool TabItemButton(
    const char* label,
    ImGuiTabItemFlags flags
) asm("?TabItemButton@ImGui@@YA_NPEBDH@Z");
void SetTabItemClosed(
    const char* tab_or_docked_window_label
) asm("?SetTabItemClosed@ImGui@@YAXPEBD@Z");
ImGuiID DockSpace(
    ImGuiID id,
    const struct ImVec2* size,
    ImGuiDockNodeFlags flags,
    const struct ImGuiWindowClass* window_class
) asm("?DockSpace@ImGui@@YAIIAEBUImVec2@@HPEBUImGuiWindowClass@@@Z");
ImGuiID DockSpaceOverViewport(
    const struct ImGuiViewport* viewport,
    ImGuiDockNodeFlags flags,
    const struct ImGuiWindowClass* window_class
) asm("?DockSpaceOverViewport@ImGui@@YAIPEBUImGuiViewport@@HPEBUImGuiWindowClass@@@Z");
void SetNextWindowDockID(
    ImGuiID dock_id,
    ImGuiCond cond
) asm("?SetNextWindowDockID@ImGui@@YAXIH@Z");
void SetNextWindowClass(
    const struct ImGuiWindowClass* window_class
) asm("?SetNextWindowClass@ImGui@@YAXPEBUImGuiWindowClass@@@Z");
ImGuiID GetWindowDockID(
) asm("?GetWindowDockID@ImGui@@YAIXZ");
bool IsWindowDocked(
) asm("?IsWindowDocked@ImGui@@YA_NXZ");
void LogToTTY(
    int auto_open_depth
) asm("?LogToTTY@ImGui@@YAXH@Z");
void LogToFile(
    int auto_open_depth,
    const char* filename
) asm("?LogToFile@ImGui@@YAXHPEBD@Z");
void LogToClipboard(
    int auto_open_depth
) asm("?LogToClipboard@ImGui@@YAXH@Z");
void LogFinish(
) asm("?LogFinish@ImGui@@YAXXZ");
void LogButtons(
) asm("?LogButtons@ImGui@@YAXXZ");
void LogText(
    const char* fmt
, ...
) asm("?LogText@ImGui@@YAXPEBDZZ");
void LogTextV(
    const char* fmt,
    va_list args
) asm("?LogTextV@ImGui@@YAXPEBDPEAD@Z");
bool BeginDragDropSource(
    ImGuiDragDropFlags flags
) asm("?BeginDragDropSource@ImGui@@YA_NH@Z");
bool SetDragDropPayload(
    const char* type,
    const void* data,
    size_t sz,
    ImGuiCond cond
) asm("?SetDragDropPayload@ImGui@@YA_NPEBDPEBX_KH@Z");
void EndDragDropSource(
) asm("?EndDragDropSource@ImGui@@YAXXZ");
bool BeginDragDropTarget(
) asm("?BeginDragDropTarget@ImGui@@YA_NXZ");
const struct ImGuiPayload* AcceptDragDropPayload(
    const char* type,
    ImGuiDragDropFlags flags
) asm("?AcceptDragDropPayload@ImGui@@YAPEBUImGuiPayload@@PEBDH@Z");
void EndDragDropTarget(
) asm("?EndDragDropTarget@ImGui@@YAXXZ");
const struct ImGuiPayload* GetDragDropPayload(
) asm("?GetDragDropPayload@ImGui@@YAPEBUImGuiPayload@@XZ");
void PushClipRect(
    const struct ImVec2* clip_rect_min,
    const struct ImVec2* clip_rect_max,
    bool intersect_with_current_clip_rect
) asm("?PushClipRect@ImGui@@YAXAEBUImVec2@@0_N@Z");
void PopClipRect(
) asm("?PopClipRect@ImGui@@YAXXZ");
void SetItemDefaultFocus(
) asm("?SetItemDefaultFocus@ImGui@@YAXXZ");
void SetKeyboardFocusHere(
    int offset
) asm("?SetKeyboardFocusHere@ImGui@@YAXH@Z");
bool IsItemHovered(
    ImGuiHoveredFlags flags
) asm("?IsItemHovered@ImGui@@YA_NH@Z");
bool IsItemActive(
) asm("?IsItemActive@ImGui@@YA_NXZ");
bool IsItemFocused(
) asm("?IsItemFocused@ImGui@@YA_NXZ");
bool IsItemClicked(
    ImGuiMouseButton mouse_button
) asm("?IsItemClicked@ImGui@@YA_NH@Z");
bool IsItemVisible(
) asm("?IsItemVisible@ImGui@@YA_NXZ");
bool IsItemEdited(
) asm("?IsItemEdited@ImGui@@YA_NXZ");
bool IsItemActivated(
) asm("?IsItemActivated@ImGui@@YA_NXZ");
bool IsItemDeactivated(
) asm("?IsItemDeactivated@ImGui@@YA_NXZ");
bool IsItemDeactivatedAfterEdit(
) asm("?IsItemDeactivatedAfterEdit@ImGui@@YA_NXZ");
bool IsItemToggledOpen(
) asm("?IsItemToggledOpen@ImGui@@YA_NXZ");
bool IsAnyItemHovered(
) asm("?IsAnyItemHovered@ImGui@@YA_NXZ");
bool IsAnyItemActive(
) asm("?IsAnyItemActive@ImGui@@YA_NXZ");
bool IsAnyItemFocused(
) asm("?IsAnyItemFocused@ImGui@@YA_NXZ");
struct ImVec2 GetItemRectMin(
) asm("?GetItemRectMin@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetItemRectMax(
) asm("?GetItemRectMax@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetItemRectSize(
) asm("?GetItemRectSize@ImGui@@YA?AUImVec2@@XZ");
void SetItemAllowOverlap(
) asm("?SetItemAllowOverlap@ImGui@@YAXXZ");
struct ImGuiViewport* GetMainViewport(
) asm("?GetMainViewport@ImGui@@YAPEAUImGuiViewport@@XZ");
bool IsRectVisible(
    const struct ImVec2* size
) asm("?IsRectVisible@ImGui@@YA_NAEBUImVec2@@@Z");
bool IsRectVisible__1(
    const struct ImVec2* rect_min,
    const struct ImVec2* rect_max
) asm("?IsRectVisible@ImGui@@YA_NAEBUImVec2@@0@Z");
double GetTime(
) asm("?GetTime@ImGui@@YANXZ");
int GetFrameCount(
) asm("?GetFrameCount@ImGui@@YAHXZ");
struct ImDrawList* GetBackgroundDrawList(
) asm("?GetBackgroundDrawList@ImGui@@YAPEAUImDrawList@@XZ");
struct ImDrawList* GetBackgroundDrawList__1(
    struct ImGuiViewport* viewport
) asm("?GetBackgroundDrawList@ImGui@@YAPEAUImDrawList@@PEAUImGuiViewport@@@Z");
struct ImDrawList* GetForegroundDrawList(
) asm("?GetForegroundDrawList@ImGui@@YAPEAUImDrawList@@XZ");
struct ImDrawList* GetForegroundDrawList__1(
    struct ImGuiViewport* viewport
) asm("?GetForegroundDrawList@ImGui@@YAPEAUImDrawList@@PEAUImGuiViewport@@@Z");
struct ImDrawListSharedData* GetDrawListSharedData(
) asm("?GetDrawListSharedData@ImGui@@YAPEAUImDrawListSharedData@@XZ");
const char* GetStyleColorName(
    ImGuiCol idx
) asm("?GetStyleColorName@ImGui@@YAPEBDH@Z");
void SetStateStorage(
    struct ImGuiStorage* storage
) asm("?SetStateStorage@ImGui@@YAXPEAUImGuiStorage@@@Z");
struct ImGuiStorage* GetStateStorage(
) asm("?GetStateStorage@ImGui@@YAPEAUImGuiStorage@@XZ");
void CalcListClipping(
    int items_count,
    float items_height,
    int* out_items_display_start,
    int* out_items_display_end
) asm("?CalcListClipping@ImGui@@YAXHMPEAH0@Z");
bool BeginChildFrame(
    ImGuiID id,
    const struct ImVec2* size,
    ImGuiWindowFlags flags
) asm("?BeginChildFrame@ImGui@@YA_NIAEBUImVec2@@H@Z");
void EndChildFrame(
) asm("?EndChildFrame@ImGui@@YAXXZ");
struct ImVec2 CalcTextSize(
    const char* text,
    const char* text_end,
    bool hide_text_after_double_hash,
    float wrap_width
) asm("?CalcTextSize@ImGui@@YA?AUImVec2@@PEBD0_NM@Z");
struct ImVec4 ColorConvertU32ToFloat4(
    ImU32 in
) asm("?ColorConvertU32ToFloat4@ImGui@@YA?AUImVec4@@I@Z");
ImU32 ColorConvertFloat4ToU32(
    const struct ImVec4* in
) asm("?ColorConvertFloat4ToU32@ImGui@@YAIAEBUImVec4@@@Z");
void ColorConvertRGBtoHSV(
    float r,
    float g,
    float b,
    float* out_h,
    float* out_s,
    float* out_v
) asm("?ColorConvertRGBtoHSV@ImGui@@YAXMMMAEAM00@Z");
void ColorConvertHSVtoRGB(
    float h,
    float s,
    float v,
    float* out_r,
    float* out_g,
    float* out_b
) asm("?ColorConvertHSVtoRGB@ImGui@@YAXMMMAEAM00@Z");
int GetKeyIndex(
    ImGuiKey imgui_key
) asm("?GetKeyIndex@ImGui@@YAHH@Z");
bool IsKeyDown(
    int user_key_index
) asm("?IsKeyDown@ImGui@@YA_NH@Z");
bool IsKeyPressed(
    int user_key_index,
    bool repeat
) asm("?IsKeyPressed@ImGui@@YA_NH_N@Z");
bool IsKeyReleased(
    int user_key_index
) asm("?IsKeyReleased@ImGui@@YA_NH@Z");
int GetKeyPressedAmount(
    int key_index,
    float repeat_delay,
    float rate
) asm("?GetKeyPressedAmount@ImGui@@YAHHMM@Z");
void CaptureKeyboardFromApp(
    bool want_capture_keyboard_value
) asm("?CaptureKeyboardFromApp@ImGui@@YAX_N@Z");
bool IsMouseDown(
    ImGuiMouseButton button
) asm("?IsMouseDown@ImGui@@YA_NH@Z");
bool IsMouseClicked(
    ImGuiMouseButton button,
    bool repeat
) asm("?IsMouseClicked@ImGui@@YA_NH_N@Z");
bool IsMouseReleased(
    ImGuiMouseButton button
) asm("?IsMouseReleased@ImGui@@YA_NH@Z");
bool IsMouseDoubleClicked(
    ImGuiMouseButton button
) asm("?IsMouseDoubleClicked@ImGui@@YA_NH@Z");
bool IsMouseHoveringRect(
    const struct ImVec2* r_min,
    const struct ImVec2* r_max,
    bool clip
) asm("?IsMouseHoveringRect@ImGui@@YA_NAEBUImVec2@@0_N@Z");
bool IsMousePosValid(
    const struct ImVec2* mouse_pos
) asm("?IsMousePosValid@ImGui@@YA_NPEBUImVec2@@@Z");
bool IsAnyMouseDown(
) asm("?IsAnyMouseDown@ImGui@@YA_NXZ");
struct ImVec2 GetMousePos(
) asm("?GetMousePos@ImGui@@YA?AUImVec2@@XZ");
struct ImVec2 GetMousePosOnOpeningCurrentPopup(
) asm("?GetMousePosOnOpeningCurrentPopup@ImGui@@YA?AUImVec2@@XZ");
bool IsMouseDragging(
    ImGuiMouseButton button,
    float lock_threshold
) asm("?IsMouseDragging@ImGui@@YA_NHM@Z");
struct ImVec2 GetMouseDragDelta(
    ImGuiMouseButton button,
    float lock_threshold
) asm("?GetMouseDragDelta@ImGui@@YA?AUImVec2@@HM@Z");
void ResetMouseDragDelta(
    ImGuiMouseButton button
) asm("?ResetMouseDragDelta@ImGui@@YAXH@Z");
ImGuiMouseCursor GetMouseCursor(
) asm("?GetMouseCursor@ImGui@@YAHXZ");
void SetMouseCursor(
    ImGuiMouseCursor cursor_type
) asm("?SetMouseCursor@ImGui@@YAXH@Z");
void CaptureMouseFromApp(
    bool want_capture_mouse_value
) asm("?CaptureMouseFromApp@ImGui@@YAX_N@Z");
const char* GetClipboardText(
) asm("?GetClipboardText@ImGui@@YAPEBDXZ");
void SetClipboardText(
    const char* text
) asm("?SetClipboardText@ImGui@@YAXPEBD@Z");
void LoadIniSettingsFromDisk(
    const char* ini_filename
) asm("?LoadIniSettingsFromDisk@ImGui@@YAXPEBD@Z");
void LoadIniSettingsFromMemory(
    const char* ini_data,
    size_t ini_size
) asm("?LoadIniSettingsFromMemory@ImGui@@YAXPEBD_K@Z");
void SaveIniSettingsToDisk(
    const char* ini_filename
) asm("?SaveIniSettingsToDisk@ImGui@@YAXPEBD@Z");
const char* SaveIniSettingsToMemory(
    size_t* out_ini_size
) asm("?SaveIniSettingsToMemory@ImGui@@YAPEBDPEA_K@Z");
bool DebugCheckVersionAndDataLayout(
    const char* version_str,
    size_t sz_io,
    size_t sz_style,
    size_t sz_vec2,
    size_t sz_vec4,
    size_t sz_drawvert,
    size_t sz_drawidx
) asm("?DebugCheckVersionAndDataLayout@ImGui@@YA_NPEBD_K11111@Z");
void SetAllocatorFunctions(
    ImGuiMemAllocFunc alloc_func,
    ImGuiMemFreeFunc free_func,
    void* user_data
) asm("?SetAllocatorFunctions@ImGui@@YAXP6APEAX_KPEAX@ZP6AX11@Z1@Z");
void GetAllocatorFunctions(
    ImGuiMemAllocFunc* p_alloc_func,
    ImGuiMemFreeFunc* p_free_func,
    void** p_user_data
) asm("?GetAllocatorFunctions@ImGui@@YAXPEAP6APEAX_KPEAX@ZPEAP6AX11@ZPEAPEAX@Z");
void* MemAlloc(
    size_t size
) asm("?MemAlloc@ImGui@@YAPEAX_K@Z");
void MemFree(
    void* ptr
) asm("?MemFree@ImGui@@YAXPEAX@Z");
struct ImGuiPlatformIO* GetPlatformIO(
) asm("?GetPlatformIO@ImGui@@YAAEAUImGuiPlatformIO@@XZ");
void UpdatePlatformWindows(
) asm("?UpdatePlatformWindows@ImGui@@YAXXZ");
void RenderPlatformWindowsDefault(
    void* platform_render_arg,
    void* renderer_render_arg
) asm("?RenderPlatformWindowsDefault@ImGui@@YAXPEAX0@Z");
void DestroyPlatformWindows(
) asm("?DestroyPlatformWindows@ImGui@@YAXXZ");
struct ImGuiViewport* FindViewportByID(
    ImGuiID id
) asm("?FindViewportByID@ImGui@@YAPEAUImGuiViewport@@I@Z");
struct ImGuiViewport* FindViewportByPlatformHandle(
    void* platform_handle
) asm("?FindViewportByPlatformHandle@ImGui@@YAPEAUImGuiViewport@@PEAX@Z");
bool ListBoxHeader(
    const char* label,
    int items_count,
    int height_in_items
) asm("?ListBoxHeader@ImGui@@YA_NPEBDHH@Z");
]]
