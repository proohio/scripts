local BinaryUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local function Tween(obj, props, dur, style, dir)
	style = style or Enum.EasingStyle.Quart
	dir = dir or Enum.EasingDirection.Out
	TweenService:Create(obj, TweenInfo.new(dur, style, dir), props):Play()
end
local themeStyles = {
	Binary = {
		Primary        = Color3.fromRGB(0, 175, 255),
		PrimaryDim     = Color3.fromRGB(0, 120, 200),
		PrimaryGlow    = Color3.fromRGB(80, 210, 255),
		Background     = Color3.fromRGB(3, 4, 8),
		Panel          = Color3.fromRGB(7, 9, 16),
		Card           = Color3.fromRGB(11, 14, 22),
		CardHover      = Color3.fromRGB(15, 19, 30),
		Sidebar        = Color3.fromRGB(5, 7, 12),
		Header         = Color3.fromRGB(4, 5, 10),
		Border         = Color3.fromRGB(0, 140, 210),
		BorderDim      = Color3.fromRGB(20, 35, 55),
		TextPrimary    = Color3.fromRGB(210, 232, 255),
		TextSecondary  = Color3.fromRGB(80, 120, 165),
		TextAccent     = Color3.fromRGB(0, 185, 255),
		TabInactive    = Color3.fromRGB(60, 90, 130),
	},
	Midnight = {
		Primary        = Color3.fromRGB(145, 85, 255),
		PrimaryDim     = Color3.fromRGB(100, 55, 200),
		PrimaryGlow    = Color3.fromRGB(185, 130, 255),
		Background     = Color3.fromRGB(4, 3, 9),
		Panel          = Color3.fromRGB(8, 7, 16),
		Card           = Color3.fromRGB(13, 11, 23),
		CardHover      = Color3.fromRGB(18, 15, 32),
		Sidebar        = Color3.fromRGB(6, 5, 13),
		Header         = Color3.fromRGB(5, 4, 10),
		Border         = Color3.fromRGB(120, 65, 230),
		BorderDim      = Color3.fromRGB(35, 20, 60),
		TextPrimary    = Color3.fromRGB(225, 215, 255),
		TextSecondary  = Color3.fromRGB(100, 80, 160),
		TextAccent     = Color3.fromRGB(165, 105, 255),
		TabInactive    = Color3.fromRGB(90, 70, 140),
	},
	Ember = {
		Primary        = Color3.fromRGB(255, 88, 28),
		PrimaryDim     = Color3.fromRGB(200, 60, 10),
		PrimaryGlow    = Color3.fromRGB(255, 140, 70),
		Background     = Color3.fromRGB(8, 4, 3),
		Panel          = Color3.fromRGB(14, 9, 7),
		Card           = Color3.fromRGB(20, 13, 10),
		CardHover      = Color3.fromRGB(26, 18, 13),
		Sidebar        = Color3.fromRGB(10, 6, 5),
		Header         = Color3.fromRGB(7, 5, 4),
		Border         = Color3.fromRGB(210, 78, 18),
		BorderDim      = Color3.fromRGB(50, 22, 10),
		TextPrimary    = Color3.fromRGB(255, 232, 215),
		TextSecondary  = Color3.fromRGB(165, 100, 78),
		TextAccent     = Color3.fromRGB(255, 118, 48),
		TabInactive    = Color3.fromRGB(140, 80, 55),
	},
}
local function EnableDragging(handle, target)
	target = target or handle
	local dragging, dragInput, mousePos, framePos = false, nil, nil, nil
	handle.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = inp.Position
			framePos = target.Position
			inp.Changed:Connect(function()
				if inp.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	handle.InputChanged:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseMovement then dragInput = inp end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if inp == dragInput and dragging then
			local delta = inp.Position - mousePos
			target.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
		end
	end)
end
local LibName = "BinaryUI_" .. tostring(math.random(1000, 9999))
function BinaryUI:ToggleUI()
	local gui = game.CoreGui:FindFirstChild(LibName)
	if gui then gui.Enabled = not gui.Enabled end
end
function BinaryUI.CreateLib(libraryName, themeList)
	libraryName = libraryName or "Binary"
	if not themeList then themeList = themeStyles.Binary end
	if type(themeList) == "string" then themeList = themeStyles[themeList] or themeStyles.Binary end
	for _, v in pairs(game.CoreGui:GetChildren()) do
		if v.Name == LibName then v:Destroy() end
	end
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = LibName
	ScreenGui.Parent = game.CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	-- ── Root window ────────────────────────────────────────────────
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = themeList.Background
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, -330, 0.5, -230)
	Main.Size = UDim2.new(0, 660, 0, 460)
	Main.ClipsDescendants = true
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 10)
	MainCorner.Parent = Main
	local OuterGlow = Instance.new("UIStroke")
	OuterGlow.Color = themeList.Border
	OuterGlow.Thickness = 1
	OuterGlow.Transparency = 0.55
	OuterGlow.Parent = Main
	-- Entrance animation
	Main.BackgroundTransparency = 1
	OuterGlow.Transparency = 1
	Main.Position = UDim2.new(0.5, -330, 0.5, -218)
	Tween(Main, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -330, 0.5, -230)}, 0.38, Enum.EasingStyle.Quint)
	delay(0.05, function() Tween(OuterGlow, {Transparency = 0.55}, 0.4) end)
	-- ── Header bar ─────────────────────────────────────────────────
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = Main
	TopBar.BackgroundColor3 = themeList.Header
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 46)
	TopBar.ZIndex = 8
	-- No rounded corners needed — clipped by Main
	-- Thin bottom accent line
	local TopAccent = Instance.new("Frame")
	TopAccent.Parent = TopBar
	TopAccent.BackgroundColor3 = themeList.Primary
	TopAccent.BackgroundTransparency = 0.45
	TopAccent.BorderSizePixel = 0
	TopAccent.Position = UDim2.new(0, 0, 1, -1)
	TopAccent.Size = UDim2.new(1, 0, 0, 1)
	TopAccent.ZIndex = 9
	EnableDragging(TopBar, Main)
	-- Logo (black bg square)
	local LogoBg = Instance.new("Frame")
	LogoBg.Parent = TopBar
	LogoBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	LogoBg.BorderSizePixel = 0
	LogoBg.Position = UDim2.new(0, 13, 0.5, -12)
	LogoBg.Size = UDim2.new(0, 24, 0, 24)
	LogoBg.ZIndex = 10
	local LogoBgCorner = Instance.new("UICorner")
	LogoBgCorner.CornerRadius = UDim.new(0, 5)
	LogoBgCorner.Parent = LogoBg
	local LogoImg = Instance.new("ImageLabel")
	LogoImg.Parent = LogoBg
	LogoImg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	LogoImg.BackgroundTransparency = 0
	LogoImg.BorderSizePixel = 0
	LogoImg.Size = UDim2.new(1, 0, 1, 0)
	LogoImg.Image = "rbxassetid://75637976565211"
	LogoImg.ImageColor3 = themeList.Primary
	LogoImg.ZIndex = 11
	coroutine.wrap(function()
		while true do
			Tween(LogoImg, {ImageColor3 = themeList.PrimaryGlow}, 2, Enum.EasingStyle.Sine)
			wait(2)
			Tween(LogoImg, {ImageColor3 = themeList.Primary}, 2, Enum.EasingStyle.Sine)
			wait(2)
		end
	end)()
	-- Title
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = TopBar
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.new(0, 45, 0, 0)
	TitleLabel.Size = UDim2.new(1, -170, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = libraryName
	TitleLabel.TextColor3 = themeList.TextPrimary
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.ZIndex = 9
	-- Window controls
	local function MakeCtrlBtn(xOff, icon, hColor)
		local B = Instance.new("TextButton")
		B.Parent = TopBar
		B.BackgroundColor3 = themeList.Card
		B.BorderSizePixel = 0
		B.Position = UDim2.new(1, xOff, 0.5, -10)
		B.Size = UDim2.new(0, 26, 0, 20)
		B.Font = Enum.Font.GothamBold
		B.Text = icon
		B.TextColor3 = themeList.TextSecondary
		B.TextSize = 12
		B.AutoButtonColor = false
		B.ZIndex = 10
		local BC = Instance.new("UICorner")
		BC.CornerRadius = UDim.new(0, 4)
		BC.Parent = B
		local BS = Instance.new("UIStroke")
		BS.Color = themeList.BorderDim
		BS.Thickness = 1
		BS.Transparency = 0
		BS.Parent = B
		B.MouseEnter:Connect(function()
			Tween(B, {BackgroundColor3 = hColor, TextColor3 = Color3.fromRGB(255,255,255)}, 0.1)
			Tween(BS, {Color = themeList.Border, Transparency = 0.5}, 0.1)
		end)
		B.MouseLeave:Connect(function()
			Tween(B, {BackgroundColor3 = themeList.Card, TextColor3 = themeList.TextSecondary}, 0.1)
			Tween(BS, {Color = themeList.BorderDim, Transparency = 0}, 0.1)
		end)
		return B
	end
	local minimized = false
	local MinBtn = MakeCtrlBtn(-62, "—", themeList.CardHover)
	MinBtn.TextSize = 10
	MinBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			Tween(Main, {Size = UDim2.new(0, 660, 0, 46)}, 0.28, Enum.EasingStyle.Quart)
		else
			Tween(Main, {Size = UDim2.new(0, 660, 0, 460)}, 0.32, Enum.EasingStyle.Back)
		end
	end)
	local CloseBtn = MakeCtrlBtn(-30, "✕", Color3.fromRGB(180, 35, 35))
	CloseBtn.MouseButton1Click:Connect(function()
		Tween(Main, {BackgroundTransparency = 1, Position = UDim2.new(0.5, -330, 0.5, -218)}, 0.22, Enum.EasingStyle.Quart)
		Tween(OuterGlow, {Transparency = 1}, 0.22)
		wait(0.25)
		ScreenGui:Destroy()
	end)
	-- ── Sidebar ────────────────────────────────────────────────────
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Main
	Sidebar.BackgroundColor3 = themeList.Sidebar
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0, 46)
	Sidebar.Size = UDim2.new(0, 170, 1, -46)
	Sidebar.ZIndex = 2
	-- Right separator line
	local SidebarSep = Instance.new("Frame")
	SidebarSep.Parent = Sidebar
	SidebarSep.BackgroundColor3 = themeList.BorderDim
	SidebarSep.BorderSizePixel = 0
	SidebarSep.Position = UDim2.new(1, -1, 0, 0)
	SidebarSep.Size = UDim2.new(0, 1, 1, 0)
	SidebarSep.ZIndex = 3
	-- Mascot at bottom of sidebar (fixed, always visible)
	local MascotBg = Instance.new("Frame")
	MascotBg.Name = "MascotBg"
	MascotBg.Parent = Main
	MascotBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MascotBg.BorderSizePixel = 0
	MascotBg.Position = UDim2.new(0, 0, 1, -95)
	MascotBg.Size = UDim2.new(0, 170, 0, 95)
	MascotBg.ZIndex = 6
	MascotBg.ClipsDescendants = true
	-- Top line above mascot area
	local MascotSepLine = Instance.new("Frame")
	MascotSepLine.Parent = MascotBg
	MascotSepLine.BackgroundColor3 = themeList.BorderDim
	MascotSepLine.BorderSizePixel = 0
	MascotSepLine.Size = UDim2.new(1, 0, 0, 1)
	MascotSepLine.ZIndex = 7
	-- Right line continues
	local MascotRightSep = Instance.new("Frame")
	MascotRightSep.Parent = MascotBg
	MascotRightSep.BackgroundColor3 = themeList.BorderDim
	MascotRightSep.BorderSizePixel = 0
	MascotRightSep.Position = UDim2.new(1, -1, 0, 0)
	MascotRightSep.Size = UDim2.new(0, 1, 1, 0)
	MascotRightSep.ZIndex = 7
	local MascotImg = Instance.new("ImageLabel")
	MascotImg.Name = "Mascot"
	MascotImg.Parent = MascotBg
	MascotImg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MascotImg.BackgroundTransparency = 0
	MascotImg.BorderSizePixel = 0
	MascotImg.Position = UDim2.new(0.5, -42, 0, 2)
	MascotImg.Size = UDim2.new(0, 84, 0, 90)
	MascotImg.Image = "rbxassetid://125348433159932"
	MascotImg.ImageTransparency = 0
	MascotImg.ScaleType = Enum.ScaleType.Fit
	MascotImg.ZIndex = 8
	-- Tab scroll area (leaves room for mascot)
	local TabScroll = Instance.new("ScrollingFrame")
	TabScroll.Name = "TabScroll"
	TabScroll.Parent = Sidebar
	TabScroll.BackgroundTransparency = 1
	TabScroll.BorderSizePixel = 0
	TabScroll.Position = UDim2.new(0, 0, 0, 8)
	TabScroll.Size = UDim2.new(1, 0, 1, -16)
	TabScroll.ScrollBarThickness = 0
	TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	TabScroll.ZIndex = 3
	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Parent = TabScroll
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding = UDim.new(0, 2)
	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 8)
	end)
	local TabPadding = Instance.new("UIPadding")
	TabPadding.Parent = TabScroll
	TabPadding.PaddingLeft = UDim.new(0, 8)
	TabPadding.PaddingRight = UDim.new(0, 8)
	-- ── Content area ───────────────────────────────────────────────
	local ContentArea = Instance.new("Frame")
	ContentArea.Name = "ContentArea"
	ContentArea.Parent = Main
	ContentArea.BackgroundColor3 = themeList.Panel
	ContentArea.BorderSizePixel = 0
	ContentArea.Position = UDim2.new(0, 170, 0, 46)
	ContentArea.Size = UDim2.new(1, -170, 1, -46)
	ContentArea.ClipsDescendants = true
	local Pages = Instance.new("Folder")
	Pages.Name = "Pages"
	Pages.Parent = ContentArea
	coroutine.wrap(function()
		while wait(0.6) do
			Main.BackgroundColor3 = themeList.Background
			TopBar.BackgroundColor3 = themeList.Header
			Sidebar.BackgroundColor3 = themeList.Sidebar
			MascotBg.BackgroundColor3 = Color3.fromRGB(0,0,0)
			ContentArea.BackgroundColor3 = themeList.Panel
			TitleLabel.TextColor3 = themeList.TextPrimary
			OuterGlow.Color = themeList.Border
		end
	end)()
	function BinaryUI:ChangeColor(property, color)
		if property == "Background" then themeList.Background = color
		elseif property == "Primary" then themeList.Primary = color
		elseif property == "Header" then themeList.Header = color
		elseif property == "TextPrimary" then themeList.TextPrimary = color
		elseif property == "Card" then themeList.Card = color
		elseif property == "TextAccent" then themeList.TextAccent = color
		end
	end
	-- ══════════════════════════════════════════════════════════════════
	local Tabs = {}
	local firstTab = true
	local currentPage = nil
	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		-- Page
		local Page = Instance.new("ScrollingFrame")
		Page.Name = tabName .. "_Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.ScrollBarThickness = 2
		Page.ScrollBarImageColor3 = themeList.Primary
		Page.ScrollBarImageTransparency = 0.4
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.Visible = false
		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Parent = Page
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 8)
		local PagePad = Instance.new("UIPadding")
		PagePad.Parent = Page
		PagePad.PaddingTop = UDim.new(0, 10)
		PagePad.PaddingBottom = UDim.new(0, 10)
		PagePad.PaddingLeft = UDim.new(0, 10)
		PagePad.PaddingRight = UDim.new(0, 10)
		local function UpdatePage()
			local cs = PageLayout.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0,0,0, cs.Y + 20)}):Play()
		end
		-- Tab button — full-width pill style
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = tabName
		TabBtn.Parent = TabScroll
		TabBtn.BackgroundColor3 = firstTab and themeList.Card or Color3.fromRGB(0,0,0)
		TabBtn.BackgroundTransparency = firstTab and 0 or 1
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 34)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.GothamSemibold
		TabBtn.Text = tabName
		TabBtn.TextColor3 = firstTab and themeList.TextAccent or themeList.TabInactive
		TabBtn.TextSize = 13
		TabBtn.ZIndex = 4
		local TBC = Instance.new("UICorner")
		TBC.CornerRadius = UDim.new(0, 6)
		TBC.Parent = TabBtn
		-- Left accent bar
		local TBBar = Instance.new("Frame")
		TBBar.Parent = TabBtn
		TBBar.BackgroundColor3 = themeList.Primary
		TBBar.BorderSizePixel = 0
		TBBar.Position = UDim2.new(0, 0, 0.18, 0)
		TBBar.Size = UDim2.new(0, 2, 0.64, 0)
		TBBar.BackgroundTransparency = firstTab and 0 or 1
		TBBar.ZIndex = 5
		local TBBC = Instance.new("UICorner")
		TBBC.CornerRadius = UDim.new(1, 0)
		TBBC.Parent = TBBar
		local TBStroke = Instance.new("UIStroke")
		TBStroke.Color = themeList.Border
		TBStroke.Thickness = 1
		TBStroke.Transparency = firstTab and 0.55 or 1
		TBStroke.Parent = TabBtn
		if firstTab then
			Page.Visible = true
			currentPage = Page
			firstTab = false
			UpdatePage()
		end
		local function SelectTab()
			if currentPage == Page then return end
			-- Fade out old
			if currentPage then
				local old = currentPage
				Tween(old, {BackgroundTransparency = 1}, 0.1)
				wait(0.08)
				old.Visible = false
				old.BackgroundTransparency = 1
			end
			-- Deselect all
			for _, b in pairs(TabScroll:GetChildren()) do
				if b:IsA("TextButton") then
					Tween(b, {BackgroundTransparency = 1, TextColor3 = themeList.TabInactive}, 0.18)
					local bar = b:FindFirstChild("Frame")
					local stroke = b:FindFirstChildOfClass("UIStroke")
					if bar then Tween(bar, {BackgroundTransparency = 1}, 0.15) end
					if stroke then Tween(stroke, {Transparency = 1}, 0.15) end
				end
			end
			-- Select this
			Tween(TabBtn, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.18)
			Tween(TBBar, {BackgroundTransparency = 0}, 0.15)
			Tween(TBStroke, {Transparency = 0.55}, 0.15)
			Page.BackgroundTransparency = 1
			Page.Visible = true
			currentPage = Page
			Tween(Page, {BackgroundTransparency = 1}, 0.15)
			UpdatePage()
		end
		TabBtn.MouseButton1Click:Connect(SelectTab)
		TabBtn.MouseEnter:Connect(function()
			if currentPage ~= Page then
				Tween(TabBtn, {BackgroundTransparency = 0.75, TextColor3 = themeList.TextSecondary}, 0.12)
			end
		end)
		TabBtn.MouseLeave:Connect(function()
			if currentPage ~= Page then
				Tween(TabBtn, {BackgroundTransparency = 1, TextColor3 = themeList.TabInactive}, 0.12)
			end
		end)
		Page.ChildAdded:Connect(UpdatePage)
		Page.ChildRemoved:Connect(UpdatePage)
		coroutine.wrap(function()
			while wait(0.6) do
				TabBtn.BackgroundColor3 = themeList.Card
				Page.ScrollBarImageColor3 = themeList.Primary
			end
		end)()
		-- ════════════════════════════════════════════════════════════
		local Sections = {}
		function Sections:NewSection(sectionName, hidden)
			sectionName = sectionName or "Section"
			hidden = hidden or false
			local SFrame = Instance.new("Frame")
			SFrame.Parent = Page
			SFrame.BackgroundTransparency = 1
			SFrame.Size = UDim2.new(1, 0, 0, 30)
			local SLayout = Instance.new("UIListLayout")
			SLayout.Parent = SFrame
			SLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SLayout.Padding = UDim.new(0, 6)
			-- Section label row
			local SHead = Instance.new("Frame")
			SHead.Parent = SFrame
			SHead.BackgroundTransparency = 1
			SHead.Size = UDim2.new(1, 0, 0, 18)
			SHead.Visible = not hidden
			local SLabel = Instance.new("TextLabel")
			SLabel.Parent = SHead
			SLabel.BackgroundTransparency = 1
			SLabel.Size = UDim2.new(1, -8, 1, 0)
			SLabel.Position = UDim2.new(0, 8, 0, 0)
			SLabel.Font = Enum.Font.GothamBold
			SLabel.Text = sectionName:upper()
			SLabel.TextColor3 = themeList.TextAccent
			SLabel.TextSize = 10
			SLabel.TextXAlignment = Enum.TextXAlignment.Left
			SLabel.TextTransparency = 0.15
			-- Thin line after label
			local SLine = Instance.new("Frame")
			SLine.Parent = SHead
			SLine.BackgroundColor3 = themeList.BorderDim
			SLine.BorderSizePixel = 0
			SLine.Position = UDim2.new(0, 0, 1, -1)
			SLine.Size = UDim2.new(1, 0, 0, 1)
			-- Content
			local SContent = Instance.new("Frame")
			SContent.Name = "Content"
			SContent.Parent = SFrame
			SContent.BackgroundTransparency = 1
			SContent.Size = UDim2.new(1, 0, 0, 0)
			local CLayout = Instance.new("UIListLayout")
			CLayout.Parent = SContent
			CLayout.SortOrder = Enum.SortOrder.LayoutOrder
			CLayout.Padding = UDim.new(0, 5)
			local function UpdateSection()
				local cs = CLayout.AbsoluteContentSize
				SContent.Size = UDim2.new(1, 0, 0, cs.Y)
				local ts = SLayout.AbsoluteContentSize
				SFrame.Size = UDim2.new(1, 0, 0, ts.Y)
				UpdatePage()
			end
			SContent.ChildAdded:Connect(UpdateSection)
			SContent.ChildRemoved:Connect(UpdateSection)
			coroutine.wrap(function()
				while wait(0.6) do
					SLabel.TextColor3 = themeList.TextAccent
					SLine.BackgroundColor3 = themeList.BorderDim
				end
			end)()
			-- Element factory
			local function MakeCard(h)
				local Card = Instance.new("Frame")
				Card.Parent = SContent
				Card.BackgroundColor3 = themeList.Card
				Card.BorderSizePixel = 0
				Card.Size = UDim2.new(1, 0, 0, h)
				local CC = Instance.new("UICorner")
				CC.CornerRadius = UDim.new(0, 7)
				CC.Parent = Card
				local CS = Instance.new("UIStroke")
				CS.Color = themeList.BorderDim
				CS.Thickness = 1
				CS.Transparency = 0
				CS.Parent = Card
				return Card, CC, CS
			end
			local Elements = {}
			-- ── BUTTON ───────────────────────────────────────────────
			function Elements:NewButton(buttonName, buttonInfo, callback)
				buttonName = buttonName or "Button"
				callback = callback or function() end
				local Card, CC, CS = MakeCard(40)
				-- Subtle left accent
				local BtnAccent = Instance.new("Frame")
				BtnAccent.Parent = Card
				BtnAccent.BackgroundColor3 = themeList.Primary
				BtnAccent.BackgroundTransparency = 0.7
				BtnAccent.BorderSizePixel = 0
				BtnAccent.Position = UDim2.new(0, 0, 0.2, 0)
				BtnAccent.Size = UDim2.new(0, 2, 0.6, 0)
				local BAC = Instance.new("UICorner")
				BAC.CornerRadius = UDim.new(1, 0)
				BAC.Parent = BtnAccent
				local Btn = Instance.new("TextButton")
				Btn.Parent = Card
				Btn.BackgroundTransparency = 1
				Btn.Size = UDim2.new(1, 0, 1, 0)
				Btn.Font = Enum.Font.GothamSemibold
				Btn.Text = buttonName
				Btn.TextColor3 = themeList.TextPrimary
				Btn.TextSize = 13
				Btn.AutoButtonColor = false
				Btn.ZIndex = 2
				-- Ripple overlay
				local Rip = Instance.new("Frame")
				Rip.BackgroundColor3 = themeList.Primary
				Rip.BackgroundTransparency = 1
				Rip.BorderSizePixel = 0
				Rip.Size = UDim2.new(1, 0, 1, 0)
				Rip.Parent = Card
				local RC = Instance.new("UICorner")
				RC.CornerRadius = UDim.new(0, 7)
				RC.Parent = Rip
				Btn.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
					Tween(BtnAccent, {BackgroundTransparency = 0.3}, 0.12)
				end)
				Btn.MouseLeave:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.Card}, 0.12)
					Tween(CS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
					Tween(BtnAccent, {BackgroundTransparency = 0.7}, 0.12)
				end)
				Btn.MouseButton1Click:Connect(function()
					Tween(Rip, {BackgroundTransparency = 0.85}, 0.06)
					wait(0.06)
					Tween(Rip, {BackgroundTransparency = 1}, 0.2)
					callback()
				end)
				coroutine.wrap(function()
					while wait(0.6) do
						Card.BackgroundColor3 = themeList.Card
						Btn.TextColor3 = themeList.TextPrimary
						CS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
				local BF = {}
				function BF:UpdateButton(t) Btn.Text = t end
				return BF
			end
			-- ── TOGGLE ───────────────────────────────────────────────
			function Elements:NewToggle(toggleName, toggleInfo, callback)
				toggleName = toggleName or "Toggle"
				callback = callback or function() end
				local toggled = false
				local Card, CC, CS = MakeCard(40)
				local Lbl = Instance.new("TextLabel")
				Lbl.Parent = Card
				Lbl.BackgroundTransparency = 1
				Lbl.Position = UDim2.new(0, 14, 0, 0)
				Lbl.Size = UDim2.new(1, -68, 1, 0)
				Lbl.Font = Enum.Font.GothamSemibold
				Lbl.Text = toggleName
				Lbl.TextColor3 = themeList.TextPrimary
				Lbl.TextSize = 13
				Lbl.TextXAlignment = Enum.TextXAlignment.Left
				-- Toggle pill track
				local Track = Instance.new("Frame")
				Track.Parent = Card
				Track.BackgroundColor3 = Color3.fromRGB(18, 24, 38)
				Track.BorderSizePixel = 0
				Track.Position = UDim2.new(1, -54, 0.5, -9)
				Track.Size = UDim2.new(0, 42, 0, 18)
				local TC = Instance.new("UICorner")
				TC.CornerRadius = UDim.new(1, 0)
				TC.Parent = Track
				local TS = Instance.new("UIStroke")
				TS.Color = Color3.fromRGB(35, 50, 75)
				TS.Thickness = 1
				TS.Parent = Track
				-- Knob
				local Knob = Instance.new("Frame")
				Knob.Parent = Track
				Knob.BackgroundColor3 = Color3.fromRGB(100, 130, 175)
				Knob.BorderSizePixel = 0
				Knob.Position = UDim2.new(0, 2, 0.5, -7)
				Knob.Size = UDim2.new(0, 14, 0, 14)
				local KC = Instance.new("UICorner")
				KC.CornerRadius = UDim.new(1, 0)
				KC.Parent = Knob
				local HitBtn = Instance.new("TextButton")
				HitBtn.Parent = Card
				HitBtn.BackgroundTransparency = 1
				HitBtn.Size = UDim2.new(1, 0, 1, 0)
				HitBtn.Text = ""
				HitBtn.ZIndex = 3
				HitBtn.MouseButton1Click:Connect(function()
					toggled = not toggled
					if toggled then
						Tween(Knob, {Position = UDim2.new(1,-16,0.5,-7), BackgroundColor3 = Color3.fromRGB(255,255,255)}, 0.18, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = themeList.PrimaryDim}, 0.18)
						Tween(TS, {Color = themeList.Primary}, 0.18)
						Tween(Lbl, {TextColor3 = themeList.TextAccent}, 0.18)
					else
						Tween(Knob, {Position = UDim2.new(0,2,0.5,-7), BackgroundColor3 = Color3.fromRGB(100,130,175)}, 0.18, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = Color3.fromRGB(18,24,38)}, 0.18)
						Tween(TS, {Color = Color3.fromRGB(35,50,75)}, 0.18)
						Tween(Lbl, {TextColor3 = themeList.TextPrimary}, 0.18)
					end
					callback(toggled)
				end)
				HitBtn.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
				end)
				HitBtn.MouseLeave:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.Card}, 0.12)
					Tween(CS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.6) do
						Card.BackgroundColor3 = themeList.Card
						if not toggled then Lbl.TextColor3 = themeList.TextPrimary end
						CS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
				local TF = {}
				function TF:UpdateToggle(newText, state)
					if newText then Lbl.Text = newText end
					if state ~= nil then
						toggled = state
						if toggled then
							Knob.Position = UDim2.new(1,-16,0.5,-7)
							Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
							Track.BackgroundColor3 = themeList.PrimaryDim
							TS.Color = themeList.Primary
							Lbl.TextColor3 = themeList.TextAccent
						else
							Knob.Position = UDim2.new(0,2,0.5,-7)
							Knob.BackgroundColor3 = Color3.fromRGB(100,130,175)
							Track.BackgroundColor3 = Color3.fromRGB(18,24,38)
							TS.Color = Color3.fromRGB(35,50,75)
							Lbl.TextColor3 = themeList.TextPrimary
						end
						callback(toggled)
					end
				end
				return TF
			end
			-- ── SLIDER ───────────────────────────────────────────────
			function Elements:NewSlider(sliderName, sliderInfo, maxValue, minValue, callback)
				sliderName = sliderName or "Slider"
				maxValue = maxValue or 100
				minValue = minValue or 0
				callback = callback or function() end
				local Card, CC, CS = MakeCard(52)
				local Lbl = Instance.new("TextLabel")
				Lbl.Parent = Card
				Lbl.BackgroundTransparency = 1
				Lbl.Position = UDim2.new(0, 14, 0, 6)
				Lbl.Size = UDim2.new(1, -80, 0, 18)
				Lbl.Font = Enum.Font.GothamSemibold
				Lbl.Text = sliderName
				Lbl.TextColor3 = themeList.TextPrimary
				Lbl.TextSize = 13
				Lbl.TextXAlignment = Enum.TextXAlignment.Left
				local ValLbl = Instance.new("TextLabel")
				ValLbl.Parent = Card
				ValLbl.BackgroundTransparency = 1
				ValLbl.Position = UDim2.new(1, -72, 0, 6)
				ValLbl.Size = UDim2.new(0, 60, 0, 18)
				ValLbl.Font = Enum.Font.GothamBold
				ValLbl.Text = tostring(minValue)
				ValLbl.TextColor3 = themeList.TextAccent
				ValLbl.TextSize = 13
				ValLbl.TextXAlignment = Enum.TextXAlignment.Right
				local TrackBg = Instance.new("Frame")
				TrackBg.Parent = Card
				TrackBg.BackgroundColor3 = Color3.fromRGB(16, 22, 36)
				TrackBg.BorderSizePixel = 0
				TrackBg.Position = UDim2.new(0, 14, 1, -17)
				TrackBg.Size = UDim2.new(1, -28, 0, 5)
				local TrC = Instance.new("UICorner")
				TrC.CornerRadius = UDim.new(1,0)
				TrC.Parent = TrackBg
				local Fill = Instance.new("Frame")
				Fill.Parent = TrackBg
				Fill.BackgroundColor3 = themeList.Primary
				Fill.BorderSizePixel = 0
				Fill.Size = UDim2.new(0,0,1,0)
				local FC = Instance.new("UICorner")
				FC.CornerRadius = UDim.new(1,0)
				FC.Parent = Fill
				local Dot = Instance.new("Frame")
				Dot.Parent = TrackBg
				Dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Dot.BorderSizePixel = 0
				Dot.Position = UDim2.new(0,-5,0.5,-5)
				Dot.Size = UDim2.new(0,10,0,10)
				Dot.ZIndex = 2
				local DC = Instance.new("UICorner")
				DC.CornerRadius = UDim.new(1,0)
				DC.Parent = Dot
				local DS = Instance.new("UIStroke")
				DS.Color = themeList.Primary
				DS.Thickness = 2
				DS.Transparency = 0.4
				DS.Parent = Dot
				local Hit = Instance.new("TextButton")
				Hit.Parent = TrackBg
				Hit.BackgroundTransparency = 1
				Hit.Size = UDim2.new(1,0,6,0)
				Hit.Position = UDim2.new(0,0,-2.5,0)
				Hit.Text = ""
				Hit.ZIndex = 4
				local drag = false
				Hit.MouseButton1Down:Connect(function() drag = true end)
				UserInputService.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
				end)
				UserInputService.InputChanged:Connect(function(i)
					if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
						local pct = math.clamp((i.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
						local val = math.floor(minValue + (maxValue - minValue) * pct)
						Fill.Size = UDim2.new(pct,0,1,0)
						Dot.Position = UDim2.new(pct,-5,0.5,-5)
						ValLbl.Text = tostring(val)
						callback(val)
					end
				end)
				Card.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
				end)
				Card.MouseLeave:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.Card}, 0.12)
					Tween(CS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.6) do
						Card.BackgroundColor3 = themeList.Card
						Lbl.TextColor3 = themeList.TextPrimary
						ValLbl.TextColor3 = themeList.TextAccent
						Fill.BackgroundColor3 = themeList.Primary
						CS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
			end
			-- ── TEXTBOX ──────────────────────────────────────────────
			function Elements:NewTextBox(textboxName, textboxInfo, callback)
				textboxName = textboxName or "TextBox"
				callback = callback or function() end
				local Card, CC, CS = MakeCard(40)
				local Lbl = Instance.new("TextLabel")
				Lbl.Parent = Card
				Lbl.BackgroundTransparency = 1
				Lbl.Position = UDim2.new(0, 14, 0, 0)
				Lbl.Size = UDim2.new(0, 100, 1, 0)
				Lbl.Font = Enum.Font.GothamSemibold
				Lbl.Text = textboxName
				Lbl.TextColor3 = themeList.TextPrimary
				Lbl.TextSize = 13
				Lbl.TextXAlignment = Enum.TextXAlignment.Left
				local InputBg = Instance.new("Frame")
				InputBg.Parent = Card
				InputBg.BackgroundColor3 = themeList.Background
				InputBg.BorderSizePixel = 0
				InputBg.Position = UDim2.new(0, 118, 0.5, -11)
				InputBg.Size = UDim2.new(1, -132, 0, 22)
				local IBC = Instance.new("UICorner")
				IBC.CornerRadius = UDim.new(0, 5)
				IBC.Parent = InputBg
				local IBS = Instance.new("UIStroke")
				IBS.Color = themeList.BorderDim
				IBS.Thickness = 1
				IBS.Parent = InputBg
				local Box = Instance.new("TextBox")
				Box.Parent = InputBg
				Box.BackgroundTransparency = 1
				Box.Size = UDim2.new(1,-8,1,0)
				Box.Position = UDim2.new(0,5,0,0)
				Box.Font = Enum.Font.Gotham
				Box.PlaceholderText = "Type here..."
				Box.PlaceholderColor3 = themeList.TextSecondary
				Box.Text = ""
				Box.TextColor3 = themeList.TextPrimary
				Box.TextSize = 12
				Box.ClearTextOnFocus = false
				Box.Focused:Connect(function()
					Tween(IBS, {Color = themeList.Primary, Transparency = 0.3}, 0.15)
				end)
				Box.FocusLost:Connect(function(enter)
					Tween(IBS, {Color = themeList.BorderDim, Transparency = 0}, 0.15)
					if enter then callback(Box.Text) end
				end)
				Card.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
				end)
				Card.MouseLeave:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.Card}, 0.12)
					Tween(CS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.6) do
						Card.BackgroundColor3 = themeList.Card
						Lbl.TextColor3 = themeList.TextPrimary
						Box.TextColor3 = themeList.TextPrimary
						CS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
			end
			-- ── LABEL ────────────────────────────────────────────────
			function Elements:NewLabel(labelText)
				labelText = labelText or "Label"
				local Card, CC, CS = MakeCard(34)
				Card.BackgroundTransparency = 0.5
				local Lbl = Instance.new("TextLabel")
				Lbl.Parent = Card
				Lbl.BackgroundTransparency = 1
				Lbl.Position = UDim2.new(0, 14, 0, 0)
				Lbl.Size = UDim2.new(1, -20, 1, 0)
				Lbl.Font = Enum.Font.Gotham
				Lbl.Text = "  " .. labelText
				Lbl.TextColor3 = themeList.TextSecondary
				Lbl.TextSize = 13
				Lbl.TextXAlignment = Enum.TextXAlignment.Left
				coroutine.wrap(function()
					while wait(0.6) do
						Card.BackgroundColor3 = themeList.Card
						Lbl.TextColor3 = themeList.TextSecondary
						CS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
				local LF = {}
				function LF:UpdateLabel(t) Lbl.Text = "  " .. t end
				return LF
			end
			-- ── DROPDOWN ─────────────────────────────────────────────
			function Elements:NewDropdown(dropName, dropInfo, list, callback)
				dropName = dropName or "Dropdown"
				list = list or {}
				callback = callback or function() end
				local opened = false
				local DropWrap = Instance.new("Frame")
				DropWrap.Name = "Dropdown"
				DropWrap.Parent = SContent
				DropWrap.BackgroundTransparency = 1
				DropWrap.ClipsDescendants = true
				DropWrap.Size = UDim2.new(1, 0, 0, 40)
				local DLayout = Instance.new("UIListLayout")
				DLayout.Parent = DropWrap
				DLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DLayout.Padding = UDim.new(0, 3)
				-- Header card
				local DHead = Instance.new("TextButton")
				DHead.Parent = DropWrap
				DHead.BackgroundColor3 = themeList.Card
				DHead.BorderSizePixel = 0
				DHead.Size = UDim2.new(1, 0, 0, 40)
				DHead.AutoButtonColor = false
				DHead.Text = ""
				local DHC = Instance.new("UICorner")
				DHC.CornerRadius = UDim.new(0, 7)
				DHC.Parent = DHead
				local DHS = Instance.new("UIStroke")
				DHS.Color = themeList.BorderDim
				DHS.Thickness = 1
				DHS.Parent = DHead
				local DLbl = Instance.new("TextLabel")
				DLbl.Parent = DHead
				DLbl.BackgroundTransparency = 1
				DLbl.Position = UDim2.new(0, 14, 0, 0)
				DLbl.Size = UDim2.new(1, -40, 1, 0)
				DLbl.Font = Enum.Font.GothamSemibold
				DLbl.Text = dropName
				DLbl.TextColor3 = themeList.TextPrimary
				DLbl.TextSize = 13
				DLbl.TextXAlignment = Enum.TextXAlignment.Left
				local DArrow = Instance.new("TextLabel")
				DArrow.Parent = DHead
				DArrow.BackgroundTransparency = 1
				DArrow.Position = UDim2.new(1, -30, 0, 0)
				DArrow.Size = UDim2.new(0, 20, 1, 0)
				DArrow.Font = Enum.Font.GothamBold
				DArrow.Text = "▾"
				DArrow.TextColor3 = themeList.TextAccent
				DArrow.TextSize = 16
				DHead.MouseButton1Click:Connect(function()
					opened = not opened
					if opened then
						DropWrap.Size = UDim2.new(1,0,0, DLayout.AbsoluteContentSize.Y)
						Tween(DArrow, {Rotation = 180}, 0.2)
						Tween(DHS, {Color = themeList.Border, Transparency = 0.4}, 0.15)
					else
						DropWrap.Size = UDim2.new(1,0,0,40)
						Tween(DArrow, {Rotation = 0}, 0.2)
						Tween(DHS, {Color = themeList.BorderDim, Transparency = 0}, 0.15)
					end
					UpdateSection()
				end)
				DHead.MouseEnter:Connect(function()
					Tween(DHead, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(DHS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
				end)
				DHead.MouseLeave:Connect(function()
					Tween(DHead, {BackgroundColor3 = themeList.Card}, 0.12)
					if not opened then Tween(DHS, {Color = themeList.BorderDim, Transparency = 0}, 0.12) end
				end)
				for _, option in pairs(list) do
					local Opt = Instance.new("TextButton")
					Opt.Name = "Option"
					Opt.Parent = DropWrap
					Opt.BackgroundColor3 = themeList.Card
					Opt.BackgroundTransparency = 0.3
					Opt.BorderSizePixel = 0
					Opt.Size = UDim2.new(1, 0, 0, 32)
					Opt.AutoButtonColor = false
					Opt.Font = Enum.Font.Gotham
					Opt.Text = "  " .. option
					Opt.TextColor3 = themeList.TextSecondary
					Opt.TextSize = 12
					Opt.TextXAlignment = Enum.TextXAlignment.Left
					local OC = Instance.new("UICorner")
					OC.CornerRadius = UDim.new(0, 6)
					OC.Parent = Opt
					local OS = Instance.new("UIStroke")
					OS.Color = themeList.BorderDim
					OS.Thickness = 1
					OS.Transparency = 0.5
					OS.Parent = Opt
					Opt.MouseButton1Click:Connect(function()
						DLbl.Text = option
						callback(option)
						opened = false
						DropWrap.Size = UDim2.new(1,0,0,40)
						Tween(DArrow, {Rotation = 0}, 0.2)
						Tween(DHS, {Color = themeList.BorderDim, Transparency = 0}, 0.15)
						UpdateSection()
					end)
					Opt.MouseEnter:Connect(function()
						Tween(Opt, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.1)
						Tween(OS, {Color = themeList.Border, Transparency = 0.4}, 0.1)
					end)
					Opt.MouseLeave:Connect(function()
						Tween(Opt, {BackgroundTransparency = 0.3, TextColor3 = themeList.TextSecondary}, 0.1)
						Tween(OS, {Color = themeList.BorderDim, Transparency = 0.5}, 0.1)
					end)
					coroutine.wrap(function()
						while wait(0.6) do
							Opt.BackgroundColor3 = themeList.Card
							OS.Color = themeList.BorderDim
						end
					end)()
				end
				coroutine.wrap(function()
					while wait(0.6) do
						DHead.BackgroundColor3 = themeList.Card
						DLbl.TextColor3 = themeList.TextPrimary
						DArrow.TextColor3 = themeList.TextAccent
						DHS.Color = themeList.BorderDim
					end
				end)()
				UpdateSection()
				local DF = {}
				function DF:Refresh(newList)
					for _, c in pairs(DropWrap:GetChildren()) do
						if c.Name == "Option" then c:Destroy() end
					end
					for _, option in pairs(newList) do
						local Opt = Instance.new("TextButton")
						Opt.Name = "Option"
						Opt.Parent = DropWrap
						Opt.BackgroundColor3 = themeList.Card
						Opt.BackgroundTransparency = 0.3
						Opt.BorderSizePixel = 0
						Opt.Size = UDim2.new(1,0,0,32)
						Opt.AutoButtonColor = false
						Opt.Font = Enum.Font.Gotham
						Opt.Text = "  " .. option
						Opt.TextColor3 = themeList.TextSecondary
						Opt.TextSize = 12
						Opt.TextXAlignment = Enum.TextXAlignment.Left
						local OC = Instance.new("UICorner")
						OC.CornerRadius = UDim.new(0,6)
						OC.Parent = Opt
						Opt.MouseButton1Click:Connect(function()
							DLbl.Text = option
							callback(option)
							opened = false
							DropWrap.Size = UDim2.new(1,0,0,40)
							Tween(DArrow, {Rotation=0}, 0.2)
							UpdateSection()
						end)
						Opt.MouseEnter:Connect(function()
							Tween(Opt, {BackgroundTransparency=0, TextColor3=themeList.TextAccent}, 0.1)
						end)
						Opt.MouseLeave:Connect(function()
							Tween(Opt, {BackgroundTransparency=0.3, TextColor3=themeList.TextSecondary}, 0.1)
						end)
					end
					if opened then DropWrap.Size = UDim2.new(1,0,0,DLayout.AbsoluteContentSize.Y) end
					UpdateSection()
				end
				return DF
			end
			UpdateSection()
			return Elements
		end
		return Sections
	end
	return Tabs
end
return BinaryUI
