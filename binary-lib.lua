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
		Primary       = Color3.fromRGB(0, 170, 255),
		PrimaryDim    = Color3.fromRGB(0, 100, 185),
		PrimaryGlow   = Color3.fromRGB(90, 210, 255),
		Background    = Color3.fromRGB(0, 0, 0),
		Surface       = Color3.fromRGB(10, 12, 18),
		Card          = Color3.fromRGB(14, 17, 25),
		CardHover     = Color3.fromRGB(19, 23, 34),
		Sidebar       = Color3.fromRGB(7, 9, 14),
		Header        = Color3.fromRGB(0, 0, 0),
		Border        = Color3.fromRGB(0, 145, 215),
		BorderDim     = Color3.fromRGB(20, 30, 48),
		TextPrimary   = Color3.fromRGB(205, 228, 255),
		TextSecondary = Color3.fromRGB(75, 110, 158),
		TextAccent    = Color3.fromRGB(0, 180, 255),
		TabInactive   = Color3.fromRGB(60, 90, 130),
	},
	Midnight = {
		Primary       = Color3.fromRGB(138, 80, 255),
		PrimaryDim    = Color3.fromRGB(88, 45, 185),
		PrimaryGlow   = Color3.fromRGB(178, 125, 255),
		Background    = Color3.fromRGB(0, 0, 0),
		Surface       = Color3.fromRGB(10, 9, 16),
		Card          = Color3.fromRGB(14, 12, 22),
		CardHover     = Color3.fromRGB(19, 16, 30),
		Sidebar       = Color3.fromRGB(7, 6, 12),
		Header        = Color3.fromRGB(0, 0, 0),
		Border        = Color3.fromRGB(112, 58, 225),
		BorderDim     = Color3.fromRGB(28, 16, 52),
		TextPrimary   = Color3.fromRGB(220, 210, 255),
		TextSecondary = Color3.fromRGB(92, 72, 148),
		TextAccent    = Color3.fromRGB(158, 98, 255),
		TabInactive   = Color3.fromRGB(82, 62, 138),
	},
	Ember = {
		Primary       = Color3.fromRGB(255, 84, 24),
		PrimaryDim    = Color3.fromRGB(185, 50, 8),
		PrimaryGlow   = Color3.fromRGB(255, 134, 64),
		Background    = Color3.fromRGB(0, 0, 0),
		Surface       = Color3.fromRGB(14, 9, 7),
		Card          = Color3.fromRGB(19, 12, 9),
		CardHover     = Color3.fromRGB(25, 16, 12),
		Sidebar       = Color3.fromRGB(9, 6, 4),
		Header        = Color3.fromRGB(0, 0, 0),
		Border        = Color3.fromRGB(205, 70, 14),
		BorderDim     = Color3.fromRGB(44, 17, 7),
		TextPrimary   = Color3.fromRGB(255, 230, 210),
		TextSecondary = Color3.fromRGB(152, 88, 66),
		TextAccent    = Color3.fromRGB(255, 110, 40),
		TabInactive   = Color3.fromRGB(128, 70, 48),
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
	-- ── Main window ────────────────────────────────────────────────
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, -330, 0.5, -230)
	Main.Size = UDim2.new(0, 660, 0, 460)
	Main.ClipsDescendants = true
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 10)
	MainCorner.Parent = Main
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = themeList.Border
	MainStroke.Thickness = 1
	MainStroke.Transparency = 1
	MainStroke.Parent = Main
	-- Entrance animation: slide up + fade in + glow appears
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.5, -330, 0.5, -215)
	Tween(Main, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -330, 0.5, -230)}, 0.4, Enum.EasingStyle.Quint)
	delay(0.1, function() Tween(MainStroke, {Transparency = 0.5}, 0.5) end)
	-- ── Header ─────────────────────────────────────────────────────
	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = Main
	Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 48)
	Header.ZIndex = 10
	-- Bottom accent line on header
	local HeaderAccent = Instance.new("Frame")
	HeaderAccent.Parent = Header
	HeaderAccent.BackgroundColor3 = themeList.Primary
	HeaderAccent.BackgroundTransparency = 0.6
	HeaderAccent.BorderSizePixel = 0
	HeaderAccent.Position = UDim2.new(0, 0, 1, -1)
	HeaderAccent.Size = UDim2.new(1, 0, 0, 1)
	HeaderAccent.ZIndex = 11
	EnableDragging(Header, Main)
	-- Logo: plain image, black bg, NO stroke
	local LogoImg = Instance.new("ImageLabel")
	LogoImg.Parent = Header
	LogoImg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	LogoImg.BackgroundTransparency = 0
	LogoImg.BorderSizePixel = 0
	LogoImg.Position = UDim2.new(0, 14, 0.5, -12)
	LogoImg.Size = UDim2.new(0, 24, 0, 24)
	LogoImg.Image = "rbxassetid://75637976565211"
	LogoImg.ImageColor3 = themeList.Primary
	LogoImg.ZIndex = 12
	-- Logo pulse glow
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
	TitleLabel.Parent = Header
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.new(0, 46, 0, 0)
	TitleLabel.Size = UDim2.new(1, -280, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = libraryName
	TitleLabel.TextColor3 = themeList.TextPrimary
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.ZIndex = 11
	-- Mascot in header, right side, floated to the right of title
	local MascotImg = Instance.new("ImageLabel")
	MascotImg.Parent = Header
	MascotImg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MascotImg.BackgroundTransparency = 0
	MascotImg.BorderSizePixel = 0
	MascotImg.Position = UDim2.new(1, -180, 0.5, -22)
	MascotImg.Size = UDim2.new(0, 44, 0, 44)
	MascotImg.Image = "rbxassetid://125348433159932"
	MascotImg.ScaleType = Enum.ScaleType.Fit
	MascotImg.ZIndex = 12
	MascotImg.ImageTransparency = 0.1
	-- Mascot idle float animation
	coroutine.wrap(function()
		while true do
			Tween(MascotImg, {Position = UDim2.new(1, -180, 0.5, -25)}, 1.2, Enum.EasingStyle.Sine)
			wait(1.2)
			Tween(MascotImg, {Position = UDim2.new(1, -180, 0.5, -19)}, 1.2, Enum.EasingStyle.Sine)
			wait(1.2)
		end
	end)()
	-- Window control buttons (frames for X, line for minimize)
	local function MakeCtrlBtn(xOff, hoverColor)
		local Btn = Instance.new("TextButton")
		Btn.Parent = Header
		Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Btn.BackgroundTransparency = 0
		Btn.BorderSizePixel = 0
		Btn.Position = UDim2.new(1, xOff, 0.5, -10)
		Btn.Size = UDim2.new(0, 26, 0, 20)
		Btn.Text = ""
		Btn.AutoButtonColor = false
		Btn.ZIndex = 12
		local BC = Instance.new("UICorner")
		BC.CornerRadius = UDim.new(0, 5)
		BC.Parent = Btn
		local BS = Instance.new("UIStroke")
		BS.Color = themeList.BorderDim
		BS.Thickness = 1
		BS.Parent = Btn
		Btn.MouseEnter:Connect(function()
			Tween(Btn, {BackgroundColor3 = hoverColor}, 0.12)
			Tween(BS, {Color = themeList.Border, Transparency = 0.5}, 0.12)
		end)
		Btn.MouseLeave:Connect(function()
			Tween(Btn, {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}, 0.12)
			Tween(BS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
		end)
		return Btn
	end
	local minimized = false
	local MinBtn = MakeCtrlBtn(-60, Color3.fromRGB(18, 24, 36))
	-- Minus icon: one horizontal frame
	local MinLine = Instance.new("Frame")
	MinLine.Parent = MinBtn
	MinLine.BackgroundColor3 = themeList.TextSecondary
	MinLine.BorderSizePixel = 0
	MinLine.AnchorPoint = Vector2.new(0.5, 0.5)
	MinLine.Position = UDim2.new(0.5, 0, 0.5, 0)
	MinLine.Size = UDim2.new(0, 11, 0, 1)
	MinLine.ZIndex = 13
	local MLC = Instance.new("UICorner")
	MLC.CornerRadius = UDim.new(1, 0)
	MLC.Parent = MinLine
	MinBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			Tween(Main, {Size = UDim2.new(0, 660, 0, 48)}, 0.28, Enum.EasingStyle.Quart)
		else
			Tween(Main, {Size = UDim2.new(0, 660, 0, 460)}, 0.32, Enum.EasingStyle.Back)
		end
	end)
	local CloseBtn = MakeCtrlBtn(-28, Color3.fromRGB(155, 28, 28))
	-- X icon: two diagonal frames
	local XA = Instance.new("Frame")
	XA.Parent = CloseBtn
	XA.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
	XA.BorderSizePixel = 0
	XA.AnchorPoint = Vector2.new(0.5, 0.5)
	XA.Position = UDim2.new(0.5, 0, 0.5, 0)
	XA.Size = UDim2.new(0, 11, 0, 1)
	XA.Rotation = 45
	XA.ZIndex = 13
	local XAC = Instance.new("UICorner")
	XAC.CornerRadius = UDim.new(1, 0)
	XAC.Parent = XA
	local XB = Instance.new("Frame")
	XB.Parent = CloseBtn
	XB.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
	XB.BorderSizePixel = 0
	XB.AnchorPoint = Vector2.new(0.5, 0.5)
	XB.Position = UDim2.new(0.5, 0, 0.5, 0)
	XB.Size = UDim2.new(0, 11, 0, 1)
	XB.Rotation = -45
	XB.ZIndex = 13
	local XBC = Instance.new("UICorner")
	XBC.CornerRadius = UDim.new(1, 0)
	XBC.Parent = XB
	CloseBtn.MouseEnter:Connect(function()
		Tween(XA, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.12)
		Tween(XB, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.12)
	end)
	CloseBtn.MouseLeave:Connect(function()
		Tween(XA, {BackgroundColor3 = Color3.fromRGB(200, 70, 70)}, 0.12)
		Tween(XB, {BackgroundColor3 = Color3.fromRGB(200, 70, 70)}, 0.12)
	end)
	CloseBtn.MouseButton1Click:Connect(function()
		Tween(Main, {BackgroundTransparency = 1, Position = UDim2.new(0.5, -330, 0.5, -215)}, 0.25, Enum.EasingStyle.Quart)
		Tween(MainStroke, {Transparency = 1}, 0.25)
		wait(0.28)
		ScreenGui:Destroy()
	end)
	-- ── Body ───────────────────────────────────────────────────────
	local Body = Instance.new("Frame")
	Body.Name = "Body"
	Body.Parent = Main
	Body.BackgroundTransparency = 1
	Body.BorderSizePixel = 0
	Body.Position = UDim2.new(0, 0, 0, 48)
	Body.Size = UDim2.new(1, 0, 1, -48)
	-- ── Sidebar ────────────────────────────────────────────────────
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Body
	Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Sidebar.BorderSizePixel = 0
	Sidebar.Size = UDim2.new(0, 168, 1, 0)
	Sidebar.ZIndex = 2
	local SidebarSep = Instance.new("Frame")
	SidebarSep.Parent = Sidebar
	SidebarSep.BackgroundColor3 = themeList.BorderDim
	SidebarSep.BorderSizePixel = 0
	SidebarSep.Position = UDim2.new(1, -1, 0, 0)
	SidebarSep.Size = UDim2.new(0, 1, 1, 0)
	SidebarSep.ZIndex = 3
	local TabScroll = Instance.new("ScrollingFrame")
	TabScroll.Parent = Sidebar
	TabScroll.BackgroundTransparency = 1
	TabScroll.BorderSizePixel = 0
	TabScroll.Position = UDim2.new(0, 0, 0, 10)
	TabScroll.Size = UDim2.new(1, 0, 1, -10)
	TabScroll.ScrollBarThickness = 0
	TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	TabScroll.ZIndex = 3
	local TabPad = Instance.new("UIPadding")
	TabPad.Parent = TabScroll
	TabPad.PaddingLeft = UDim.new(0, 8)
	TabPad.PaddingRight = UDim.new(0, 8)
	TabPad.PaddingTop = UDim.new(0, 2)
	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Parent = TabScroll
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding = UDim.new(0, 3)
	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 12)
	end)
	-- ── Content area ───────────────────────────────────────────────
	local ContentPanel = Instance.new("Frame")
	ContentPanel.Name = "ContentPanel"
	ContentPanel.Parent = Body
	ContentPanel.BackgroundColor3 = themeList.Surface
	ContentPanel.BorderSizePixel = 0
	ContentPanel.Position = UDim2.new(0, 168, 0, 0)
	ContentPanel.Size = UDim2.new(1, -168, 1, 0)
	ContentPanel.ClipsDescendants = true
	local Pages = Instance.new("Folder")
	Pages.Name = "Pages"
	Pages.Parent = ContentPanel
	-- Theme ticker
	coroutine.wrap(function()
		while wait(0.6) do
			Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			MascotImg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			ContentPanel.BackgroundColor3 = themeList.Surface
			TitleLabel.TextColor3 = themeList.TextPrimary
			MainStroke.Color = themeList.Border
			HeaderAccent.BackgroundColor3 = themeList.Primary
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
	-- ══════════════════════════════════════════════════════════════
	local Tabs = {}
	local firstTab = true
	local currentPage = nil
	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		local Page = Instance.new("ScrollingFrame")
		Page.Name = tabName .. "_Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.ScrollBarThickness = 2
		Page.ScrollBarImageColor3 = themeList.Primary
		Page.ScrollBarImageTransparency = 0.5
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.Visible = false
		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Parent = Page
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 7)
		local PagePad = Instance.new("UIPadding")
		PagePad.Parent = Page
		PagePad.PaddingTop = UDim.new(0, 10)
		PagePad.PaddingBottom = UDim.new(0, 10)
		PagePad.PaddingLeft = UDim.new(0, 10)
		PagePad.PaddingRight = UDim.new(0, 10)
		local function UpdatePage()
			local cs = PageLayout.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, cs.Y + 20)}):Play()
		end
		-- Tab button
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = tabName
		TabBtn.Parent = TabScroll
		TabBtn.BackgroundColor3 = themeList.Card
		TabBtn.BackgroundTransparency = firstTab and 0 or 1
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 36)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.GothamSemibold
		TabBtn.Text = tabName
		TabBtn.TextColor3 = firstTab and themeList.TextAccent or themeList.TabInactive
		TabBtn.TextSize = 13
		TabBtn.ZIndex = 4
		local TBC = Instance.new("UICorner")
		TBC.CornerRadius = UDim.new(0, 6)
		TBC.Parent = TabBtn
		-- Left active bar
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
		if firstTab then
			Page.Visible = true
			currentPage = Page
			firstTab = false
			UpdatePage()
		end
		local function SelectTab()
			if currentPage == Page then return end
			if currentPage then currentPage.Visible = false end
			for _, b in pairs(TabScroll:GetChildren()) do
				if b:IsA("TextButton") then
					Tween(b, {BackgroundTransparency = 1, TextColor3 = themeList.TabInactive}, 0.18)
					local bar = b:FindFirstChild("Frame")
					if bar then Tween(bar, {BackgroundTransparency = 1}, 0.15) end
				end
			end
			Tween(TabBtn, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.2)
			Tween(TBBar, {BackgroundTransparency = 0}, 0.15)
			Page.Visible = true
			currentPage = Page
			UpdatePage()
		end
		TabBtn.MouseButton1Click:Connect(SelectTab)
		TabBtn.MouseEnter:Connect(function()
			if currentPage ~= Page then
				Tween(TabBtn, {BackgroundTransparency = 0.65, TextColor3 = themeList.TextSecondary}, 0.12)
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
			SLayout.Padding = UDim.new(0, 5)
			local SHead = Instance.new("Frame")
			SHead.Parent = SFrame
			SHead.BackgroundTransparency = 1
			SHead.Size = UDim2.new(1, 0, 0, 16)
			SHead.Visible = not hidden
			local SLabel = Instance.new("TextLabel")
			SLabel.Parent = SHead
			SLabel.BackgroundTransparency = 1
			SLabel.Position = UDim2.new(0, 4, 0, 0)
			SLabel.Size = UDim2.new(1, -8, 1, 0)
			SLabel.Font = Enum.Font.GothamBold
			SLabel.Text = sectionName:upper()
			SLabel.TextColor3 = themeList.TextAccent
			SLabel.TextSize = 10
			SLabel.TextXAlignment = Enum.TextXAlignment.Left
			SLabel.TextTransparency = 0.05
			local SContent = Instance.new("Frame")
			SContent.Name = "Content"
			SContent.Parent = SFrame
			SContent.BackgroundTransparency = 1
			SContent.Size = UDim2.new(1, 0, 0, 0)
			local CLayout = Instance.new("UIListLayout")
			CLayout.Parent = SContent
			CLayout.SortOrder = Enum.SortOrder.LayoutOrder
			CLayout.Padding = UDim.new(0, 4)
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
				end
			end)()
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
			function Elements:NewButton(buttonName, buttonInfo, callback)
				buttonName = buttonName or "Button"
				callback = callback or function() end
				local Card, CC, CS = MakeCard(40)
				local Rip = Instance.new("Frame")
				Rip.BackgroundColor3 = themeList.Primary
				Rip.BackgroundTransparency = 1
				Rip.BorderSizePixel = 0
				Rip.Size = UDim2.new(1, 0, 1, 0)
				Rip.Parent = Card
				local RC = Instance.new("UICorner")
				RC.CornerRadius = UDim.new(0, 7)
				RC.Parent = Rip
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
				Btn.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.55}, 0.12)
				end)
				Btn.MouseLeave:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.Card}, 0.12)
					Tween(CS, {Color = themeList.BorderDim, Transparency = 0}, 0.12)
				end)
				Btn.MouseButton1Click:Connect(function()
					Tween(Rip, {BackgroundTransparency = 0.84}, 0.06)
					wait(0.06)
					Tween(Rip, {BackgroundTransparency = 1}, 0.22)
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
			function Elements:NewToggle(toggleName, toggleInfo, callback)
				toggleName = toggleName or "Toggle"
				callback = callback or function() end
				local toggled = false
				local Card, CC, CS = MakeCard(40)
				local Lbl = Instance.new("TextLabel")
				Lbl.Parent = Card
				Lbl.BackgroundTransparency = 1
				Lbl.Position = UDim2.new(0, 14, 0, 0)
				Lbl.Size = UDim2.new(1, -65, 1, 0)
				Lbl.Font = Enum.Font.GothamSemibold
				Lbl.Text = toggleName
				Lbl.TextColor3 = themeList.TextPrimary
				Lbl.TextSize = 13
				Lbl.TextXAlignment = Enum.TextXAlignment.Left
				local Track = Instance.new("Frame")
				Track.Parent = Card
				Track.BackgroundColor3 = Color3.fromRGB(14, 18, 30)
				Track.BorderSizePixel = 0
				Track.Position = UDim2.new(1, -52, 0.5, -8)
				Track.Size = UDim2.new(0, 40, 0, 16)
				local TC = Instance.new("UICorner")
				TC.CornerRadius = UDim.new(1, 0)
				TC.Parent = Track
				local TS = Instance.new("UIStroke")
				TS.Color = Color3.fromRGB(35, 50, 78)
				TS.Thickness = 1
				TS.Parent = Track
				local Knob = Instance.new("Frame")
				Knob.Parent = Track
				Knob.BackgroundColor3 = Color3.fromRGB(85, 115, 162)
				Knob.BorderSizePixel = 0
				Knob.Position = UDim2.new(0, 2, 0.5, -6)
				Knob.Size = UDim2.new(0, 12, 0, 12)
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
						Tween(Knob, {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(238, 248, 255)}, 0.2, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = themeList.PrimaryDim}, 0.2)
						Tween(TS, {Color = themeList.Primary}, 0.2)
						Tween(Lbl, {TextColor3 = themeList.TextAccent}, 0.2)
					else
						Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(85, 115, 162)}, 0.2, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = Color3.fromRGB(14, 18, 30)}, 0.2)
						Tween(TS, {Color = Color3.fromRGB(35, 50, 78)}, 0.2)
						Tween(Lbl, {TextColor3 = themeList.TextPrimary}, 0.2)
					end
					callback(toggled)
				end)
				HitBtn.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.55}, 0.12)
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
							Knob.Position = UDim2.new(1, -14, 0.5, -6)
							Knob.BackgroundColor3 = Color3.fromRGB(238, 248, 255)
							Track.BackgroundColor3 = themeList.PrimaryDim
							TS.Color = themeList.Primary
							Lbl.TextColor3 = themeList.TextAccent
						else
							Knob.Position = UDim2.new(0, 2, 0.5, -6)
							Knob.BackgroundColor3 = Color3.fromRGB(85, 115, 162)
							Track.BackgroundColor3 = Color3.fromRGB(14, 18, 30)
							TS.Color = Color3.fromRGB(35, 50, 78)
							Lbl.TextColor3 = themeList.TextPrimary
						end
						callback(toggled)
					end
				end
				return TF
			end
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
				TrackBg.BackgroundColor3 = Color3.fromRGB(12, 17, 28)
				TrackBg.BorderSizePixel = 0
				TrackBg.Position = UDim2.new(0, 14, 1, -18)
				TrackBg.Size = UDim2.new(1, -28, 0, 5)
				local TrC = Instance.new("UICorner")
				TrC.CornerRadius = UDim.new(1, 0)
				TrC.Parent = TrackBg
				local Fill = Instance.new("Frame")
				Fill.Parent = TrackBg
				Fill.BackgroundColor3 = themeList.Primary
				Fill.BorderSizePixel = 0
				Fill.Size = UDim2.new(0, 0, 1, 0)
				local FC = Instance.new("UICorner")
				FC.CornerRadius = UDim.new(1, 0)
				FC.Parent = Fill
				local Dot = Instance.new("Frame")
				Dot.Parent = TrackBg
				Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dot.BorderSizePixel = 0
				Dot.Position = UDim2.new(0, -5, 0.5, -5)
				Dot.Size = UDim2.new(0, 10, 0, 10)
				Dot.ZIndex = 2
				local DC = Instance.new("UICorner")
				DC.CornerRadius = UDim.new(1, 0)
				DC.Parent = Dot
				local Hit = Instance.new("TextButton")
				Hit.Parent = TrackBg
				Hit.BackgroundTransparency = 1
				Hit.Size = UDim2.new(1, 0, 6, 0)
				Hit.Position = UDim2.new(0, 0, -2.5, 0)
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
						Fill.Size = UDim2.new(pct, 0, 1, 0)
						Dot.Position = UDim2.new(pct, -5, 0.5, -5)
						ValLbl.Text = tostring(val)
						callback(val)
					end
				end)
				Card.MouseEnter:Connect(function()
					Tween(Card, {BackgroundColor3 = themeList.CardHover}, 0.12)
					Tween(CS, {Color = themeList.Border, Transparency = 0.55}, 0.12)
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
				InputBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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
				Box.Size = UDim2.new(1, -8, 1, 0)
				Box.Position = UDim2.new(0, 5, 0, 0)
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
					Tween(CS, {Color = themeList.Border, Transparency = 0.55}, 0.12)
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
				DArrow.Position = UDim2.new(1, -28, 0, 0)
				DArrow.Size = UDim2.new(0, 18, 1, 0)
				DArrow.Font = Enum.Font.GothamBold
				DArrow.Text = "v"
				DArrow.TextColor3 = themeList.TextAccent
				DArrow.TextSize = 12
				DHead.MouseButton1Click:Connect(function()
					opened = not opened
					if opened then
						DropWrap.Size = UDim2.new(1, 0, 0, DLayout.AbsoluteContentSize.Y)
						Tween(DArrow, {Rotation = 180}, 0.2)
						Tween(DHS, {Color = themeList.Border, Transparency = 0.4}, 0.15)
					else
						DropWrap.Size = UDim2.new(1, 0, 0, 40)
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
					Opt.BackgroundTransparency = 0.25
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
					OS.Transparency = 0.4
					OS.Parent = Opt
					Opt.MouseButton1Click:Connect(function()
						DLbl.Text = option
						callback(option)
						opened = false
						DropWrap.Size = UDim2.new(1, 0, 0, 40)
						Tween(DArrow, {Rotation = 0}, 0.2)
						Tween(DHS, {Color = themeList.BorderDim, Transparency = 0}, 0.15)
						UpdateSection()
					end)
					Opt.MouseEnter:Connect(function()
						Tween(Opt, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.1)
						Tween(OS, {Color = themeList.Border, Transparency = 0.35}, 0.1)
					end)
					Opt.MouseLeave:Connect(function()
						Tween(Opt, {BackgroundTransparency = 0.25, TextColor3 = themeList.TextSecondary}, 0.1)
						Tween(OS, {Color = themeList.BorderDim, Transparency = 0.4}, 0.1)
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
						Opt.BackgroundTransparency = 0.25
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
						Opt.MouseButton1Click:Connect(function()
							DLbl.Text = option
							callback(option)
							opened = false
							DropWrap.Size = UDim2.new(1, 0, 0, 40)
							Tween(DArrow, {Rotation = 0}, 0.2)
							UpdateSection()
						end)
						Opt.MouseEnter:Connect(function()
							Tween(Opt, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.1)
						end)
						Opt.MouseLeave:Connect(function()
							Tween(Opt, {BackgroundTransparency = 0.25, TextColor3 = themeList.TextSecondary}, 0.1)
						end)
					end
					if opened then DropWrap.Size = UDim2.new(1, 0, 0, DLayout.AbsoluteContentSize.Y) end
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
