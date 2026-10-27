{ pkgs, ... }: {
  programs.vesktop = {
    enable = true;
    vencord.mutableSettings = true;
    # enabledThemes is set by catppuccin.vesktop
  };

  programs.vesktop.vencord.settings = {
    autoUpdate = true;
    autoUpdateNotification = true;
    cloud = {
      authenticated = false;
      settingsSync = false;
      url = "https://api.vencord.dev/";
    };
    disableMinSize = false;
    eagerPatches = false;
    enableReactDevtools = false;
    frameless = false;
    nativeTitleBar = false;
    notifications = {
      logLimit = 50;
      position = "bottom-right";
      timeout = 5000;
      useNative = "not-focused";
    };
    plugins = {
      AccountPanelServerProfile = {
        enabled = true;
        prioritizeServerProfile = false;
      };
      AddAttachments = {
        enabled = true;
      };
      AlwaysAnimate = {
        enabled = false;
      };
      AlwaysExpandRoles = {
        enabled = false;
      };
      AlwaysTrust = {
        domain = true;
        enabled = false;
        file = true;
      };
      AnonymiseFileNames = {
        anonymiseByDefault = true;
        consistent = "image";
        enabled = true;
        method = 0;
        randomisedLength = 7;
      };
      BadgeAPI = {
        enabled = true;
      };
      BetterFolders = {
        enabled = false;
      };
      BetterGifAltText = {
        enabled = false;
      };
      BetterGifPicker = {
        enabled = false;
      };
      BetterRoleContext = {
        enabled = true;
        roleIconFileFormat = "png";
      };
      BetterRoleDot = {
        bothStyles = false;
        copyRoleColorInProfilePopout = false;
        enabled = false;
      };
      BetterSessions = {
        backgroundCheck = true;
        checkInterval = 20;
        enabled = true;
      };
      BetterSettings = {
        disableFade = false;
        eagerLoad = true;
        enabled = true;
        organizeMenu = true;
      };
      BetterUploadButton = {
        enabled = false;
      };
      BiggerStreamPreview = {
        enabled = false;
      };
      BlurNSFW = {
        blurAmount = 10;
        enabled = false;
      };
      CallTimer = {
        enabled = true;
        format = "stopwatch";
      };
      CharacterCounter = {
        colorEffects = true;
        enabled = true;
      };
      ChatInputButtonAPI = {
        enabled = true;
      };
      ClearURLs = {
        enabled = true;
      };
      ClientTheme = {
        color = "313338";
        enabled = false;
      };
      ColorSighted = {
        enabled = false;
      };
      CommandsAPI = {
        enabled = true;
      };
      ConcatenatedComponentExtractor = {
        enabled = true;
      };
      ConsoleJanitor = {
        enabled = false;
      };
      ConsoleShortcuts = {
        enabled = false;
      };
      ContextMenuAPI = {
        enabled = true;
      };
      CopyEmojiMarkdown = {
        copyUnicode = true;
        enabled = false;
      };
      CopyFileContents = {
        enabled = true;
      };
      CopyStickerLinks = {
        enabled = false;
      };
      CopyUserURLs = {
        enabled = false;
      };
      CrashHandler = {
        attemptToNavigateToHome = false;
        attemptToPreventCrashes = true;
        enabled = true;
      };
      CustomCommands = {
        enabled = false;
        tagsList = { };
      };
      CustomIdle = {
        enabled = false;
        idleTimeout = 10;
        remainInIdle = true;
      };
      CustomRPC = {
        enablePresence = true;
        enabled = false;
      };
      Dearrow = {
        dearrowByDefault = true;
        enabled = false;
        hideButton = false;
        replaceElements = 0;
      };
      Decor = {
        enabled = false;
      };
      DirectFileDownload = {
        enabled = true;
      };
      DisableCallIdle = {
        enabled = false;
      };
      DisableDeepLinks = {
        enabled = true;
      };
      DontRoundMyTimestamps = {
        enabled = true;
      };
      DynamicImageModalAPI = {
        enabled = true;
      };
      Experiments = {
        enabled = true;
      };
      ExpressionCloner = {
        enabled = false;
      };
      F8Break = {
        enabled = false;
      };
      FakeNitro = {
        disableEmbedPermissionCheck = false;
        emojiSize = 48;
        enableEmojiBypass = false;
        enableStickerBypass = false;
        enableStreamQualityBypass = true;
        enabled = true;
        hyperLinkText = "{{NAME}}";
        stickerSize = 160;
        transformCompoundSentence = false;
        transformEmojis = true;
        transformStickers = true;
        useHyperLinks = true;
      };
      FakeProfileThemes = {
        enabled = false;
      };
      FavoriteEmojiFirst = {
        enabled = true;
      };
      FixCodeblockGap = {
        enabled = true;
      };
      FixDiscordCss = {
        enabled = true;
      };
      FixImagesQuality = {
        enabled = true;
        originalImagesInChat = false;
      };
      FixSpotifyEmbeds = {
        enabled = false;
      };
      FixYoutubeEmbeds = {
        enabled = false;
      };
      ForceOwnerCrown = {
        enabled = false;
      };
      FriendInvites = {
        enabled = false;
      };
      FullSearchContext = {
        enabled = false;
      };
      FullUserInChatbox = {
        enabled = true;
      };
      GameActivityToggle = {
        enabled = true;
        location = "PANEL";
        oldIcon = false;
      };
      GifPaste = {
        enabled = false;
      };
      GifProviderSwitcher = {
        enabled = false;
      };
      GreetStickerPicker = {
        enabled = false;
      };
      HideMedia = {
        enabled = false;
      };
      IgnoreActivities = {
        enabled = false;
      };
      ImageFilename = {
        enabled = true;
        showFullUrl = false;
      };
      ImageLink = {
        enabled = false;
      };
      ImageZoom = {
        enabled = false;
      };
      ImplicitRelationships = {
        enabled = false;
        sortByAffinity = true;
      };
      IrcColors = {
        applyColorOnlyInDms = false;
        applyColorOnlyToUsersWithoutColor = true;
        enabled = true;
        lightness = 80;
        memberListColors = true;
      };
      JumpToTop = {
        enabled = false;
      };
      KeepCurrentChannel = {
        enabled = false;
      };
      LoadingQuotes = {
        additionalQuotes = "sudo rm -rf /";
        additionalQuotesDelimiter = "|";
        enableDiscordPresetQuotes = false;
        enablePluginPresetQuotes = true;
        enabled = true;
        replaceEvents = true;
      };
      MemberCount = {
        enabled = true;
        memberList = true;
        toolTip = true;
        voiceActivity = true;
      };
      MemberListDecoratorsAPI = {
        enabled = true;
      };
      MentionAvatars = {
        enabled = false;
      };
      MessageAccessoriesAPI = {
        enabled = true;
      };
      MessageClickActions = {
        enabled = false;
      };
      MessageDecorationsAPI = {
        enabled = true;
      };
      MessageEventsAPI = {
        enabled = true;
      };
      MessageLatency = {
        enabled = false;
      };
      MessageLinkEmbeds = {
        automodEmbeds = "never";
        enabled = false;
        idList = "";
        listMode = "blacklist";
      };
      MessageLogger = {
        collapseDeleted = false;
        deleteStyle = "text";
        enabled = false;
        ignoreBots = true;
        ignoreChannels = "";
        ignoreGuilds = "";
        ignoreSelf = false;
        ignoreUsers = "";
        inlineEdits = true;
        logDeletedAttachments = true;
        logDeletes = true;
        logEdits = true;
      };
      MessagePopoverAPI = {
        enabled = true;
      };
      MessageUpdaterAPI = {
        enabled = true;
      };
      MoreQuickReactions = {
        enabled = false;
        reactionCount = 5;
      };
      MusicRichPresence = {
        enabled = false;
      };
      MutualGroupDMs = {
        enabled = true;
      };
      NewGuildSettings = {
        enabled = true;
        events = true;
        everyone = true;
        guild = true;
        highlights = true;
        messages = 3;
        role = false;
        showAllChannels = false;
      };
      NoBlockedMessages = {
        applyToIgnoredUsers = true;
        enabled = false;
        ignoreMessages = false;
      };
      NoDevtoolsWarning = {
        enabled = false;
      };
      NoF1 = {
        enabled = true;
      };
      NoMaskedUrlPaste = {
        enabled = false;
      };
      NoMiddleClickPaste = {
        enabled = true;
      };
      NoMosaic = {
        enabled = false;
        inlineVideo = true;
      };
      NoOnboardingDelay = {
        enabled = true;
      };
      NoPendingCount = {
        enabled = false;
        hideFriendRequestsCount = true;
        hideMessageRequestsCount = true;
        hidePremiumOffersCount = true;
      };
      NoProfileThemes = {
        enabled = false;
      };
      NoReplyMention = {
        enabled = false;
      };
      NoServerEmojis = {
        enabled = false;
        shownEmojis = "onlyUnicode";
      };
      NoTrack = {
        disableAnalytics = true;
        enabled = true;
      };
      NoTypingAnimation = {
        enabled = false;
      };
      NoUnblockToJump = {
        enabled = true;
      };
      NoticesAPI = {
        enabled = true;
      };
      NotificationVolume = {
        enabled = false;
        notificationVolume = 100;
      };
      OnePingPerDM = {
        enabled = false;
      };
      OpenInApp = {
        enabled = true;
        epic = false;
        itunes = false;
        spotify = false;
        steam = true;
        tidal = false;
      };
      OverrideForumDefaults = {
        enabled = false;
      };
      PauseInvitesForever = {
        enabled = false;
      };
      PermissionFreeWill = {
        enabled = false;
        lockout = true;
        onboarding = true;
      };
      PermissionsViewer = {
        enabled = true;
        permissionsSortOrder = 0;
      };
      PictureInPicture = {
        enabled = true;
        loop = false;
      };
      PinDMs = {
        enabled = false;
      };
      PlainFolderIcon = {
        enabled = false;
      };
      PlatformIndicators = {
        enabled = false;
      };
      PreviewMessage = {
        enabled = false;
      };
      QuickMention = {
        enabled = false;
      };
      QuickReply = {
        enabled = false;
      };
      ReactErrorDecoder = {
        enabled = false;
      };
      ReadAllNotificationsButton = {
        enabled = false;
      };
      RelationshipNotifier = {
        enabled = false;
        friendRequestCancels = true;
        friends = true;
        groups = true;
        notices = false;
        offlineRemovals = true;
        servers = true;
      };
      ReplaceGoogleSearch = {
        enabled = false;
        replacementEngine = "off";
      };
      ReplyTimestamp = {
        enabled = false;
      };
      RevealAllSpoilers = {
        enabled = false;
      };
      ReverseImageSearch = {
        enabled = false;
      };
      ReviewDB = {
        enabled = false;
      };
      RoleColorEverywhere = {
        enabled = false;
      };
      SecretRingToneEnabler = {
        enabled = false;
      };
      SendTimestamps = {
        enabled = false;
        replaceMessageContents = true;
      };
      ServerInfo = {
        enabled = true;
      };
      ServerListAPI = {
        enabled = false;
      };
      ServerListIndicators = {
        enabled = false;
      };
      Settings = {
        enabled = true;
        includeVencordInfoWhenCopying = true;
        settingsLocation = "aboveNitro";
      };
      ShikiCodeblocks = {
        bgOpacity = 100;
        enabled = true;
        theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/catppuccin-mocha.json";
        tryDiscordHighlighter = "SECONDARY";
        useDevIcon = "GREYSCALE";
      };
      ShowAllMessageButtons = {
        enabled = false;
      };
      ShowConnections = {
        enabled = false;
        iconSize = 32;
        iconSpacing = 1;
      };
      ShowHiddenChannels = {
        enabled = false;
      };
      ShowHiddenThings = {
        enabled = false;
      };
      ShowMeYourName = {
        enabled = false;
      };
      ShowTimeoutDuration = {
        displayStyle = "tooltip";
        enabled = true;
      };
      SilentMessageToggle = {
        enabled = false;
      };
      SilentTyping = {
        contextMenu = true;
        enabled = false;
        isEnabled = true;
        showIcon = false;
      };
      SortFriendRequests = {
        enabled = true;
        showDates = true;
      };
      SpotifyControls = {
        enabled = false;
      };
      SpotifyCrack = {
        enabled = false;
      };
      SpotifyShareCommands = {
        enabled = false;
      };
      StartupTimings = {
        enabled = false;
      };
      StickerPaste = {
        enabled = false;
      };
      StreamerModeOnStream = {
        enabled = false;
      };
      SuperReactionTweaks = {
        enabled = false;
      };
      SupportHelper = {
        enabled = true;
      };
      TextReplace = {
        enabled = false;
      };
      ThemeAttributes = {
        enabled = false;
      };
      Translate = {
        enabled = false;
      };
      TypingIndicator = {
        enabled = false;
        includeBlockedUsers = false;
        includeCurrentChannel = true;
        includeIgnoredUsers = false;
        includeMutedChannels = false;
        indicatorMode = 3;
      };
      TypingTweaks = {
        alternativeFormatting = false;
        enabled = true;
        showAvatars = false;
        showRoleColors = true;
      };
      USRBG = {
        enabled = false;
        nitroFirst = true;
        voiceBackground = true;
      };
      Unindent = {
        enabled = true;
      };
      UnlockedAvatarZoom = {
        enabled = false;
      };
      UnsuppressEmbeds = {
        enabled = false;
      };
      UserMessagesPronouns = {
        enabled = false;
        pronounsFormat = "LOWERCASE";
        showSelf = true;
      };
      UserSettingsAPI = {
        enabled = true;
      };
      UserVoiceShow = {
        enabled = true;
        showInMemberList = false;
        showInMessages = false;
        showInUserProfileModal = true;
      };
      ValidReply = {
        enabled = false;
      };
      ValidUser = {
        enabled = false;
      };
      VcNarrator = {
        enabled = false;
      };
      VencordToolbox = {
        enabled = true;
        showPluginMenu = true;
      };
      ViewIcons = {
        enabled = false;
      };
      ViewRaw = {
        clickMethod = "Right";
        enabled = true;
        messageContextMenu = false;
        sortKeys = true;
        stripSensitiveData = true;
      };
      VoiceChatDoubleClick = {
        enabled = true;
      };
      VoiceDownload = {
        enabled = false;
      };
      VoiceMessages = {
        enabled = false;
      };
      VolumeBooster = {
        enabled = true;
        multiplier = 2;
      };
      WebContextMenus = {
        enabled = true;
      };
      WebKeybinds = {
        enabled = true;
        overrideCommonKeybinds = true;
        showNavigationButtons = true;
      };
      "WebRichPresence (arRPC)" = {
        enabled = false;
      };
      WebScreenShareFixes = {
        enabled = true;
      };
      WhoReacted = {
        enabled = false;
      };
      XSOverlay = {
        enabled = false;
      };
      YoutubeAdblock = {
        enabled = true;
      };
      iLoveSpam = {
        enabled = false;
      };
      oneko = {
        enabled = false;
      };
      petpet = {
        enabled = false;
      };
    };
    themeLinks = [ ];
    transparent = false;
    uiElements = {
      chatBarButtons = { };
      messagePopoverButtons = { };
    };
    useQuickCss = true;
    winCtrlQ = false;
    windowsMaterial = "none";
  };
}
