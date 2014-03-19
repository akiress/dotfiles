import            XMonad                          hiding ((|||))
import            XMonad.Hooks.DynamicLog
import            XMonad.Hooks.FadeInactive       as FI
import            XMonad.Hooks.ManageDocks
import            XMonad.Hooks.ManageHelpers
import            XMonad.Hooks.UrgencyHook
import            XMonad.Layout.DecorationMadness
import            XMonad.Layout.IM
import            XMonad.Layout.LayoutCombinators (JumpToLayout (..), (|||))
import            XMonad.Layout.Named
import            XMonad.Layout.NoBorders
import            XMonad.Layout.PerWorkspace
import            XMonad.Layout.Reflect
import            XMonad.Layout.Tabbed
import            XMonad.Prompt
import            XMonad.Prompt.Input
import qualified  XMonad.StackSet                 as W
import            XMonad.Util.Run                 (spawnPipe)
import            XMonad.Util.Scratchpad

import qualified  Data.Map                        as M
import            Data.Ratio
import            System.Exit
import            System.IO

------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "/usr/bin/urxvt"

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces = [ "1.web", "2.code", "3", "4", "5", "6", "7.media", "8.irc"
               , "9.mail" ]

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
myNormalBorderColor  = "#7c7c7c"
myFocusedBorderColor = "#ffb6b0"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- Width of the window border in pixels.
myBorderWidth = 1

-- Default offset of drawable screen boundaries from each physical
-- screen. Anything non-zero here will leave a gap of that many pixels
-- on the given edge, on the that screen. A useful gap at top of screen
-- for a menu bar (e.g. 15)
--
-- An example, to set a top gap on monitor 1, and a gap on the bottom of
-- monitor 2, you'd use a list of geometries like so:
--
-- > defaultGaps = [(18,0,0,0),(0,18,0,0)] -- 2 gaps on 2 monitors
--
-- Fields are: top, bottom, left, right.
--
myDefaultGaps :: [(Integer, Integer, Integer, Integer)]
myDefaultGaps = [(0,0,0,0)]

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Lock the screen using xscreensaver.
  , ((modMask .|. controlMask, xK_l),
     spawn "xscreensaver-command -lock")

  -- Launch dmenu via yeganesh.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_p),
     spawn "dmenu_run")

  -- Take a screenshot in select mode.
  -- After pressing this key binding, click a window, or draw a rectangle with
  -- the mouse.
  , ((modMask .|. shiftMask, xK_p),
     spawn "select-screenshot")

  -- Take full screenshot in multi-head mode.
  -- That is, take a screenshot of everything you see.
  , ((modMask .|. controlMask .|. shiftMask, xK_p),
     spawn "screenshot")

  -- Fetch a single use password.
  , ((modMask .|. shiftMask, xK_o),
     spawn "fetchotp -x")


  -- Mute volume.
  , ((modMask .|. controlMask, xK_m),
     spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((modMask .|. controlMask, xK_j),
     spawn "amixer -q set Master 10%-")

  -- Increase volume.
  , ((modMask .|. controlMask, xK_k),
     spawn "amixer -q set Master 10%+")

  -- Audio previous.
  , ((0, 0x1008FF16),
     spawn "")

  -- Play/pause.
  , ((0, 0x1008FF14),
     spawn "")

  -- Audio next.
  , ((0, 0x1008FF17),
     spawn "")

  -- Eject CD tray.
  , ((0, 0x1008FF2C),
     spawn "eject -T")

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]



------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

-- default tiling algorithm partitions the screen into two panes
basic :: Tall a
basic = Tall nmaster delta ratio
  where
    -- The default number of windows in the master pane
    nmaster = 1
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

myLayoutHook = smartBorders $ onWorkspace "8.irc" imLayout standardLayouts
  where
    standardLayouts = tall ||| wide ||| full ||| circle
    tall   = named "tall"   $ avoidStruts basic
    wide   = named "wide"   $ avoidStruts $ Mirror basic
    circle = named "circle" $ avoidStruts circleSimpleDefaultResizable
    full   = named "full"   $ noBorders Full

   -- IM layout (http://pbrisbin.com/posts/xmonads_im_layout)
    imLayout =
        named "im" $ avoidStruts $ withIM (1%9) pidginRoster $ reflectHoriz $
                                   withIM (1%8) skypeRoster standardLayouts
    pidginRoster = ClassName "Pidgin" `And` Role "buddy_list"
    skypeRoster  = ClassName "Skype"  `And` Role "MainWindow"

-- Set up the Layout prompt
myLayoutPrompt :: X ()
myLayoutPrompt = inputPromptWithCompl myXPConfig "Layout"
                 (mkComplFunFromList' allLayouts) ?+ (sendMessage . JumpToLayout)
  where
    allLayouts = ["tall", "wide", "circle", "full"]

    myXPConfig :: XPConfig
    myXPConfig = defaultXPConfig {
        autoComplete= Just 1000
    }

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]

myFloatHook = composeAll
    [ className     =? "GIMP"                     --> doFloat
    , className     =? "feh"                      --> doFloat
    , className     =? "Iceweasel"                --> moveToWeb
    , className     =? "Emacs"                    --> moveToCode
    , className     =? "Icedove"                  --> moveToMail
    , className     =? "MPlayer"                  --> moveToMedia
    , className     =? "Pidgin"                   --> moveToIM
    , classNotRole  ("Pidgin", "")                --> doFloat
    , className     =? "Skype"                    --> moveToIM
    , classNotRole  ("Skype", "MainWindow")       --> doFloat
    , className     =? "Gajim"                    --> moveToIM
    , classNotRole  ("Gajim", "roster")           --> doFloat
    , className     =? "Chromium"                 --> moveToWeb
    , className     =? "Google-chrome"            --> moveToWeb
    , resource      =? "desktop_window"           --> doIgnore
    , className     =? "Galculator"               --> doFloat
    , className     =? "Steam"                    --> doFloat
    , className     =? "Gimp"                     --> doFloat
    , resource      =? "gpicview"                 --> doFloat
    , className     =? "MPlayer"                  --> doFloat
    , className     =? "VirtualBox"               --> moveToMedia
    , className     =? "Xchat"                    --> moveToIM
    , className     =? "stalonetray"              --> doIgnore
    , manageDocks]
  where
    moveToMail  = doF $ W.shift "9.mail"
    moveToIM    = doF $ W.shift "8.irc"
    moveToWeb   = doF $ W.shift "1.web"
    moveToMedia = doF $ W.shift "7.media"
    moveToCode  = doF $ W.shift "2.code"

    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r

    role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
myLogHook h = dynamicLogWithPP xmobarPP
            { ppHidden = xmobarColor "grey" "" --tag color
            , ppOutput = hPutStrLn h           --tag list and window title
            , ppTitle = xmobarColor "green" "" --window title color
            }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStatusBar = "xmobar ~/.xmonad/xmobar.hs" --define first xmobar
myStartupHook :: X ()
myStartupHook = do
            spawn "xmobar ~/.xmonad/xmobar1.hs" --start second xmobar

------------------------------------------------------------------------
-- Default Config
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
   -- simple stuff
      terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor

   -- key bindings
    , keys               = myKeys
    , mouseBindings      = myMouseBindings

   -- hooks, layouts
    --, layoutHook         = myLayoutHook
    --, manageHook         = myManageHook
    --, startupHook        = myStartupHook
}

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
  din <- spawnPipe myStatusBar
  mapM_ spawn ["pidgin"]
  --xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  --xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar1.hs"
  xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = myLayoutHook 
        , logHook = myLogHook din
        , startupHook = myStartupHook
        , terminal = myTerminal
        , workspaces = myWorkspaces
      }
  --xmonad $ withUrgencyHook NoUrgencyHook
  --  { logHook = do FI.fadeInactiveLogHook 0xbbbbbbbb
  --               dynamicLogWithPP $ xmobarPP {
  --                     ppOutput = hPutStrLn xmproc
  --                   , ppTitle  = xmobarColor "#ff66ff" "" . shorten 50
  --                   , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
  --  , startupHook = myStartupHook
  --  }