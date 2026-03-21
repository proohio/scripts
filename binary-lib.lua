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
		Primary = Color3.fromRGB(0, 180, 255),
		PrimaryGlow = Color3.fromRGB(0, 210, 255),
		Background = Color3.fromRGB(4, 4, 6),
		Surface = Color3.fromRGB(8, 10, 15),
		SurfaceAlt = Color3.fromRGB(12, 15, 22),
		Element = Color3.fromRGB(14, 18, 28),
		ElementHover = Color3.fromRGB(18, 24, 38),
		Header = Color3.fromRGB(6, 7, 11),
		Border = Color3.fromRGB(0, 150, 220),
		TextPrimary = Color3.fromRGB(215, 235, 255),
		TextSecondary = Color3.fromRGB(90, 130, 170),
		TextAccent = Color3.fromRGB(0, 190, 255),
	},
	Midnight = {
		Primary = Color3.fromRGB(140, 80, 255),
		PrimaryGlow = Color3.fromRGB(170, 110, 255),
		Background = Color3.fromRGB(4, 4, 7),
		Surface = Color3.fromRGB(8, 8, 16),
		SurfaceAlt = Color3.fromRGB(12, 12, 24),
		Element = Color3.fromRGB(14, 14, 28),
		ElementHover = Color3.fromRGB(20, 18, 40),
		Header = Color3.fromRGB(6, 6, 12),
		Border = Color3.fromRGB(120, 60, 230),
		TextPrimary = Color3.fromRGB(225, 215, 255),
		TextSecondary = Color3.fromRGB(110, 90, 170),
		TextAccent = Color3.fromRGB(150, 90, 255),
	},
	Ember = {
		Primary = Color3.fromRGB(255, 85, 25),
		PrimaryGlow = Color3.fromRGB(255, 120, 55),
		Background = Color3.fromRGB(7, 4, 4),
		Surface = Color3.fromRGB(13, 9, 8),
		SurfaceAlt = Color3.fromRGB(18, 13, 11),
		Element = Color3.fromRGB(20, 15, 12),
		ElementHover = Color3.fromRGB(28, 20, 16),
		Header = Color3.fromRGB(9, 6, 5),
		Border = Color3.fromRGB(210, 75, 15),
		TextPrimary = Color3.fromRGB(255, 232, 215),
		TextSecondary = Color3.fromRGB(175, 115, 95),
		TextAccent = Color3.fromRGB(255, 115, 45),
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
		if inp.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = inp
		end
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
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = themeList.Background
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, -325, 0.5, -225)
	Main.Size = UDim2.new(0, 650, 0, 450)
	Main.ClipsDescendants = true
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = Main
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = themeList.Border
	MainStroke.Thickness = 1
	MainStroke.Transparency = 0.6
	MainStroke.Parent = Main
	Main.BackgroundTransparency = 1
	MainStroke.Transparency = 1
	Main.Position = UDim2.new(0.5, -325, 0.5, -215)
	Tween(Main, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -325, 0.5, -225)}, 0.35, Enum.EasingStyle.Quart)
	Tween(MainStroke, {Transparency = 0.6}, 0.35)
	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = Main
	Header.BackgroundColor3 = themeList.Header
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 48)
	Header.ZIndex = 5
	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.CornerRadius = UDim.new(0, 8)
	HeaderCorner.Parent = Header
	local HeaderCover = Instance.new("Frame")
	HeaderCover.BackgroundColor3 = themeList.Header
	HeaderCover.BorderSizePixel = 0
	HeaderCover.Position = UDim2.new(0, 0, 0.5, 0)
	HeaderCover.Size = UDim2.new(1, 0, 0.5, 0)
	HeaderCover.Parent = Header
	HeaderCover.ZIndex = 5
	local HeaderBottomLine = Instance.new("Frame")
	HeaderBottomLine.BackgroundColor3 = themeList.Border
	HeaderBottomLine.BackgroundTransparency = 0.5
	HeaderBottomLine.BorderSizePixel = 0
	HeaderBottomLine.Position = UDim2.new(0, 0, 1, -1)
	HeaderBottomLine.Size = UDim2.new(1, 0, 0, 1)
	HeaderBottomLine.Parent = Header
	HeaderBottomLine.ZIndex = 6
	EnableDragging(Header, Main)
	local Logo = Instance.new("ImageLabel")
	Logo.Name = "Logo"
	Logo.Parent = Header
	Logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BackgroundTransparency = 0
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0, 14, 0.5, -11)
	Logo.Size = UDim2.new(0, 22, 0, 22)
	Logo.Image = "rbxassetid://75637976565211"
	Logo.ImageColor3 = themeList.Primary
	Logo.ZIndex = 7
	local LogoCorner = Instance.new("UICorner")
	LogoCorner.CornerRadius = UDim.new(0, 4)
	LogoCorner.Parent = Logo
	coroutine.wrap(function()
		while true do
			Tween(Logo, {ImageColor3 = themeList.PrimaryGlow}, 1.5, Enum.EasingStyle.Sine)
			wait(1.5)
			Tween(Logo, {ImageColor3 = themeList.Primary}, 1.5, Enum.EasingStyle.Sine)
			wait(1.5)
		end
	end)()
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Header
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 44, 0, 0)
	Title.Size = UDim2.new(1, -170, 1, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = libraryName
	Title.TextColor3 = themeList.TextPrimary
	Title.TextSize = 15
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 7
	local function MakeWinBtn(xOffset, icon, hoverColor)
		local Btn = Instance.new("TextButton")
		Btn.Parent = Header
		Btn.BackgroundColor3 = themeList.Element
		Btn.BorderSizePixel = 0
		Btn.Position = UDim2.new(1, xOffset, 0.5, -10)
		Btn.Size = UDim2.new(0, 28, 0, 20)
		Btn.Font = Enum.Font.GothamBold
		Btn.Text = icon
		Btn.TextColor3 = themeList.TextSecondary
		Btn.TextSize = 13
		Btn.AutoButtonColor = false
		Btn.ZIndex = 7
		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 4)
		BtnCorner.Parent = Btn
		local BtnStroke = Instance.new("UIStroke")
		BtnStroke.Color = themeList.Border
		BtnStroke.Thickness = 1
		BtnStroke.Transparency = 0.75
		BtnStroke.Parent = Btn
		Btn.MouseEnter:Connect(function()
			Tween(Btn, {BackgroundColor3 = hoverColor, TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
			Tween(BtnStroke, {Transparency = 0.3}, 0.1)
		end)
		Btn.MouseLeave:Connect(function()
			Tween(Btn, {BackgroundColor3 = themeList.Element, TextColor3 = themeList.TextSecondary}, 0.1)
			Tween(BtnStroke, {Transparency = 0.75}, 0.1)
		end)
		return Btn
	end
	local minimized = false
	local MinBtn = MakeWinBtn(-64, "—", themeList.ElementHover)
	MinBtn.TextSize = 11
	MinBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			Tween(Main, {Size = UDim2.new(0, 650, 0, 48)}, 0.3, Enum.EasingStyle.Quart)
		else
			Tween(Main, {Size = UDim2.new(0, 650, 0, 450)}, 0.35, Enum.EasingStyle.Back)
		end
	end)
	local CloseBtn = MakeWinBtn(-28, "✕", Color3.fromRGB(185, 35, 35))
	CloseBtn.MouseButton1Click:Connect(function()
		Tween(Main, {BackgroundTransparency = 1, Position = UDim2.new(0.5, -325, 0.5, -215)}, 0.25, Enum.EasingStyle.Quart)
		Tween(MainStroke, {Transparency = 1}, 0.25)
		wait(0.28)
		ScreenGui:Destroy()
	end)
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Main
	Sidebar.BackgroundColor3 = themeList.Surface
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0, 48)
	Sidebar.Size = UDim2.new(0, 180, 1, -48)
	local SidebarCorner = Instance.new("UICorner")
	SidebarCorner.CornerRadius = UDim.new(0, 8)
	SidebarCorner.Parent = Sidebar
	local SidebarCover = Instance.new("Frame")
	SidebarCover.BackgroundColor3 = themeList.Surface
	SidebarCover.BorderSizePixel = 0
	SidebarCover.Position = UDim2.new(1, -8, 0, 0)
	SidebarCover.Size = UDim2.new(0, 8, 1, 0)
	SidebarCover.Parent = Sidebar
	local SidebarRightLine = Instance.new("Frame")
	SidebarRightLine.BackgroundColor3 = themeList.Border
	SidebarRightLine.BackgroundTransparency = 0.6
	SidebarRightLine.BorderSizePixel = 0
	SidebarRightLine.Position = UDim2.new(1, -1, 0, 0)
	SidebarRightLine.Size = UDim2.new(0, 1, 1, 0)
	SidebarRightLine.Parent = Sidebar
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Name = "TabContainer"
	TabContainer.Parent = Sidebar
	TabContainer.BackgroundTransparency = 1
	TabContainer.BorderSizePixel = 0
	TabContainer.Position = UDim2.new(0, 8, 0, 10)
	TabContainer.Size = UDim2.new(1, -16, 1, -20)
	TabContainer.ScrollBarThickness = 0
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.Parent = TabContainer
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 5)
	TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
	end)
	local MascotHolder = Instance.new("Frame")
	MascotHolder.Name = "MascotHolder"
	MascotHolder.Parent = Main
	MascotHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MascotHolder.BackgroundTransparency = 0
	MascotHolder.BorderSizePixel = 0
	MascotHolder.Position = UDim2.new(0, 0, 1, -90)
	MascotHolder.Size = UDim2.new(0, 180, 0, 90)
	MascotHolder.ZIndex = 10
	MascotHolder.ClipsDescendants = true
	local MascotCorner = Instance.new("UICorner")
	MascotCorner.CornerRadius = UDim.new(0, 8)
	MascotCorner.Parent = MascotHolder
	local MascotCoverTop = Instance.new("Frame")
	MascotCoverTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MascotCoverTop.BorderSizePixel = 0
	MascotCoverTop.Size = UDim2.new(1, 0, 0, 8)
	MascotCoverTop.ZIndex = 11
	MascotCoverTop.Parent = MascotHolder
	local MascotLine = Instance.new("Frame")
	MascotLine.BackgroundColor3 = themeList.Border
	MascotLine.BackgroundTransparency = 0.6
	MascotLine.BorderSizePixel = 0
	MascotLine.Position = UDim2.new(0, 0, 0, 0)
	MascotLine.Size = UDim2.new(1, 0, 0, 1)
	MascotLine.ZIndex = 12
	MascotLine.Parent = MascotHolder
	local Mascot = Instance.new("ImageLabel")
	Mascot.Name = "Mascot"
	Mascot.Parent = MascotHolder
	Mascot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Mascot.BackgroundTransparency = 0
	Mascot.BorderSizePixel = 0
	Mascot.Position = UDim2.new(0.5, -40, 0, 4)
	Mascot.Size = UDim2.new(0, 80, 0, 82)
	Mascot.Image = "rbxassetid://125348433159932"
	Mascot.ImageTransparency = 0
	Mascot.ScaleType = Enum.ScaleType.Fit
	Mascot.ZIndex = 13
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "Content"
	ContentFrame.Parent = Main
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Position = UDim2.new(0, 185, 0, 55)
	ContentFrame.Size = UDim2.new(1, -193, 1, -63)
	local Pages = Instance.new("Folder")
	Pages.Name = "Pages"
	Pages.Parent = ContentFrame
	coroutine.wrap(function()
		while wait(0.5) do
			Main.BackgroundColor3 = themeList.Background
			Header.BackgroundColor3 = themeList.Header
			HeaderCover.BackgroundColor3 = themeList.Header
			Sidebar.BackgroundColor3 = themeList.Surface
			SidebarCover.BackgroundColor3 = themeList.Surface
			Title.TextColor3 = themeList.TextPrimary
			MainStroke.Color = themeList.Border
		end
	end)()
	function BinaryUI:ChangeColor(property, color)
		if property == "Background" then themeList.Background = color
		elseif property == "Primary" then themeList.Primary = color
		elseif property == "Header" then themeList.Header = color
		elseif property == "TextPrimary" then themeList.TextPrimary = color
		elseif property == "Element" then themeList.Element = color
		elseif property == "TextAccent" then themeList.TextAccent = color
		end
	end
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
		Page.ScrollBarThickness = 3
		Page.ScrollBarImageColor3 = themeList.Primary
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.Visible = false
		Page.BackgroundTransparency = 1
		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Parent = Page
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 8)
		local PagePadding = Instance.new("UIPadding")
		PagePadding.Parent = Page
		PagePadding.PaddingTop = UDim.new(0, 4)
		PagePadding.PaddingBottom = UDim.new(0, 8)
		PagePadding.PaddingRight = UDim.new(0, 4)
		local function UpdatePageSize()
			local cs = PageLayout.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, cs.X, 0, cs.Y + 12)}):Play()
		end
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = tabName
		TabBtn.Parent = TabContainer
		TabBtn.BackgroundColor3 = themeList.Element
		TabBtn.BackgroundTransparency = firstTab and 0 or 0.5
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 36)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.GothamSemibold
		TabBtn.Text = tabName
		TabBtn.TextColor3 = firstTab and themeList.TextAccent or themeList.TextSecondary
		TabBtn.TextSize = 13
		TabBtn.ZIndex = 3
		local TabBtnCorner = Instance.new("UICorner")
		TabBtnCorner.CornerRadius = UDim.new(0, 6)
		TabBtnCorner.Parent = TabBtn
		local ActiveBar = Instance.new("Frame")
		ActiveBar.Name = "ActiveBar"
		ActiveBar.Parent = TabBtn
		ActiveBar.BackgroundColor3 = themeList.Primary
		ActiveBar.BorderSizePixel = 0
		ActiveBar.Position = UDim2.new(0, 0, 0.15, 0)
		ActiveBar.Size = UDim2.new(0, 3, 0.7, 0)
		ActiveBar.BackgroundTransparency = firstTab and 0 or 1
		ActiveBar.ZIndex = 4
		local ActiveBarCorner = Instance.new("UICorner")
		ActiveBarCorner.CornerRadius = UDim.new(1, 0)
		ActiveBarCorner.Parent = ActiveBar
		if firstTab then
			Page.Visible = true
			currentPage = Page
			firstTab = false
			UpdatePageSize()
		end
		local function SwitchToPage()
			if currentPage and currentPage ~= Page then
				local old = currentPage
				Tween(old, {BackgroundTransparency = 1}, 0.15)
				wait(0.12)
				old.Visible = false
				old.BackgroundTransparency = 1
			end
			for _, btn in pairs(TabContainer:GetChildren()) do
				if btn:IsA("TextButton") then
					Tween(btn, {BackgroundTransparency = 0.5, TextColor3 = themeList.TextSecondary}, 0.2)
					local bar = btn:FindFirstChild("ActiveBar")
					if bar then Tween(bar, {BackgroundTransparency = 1}, 0.15) end
				end
			end
			Tween(TabBtn, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.2)
			Tween(ActiveBar, {BackgroundTransparency = 0}, 0.15)
			Page.BackgroundTransparency = 1
			Page.Visible = true
			currentPage = Page
			Tween(Page, {BackgroundTransparency = 1}, 0.2)
			UpdatePageSize()
		end
		TabBtn.MouseButton1Click:Connect(SwitchToPage)
		TabBtn.MouseEnter:Connect(function()
			if Page ~= currentPage then Tween(TabBtn, {BackgroundTransparency = 0.3}, 0.1) end
		end)
		TabBtn.MouseLeave:Connect(function()
			if Page ~= currentPage then Tween(TabBtn, {BackgroundTransparency = 0.5}, 0.1) end
		end)
		Page.ChildAdded:Connect(UpdatePageSize)
		Page.ChildRemoved:Connect(UpdatePageSize)
		coroutine.wrap(function()
			while wait(0.5) do
				TabBtn.BackgroundColor3 = themeList.Element
				Page.ScrollBarImageColor3 = themeList.Primary
			end
		end)()
		local Sections = {}
		function Sections:NewSection(sectionName, hidden)
			sectionName = sectionName or "Section"
			hidden = hidden or false
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Name = "Section"
			SectionFrame.Parent = Page
			SectionFrame.BackgroundTransparency = 1
			SectionFrame.Size = UDim2.new(1, 0, 0, 40)
			local SectionLayout = Instance.new("UIListLayout")
			SectionLayout.Parent = SectionFrame
			SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionLayout.Padding = UDim.new(0, 5)
			local SectionHeader = Instance.new("Frame")
			SectionHeader.Name = "Header"
			SectionHeader.Parent = SectionFrame
			SectionHeader.BackgroundColor3 = themeList.SurfaceAlt
			SectionHeader.BorderSizePixel = 0
			SectionHeader.Size = UDim2.new(1, 0, 0, 28)
			SectionHeader.Visible = not hidden
			local SHCorner = Instance.new("UICorner")
			SHCorner.CornerRadius = UDim.new(0, 5)
			SHCorner.Parent = SectionHeader
			local SHLeftBar = Instance.new("Frame")
			SHLeftBar.BackgroundColor3 = themeList.Primary
			SHLeftBar.BorderSizePixel = 0
			SHLeftBar.Position = UDim2.new(0, 0, 0.1, 0)
			SHLeftBar.Size = UDim2.new(0, 3, 0.8, 0)
			SHLeftBar.Parent = SectionHeader
			local SHLeftBarCorner = Instance.new("UICorner")
			SHLeftBarCorner.CornerRadius = UDim.new(1, 0)
			SHLeftBarCorner.Parent = SHLeftBar
			local SectionTitle = Instance.new("TextLabel")
			SectionTitle.Parent = SectionHeader
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Position = UDim2.new(0, 13, 0, 0)
			SectionTitle.Size = UDim2.new(1, -18, 1, 0)
			SectionTitle.Font = Enum.Font.GothamBold
			SectionTitle.Text = sectionName:upper()
			SectionTitle.TextColor3 = themeList.TextAccent
			SectionTitle.TextSize = 10
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			local SectionContent = Instance.new("Frame")
			SectionContent.Name = "Content"
			SectionContent.Parent = SectionFrame
			SectionContent.BackgroundTransparency = 1
			SectionContent.Size = UDim2.new(1, 0, 0, 0)
			local ContentLayout = Instance.new("UIListLayout")
			ContentLayout.Parent = SectionContent
			ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContentLayout.Padding = UDim.new(0, 5)
			local function UpdateSectionSize()
				local cs = ContentLayout.AbsoluteContentSize
				SectionContent.Size = UDim2.new(1, 0, 0, cs.Y)
				local total = SectionLayout.AbsoluteContentSize
				SectionFrame.Size = UDim2.new(1, 0, 0, total.Y)
				UpdatePageSize()
			end
			SectionContent.ChildAdded:Connect(UpdateSectionSize)
			SectionContent.ChildRemoved:Connect(UpdateSectionSize)
			coroutine.wrap(function()
				while wait(0.5) do
					SectionHeader.BackgroundColor3 = themeList.SurfaceAlt
					SectionTitle.TextColor3 = themeList.TextAccent
					SHLeftBar.BackgroundColor3 = themeList.Primary
				end
			end)()
			local function MakeElement(height)
				local Frame = Instance.new("Frame")
				Frame.Parent = SectionContent
				Frame.BackgroundColor3 = themeList.Element
				Frame.BorderSizePixel = 0
				Frame.Size = UDim2.new(1, 0, 0, height)
				local Corner = Instance.new("UICorner")
				Corner.CornerRadius = UDim.new(0, 6)
				Corner.Parent = Frame
				local Stroke = Instance.new("UIStroke")
				Stroke.Color = themeList.Border
				Stroke.Thickness = 1
				Stroke.Transparency = 0.85
				Stroke.Parent = Frame
				return Frame, Corner, Stroke
			end
			local Elements = {}
			function Elements:NewButton(buttonName, buttonInfo, callback)
				buttonName = buttonName or "Button"
				buttonInfo = buttonInfo or ""
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(40)
				local Ripple = Instance.new("Frame")
				Ripple.BackgroundColor3 = themeList.Primary
				Ripple.BackgroundTransparency = 1
				Ripple.BorderSizePixel = 0
				Ripple.Size = UDim2.new(1, 0, 1, 0)
				Ripple.Parent = Frame
				local RippleCorner = Instance.new("UICorner")
				RippleCorner.CornerRadius = UDim.new(0, 6)
				RippleCorner.Parent = Ripple
				local Btn = Instance.new("TextButton")
				Btn.Parent = Frame
				Btn.BackgroundTransparency = 1
				Btn.Size = UDim2.new(1, 0, 1, 0)
				Btn.Font = Enum.Font.GothamSemibold
				Btn.Text = buttonName
				Btn.TextColor3 = themeList.TextPrimary
				Btn.TextSize = 13
				Btn.AutoButtonColor = false
				Btn.ZIndex = 2
				Btn.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Btn.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.85}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				Btn.MouseButton1Click:Connect(function()
					Tween(Ripple, {BackgroundTransparency = 0.82}, 0.06)
					wait(0.06)
					Tween(Ripple, {BackgroundTransparency = 1}, 0.18)
					callback()
				end)
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						Btn.TextColor3 = themeList.TextPrimary
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
				local ButtonFunctions = {}
				function ButtonFunctions:UpdateButton(newText) Btn.Text = newText end
				return ButtonFunctions
			end
			function Elements:NewToggle(toggleName, toggleInfo, callback)
				toggleName = toggleName or "Toggle"
				callback = callback or function() end
				local toggled = false
				local Frame, Corner, Stroke = MakeElement(40)
				local ToggleLabel = Instance.new("TextLabel")
				ToggleLabel.Parent = Frame
				ToggleLabel.BackgroundTransparency = 1
				ToggleLabel.Position = UDim2.new(0, 14, 0, 0)
				ToggleLabel.Size = UDim2.new(1, -65, 1, 0)
				ToggleLabel.Font = Enum.Font.GothamSemibold
				ToggleLabel.Text = toggleName
				ToggleLabel.TextColor3 = themeList.TextPrimary
				ToggleLabel.TextSize = 13
				ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
				local Track = Instance.new("Frame")
				Track.Parent = Frame
				Track.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
				Track.BorderSizePixel = 0
				Track.Position = UDim2.new(1, -50, 0.5, -8)
				Track.Size = UDim2.new(0, 38, 0, 16)
				local TrackCorner = Instance.new("UICorner")
				TrackCorner.CornerRadius = UDim.new(1, 0)
				TrackCorner.Parent = Track
				local TrackStroke = Instance.new("UIStroke")
				TrackStroke.Color = Color3.fromRGB(45, 55, 75)
				TrackStroke.Thickness = 1
				TrackStroke.Parent = Track
				local Knob = Instance.new("Frame")
				Knob.Parent = Track
				Knob.BackgroundColor3 = Color3.fromRGB(120, 145, 185)
				Knob.BorderSizePixel = 0
				Knob.Position = UDim2.new(0, 2, 0.5, -6)
				Knob.Size = UDim2.new(0, 12, 0, 12)
				local KnobCorner = Instance.new("UICorner")
				KnobCorner.CornerRadius = UDim.new(1, 0)
				KnobCorner.Parent = Knob
				local ClickBtn = Instance.new("TextButton")
				ClickBtn.Parent = Frame
				ClickBtn.BackgroundTransparency = 1
				ClickBtn.Size = UDim2.new(1, 0, 1, 0)
				ClickBtn.Text = ""
				ClickBtn.ZIndex = 3
				ClickBtn.MouseButton1Click:Connect(function()
					toggled = not toggled
					if toggled then
						Tween(Knob, {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = themeList.Primary}, 0.18, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = Color3.fromRGB(0, 45, 80)}, 0.18)
						Tween(TrackStroke, {Color = themeList.Primary}, 0.18)
						Tween(ToggleLabel, {TextColor3 = themeList.TextAccent}, 0.18)
					else
						Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(120, 145, 185)}, 0.18, Enum.EasingStyle.Back)
						Tween(Track, {BackgroundColor3 = Color3.fromRGB(25, 30, 45)}, 0.18)
						Tween(TrackStroke, {Color = Color3.fromRGB(45, 55, 75)}, 0.18)
						Tween(ToggleLabel, {TextColor3 = themeList.TextPrimary}, 0.18)
					end
					callback(toggled)
				end)
				ClickBtn.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				ClickBtn.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.85}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						if not toggled then ToggleLabel.TextColor3 = themeList.TextPrimary end
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
				local ToggleFunctions = {}
				function ToggleFunctions:UpdateToggle(newText, state)
					if newText then ToggleLabel.Text = newText end
					if state ~= nil then
						toggled = state
						if toggled then
							Knob.Position = UDim2.new(1, -14, 0.5, -6)
							Knob.BackgroundColor3 = themeList.Primary
							Track.BackgroundColor3 = Color3.fromRGB(0, 45, 80)
							TrackStroke.Color = themeList.Primary
							ToggleLabel.TextColor3 = themeList.TextAccent
						else
							Knob.Position = UDim2.new(0, 2, 0.5, -6)
							Knob.BackgroundColor3 = Color3.fromRGB(120, 145, 185)
							Track.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
							TrackStroke.Color = Color3.fromRGB(45, 55, 75)
							ToggleLabel.TextColor3 = themeList.TextPrimary
						end
						callback(toggled)
					end
				end
				return ToggleFunctions
			end
			function Elements:NewSlider(sliderName, sliderInfo, maxValue, minValue, callback)
				sliderName = sliderName or "Slider"
				maxValue = maxValue or 100
				minValue = minValue or 0
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(52)
				local SliderLabel = Instance.new("TextLabel")
				SliderLabel.Parent = Frame
				SliderLabel.BackgroundTransparency = 1
				SliderLabel.Position = UDim2.new(0, 14, 0, 5)
				SliderLabel.Size = UDim2.new(1, -80, 0, 18)
				SliderLabel.Font = Enum.Font.GothamSemibold
				SliderLabel.Text = sliderName
				SliderLabel.TextColor3 = themeList.TextPrimary
				SliderLabel.TextSize = 13
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
				local SliderValue = Instance.new("TextLabel")
				SliderValue.Parent = Frame
				SliderValue.BackgroundTransparency = 1
				SliderValue.Position = UDim2.new(1, -74, 0, 5)
				SliderValue.Size = UDim2.new(0, 60, 0, 18)
				SliderValue.Font = Enum.Font.GothamBold
				SliderValue.Text = tostring(minValue)
				SliderValue.TextColor3 = themeList.TextAccent
				SliderValue.TextSize = 13
				SliderValue.TextXAlignment = Enum.TextXAlignment.Right
				local TrackBg = Instance.new("Frame")
				TrackBg.Parent = Frame
				TrackBg.BackgroundColor3 = Color3.fromRGB(20, 26, 40)
				TrackBg.BorderSizePixel = 0
				TrackBg.Position = UDim2.new(0, 14, 1, -18)
				TrackBg.Size = UDim2.new(1, -28, 0, 5)
				local TCorner = Instance.new("UICorner")
				TCorner.CornerRadius = UDim.new(1, 0)
				TCorner.Parent = TrackBg
				local SliderFill = Instance.new("Frame")
				SliderFill.Parent = TrackBg
				SliderFill.BackgroundColor3 = themeList.Primary
				SliderFill.BorderSizePixel = 0
				SliderFill.Size = UDim2.new(0, 0, 1, 0)
				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(1, 0)
				FillCorner.Parent = SliderFill
				local SliderKnob = Instance.new("Frame")
				SliderKnob.Parent = TrackBg
				SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderKnob.BorderSizePixel = 0
				SliderKnob.Position = UDim2.new(0, -5, 0.5, -5)
				SliderKnob.Size = UDim2.new(0, 10, 0, 10)
				SliderKnob.ZIndex = 2
				local SKCorner = Instance.new("UICorner")
				SKCorner.CornerRadius = UDim.new(1, 0)
				SKCorner.Parent = SliderKnob
				local HitBox = Instance.new("TextButton")
				HitBox.Parent = TrackBg
				HitBox.BackgroundTransparency = 1
				HitBox.Size = UDim2.new(1, 0, 5, 0)
				HitBox.Position = UDim2.new(0, 0, -2, 0)
				HitBox.Text = ""
				HitBox.ZIndex = 4
				local dragging = false
				HitBox.MouseButton1Down:Connect(function() dragging = true end)
				UserInputService.InputEnded:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
				end)
				UserInputService.InputChanged:Connect(function(inp)
					if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
						local pct = math.clamp((inp.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
						local val = math.floor(minValue + (maxValue - minValue) * pct)
						SliderFill.Size = UDim2.new(pct, 0, 1, 0)
						SliderKnob.Position = UDim2.new(pct, -5, 0.5, -5)
						SliderValue.Text = tostring(val)
						callback(val)
					end
				end)
				Frame.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Frame.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.85}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						SliderLabel.TextColor3 = themeList.TextPrimary
						SliderValue.TextColor3 = themeList.TextAccent
						SliderFill.BackgroundColor3 = themeList.Primary
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
			end
			function Elements:NewTextBox(textboxName, textboxInfo, callback)
				textboxName = textboxName or "TextBox"
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(40)
				local TextBoxLabel = Instance.new("TextLabel")
				TextBoxLabel.Parent = Frame
				TextBoxLabel.BackgroundTransparency = 1
				TextBoxLabel.Position = UDim2.new(0, 14, 0, 0)
				TextBoxLabel.Size = UDim2.new(0, 105, 1, 0)
				TextBoxLabel.Font = Enum.Font.GothamSemibold
				TextBoxLabel.Text = textboxName
				TextBoxLabel.TextColor3 = themeList.TextPrimary
				TextBoxLabel.TextSize = 13
				TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
				local BoxBg = Instance.new("Frame")
				BoxBg.Parent = Frame
				BoxBg.BackgroundColor3 = themeList.Background
				BoxBg.BorderSizePixel = 0
				BoxBg.Position = UDim2.new(0, 122, 0.5, -11)
				BoxBg.Size = UDim2.new(1, -136, 0, 22)
				local BoxCorner = Instance.new("UICorner")
				BoxCorner.CornerRadius = UDim.new(0, 4)
				BoxCorner.Parent = BoxBg
				local BoxStroke = Instance.new("UIStroke")
				BoxStroke.Color = themeList.Border
				BoxStroke.Thickness = 1
				BoxStroke.Transparency = 0.75
				BoxStroke.Parent = BoxBg
				local TextBox = Instance.new("TextBox")
				TextBox.Parent = BoxBg
				TextBox.BackgroundTransparency = 1
				TextBox.Size = UDim2.new(1, -10, 1, 0)
				TextBox.Position = UDim2.new(0, 6, 0, 0)
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderText = "Type here..."
				TextBox.PlaceholderColor3 = themeList.TextSecondary
				TextBox.Text = ""
				TextBox.TextColor3 = themeList.TextPrimary
				TextBox.TextSize = 12
				TextBox.ClearTextOnFocus = false
				TextBox.Focused:Connect(function()
					Tween(BoxStroke, {Transparency = 0.2, Color = themeList.Primary}, 0.15)
				end)
				TextBox.FocusLost:Connect(function(enter)
					Tween(BoxStroke, {Transparency = 0.75, Color = themeList.Border}, 0.15)
					if enter then callback(TextBox.Text) end
				end)
				Frame.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Frame.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.85}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						TextBoxLabel.TextColor3 = themeList.TextPrimary
						TextBox.TextColor3 = themeList.TextPrimary
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
			end
			function Elements:NewLabel(labelText)
				labelText = labelText or "Label"
				local Frame, Corner, Stroke = MakeElement(34)
				Frame.BackgroundTransparency = 0.5
				local Label = Instance.new("TextLabel")
				Label.Parent = Frame
				Label.BackgroundTransparency = 1
				Label.Position = UDim2.new(0, 14, 0, 0)
				Label.Size = UDim2.new(1, -20, 1, 0)
				Label.Font = Enum.Font.Gotham
				Label.Text = "  " .. labelText
				Label.TextColor3 = themeList.TextSecondary
				Label.TextSize = 13
				Label.TextXAlignment = Enum.TextXAlignment.Left
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						Label.TextColor3 = themeList.TextSecondary
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
				local LabelFunctions = {}
				function LabelFunctions:UpdateLabel(newText) Label.Text = "  " .. newText end
				return LabelFunctions
			end
			function Elements:NewDropdown(dropName, dropInfo, list, callback)
				dropName = dropName or "Dropdown"
				list = list or {}
				callback = callback or function() end
				local opened = false
				local DropFrame = Instance.new("Frame")
				DropFrame.Name = "Dropdown"
				DropFrame.Parent = SectionContent
				DropFrame.BackgroundTransparency = 1
				DropFrame.ClipsDescendants = true
				DropFrame.Size = UDim2.new(1, 0, 0, 40)
				local DropLayout = Instance.new("UIListLayout")
				DropLayout.Parent = DropFrame
				DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropLayout.Padding = UDim.new(0, 3)
				local DropHeader = Instance.new("TextButton")
				DropHeader.Name = "Header"
				DropHeader.Parent = DropFrame
				DropHeader.BackgroundColor3 = themeList.Element
				DropHeader.BorderSizePixel = 0
				DropHeader.Size = UDim2.new(1, 0, 0, 40)
				DropHeader.AutoButtonColor = false
				DropHeader.Text = ""
				local HeaderCornerDrop = Instance.new("UICorner")
				HeaderCornerDrop.CornerRadius = UDim.new(0, 6)
				HeaderCornerDrop.Parent = DropHeader
				local HeaderStroke = Instance.new("UIStroke")
				HeaderStroke.Parent = DropHeader
				HeaderStroke.Color = themeList.Border
				HeaderStroke.Thickness = 1
				HeaderStroke.Transparency = 0.85
				local DropLabel = Instance.new("TextLabel")
				DropLabel.Parent = DropHeader
				DropLabel.BackgroundTransparency = 1
				DropLabel.Position = UDim2.new(0, 14, 0, 0)
				DropLabel.Size = UDim2.new(1, -40, 1, 0)
				DropLabel.Font = Enum.Font.GothamSemibold
				DropLabel.Text = dropName
				DropLabel.TextColor3 = themeList.TextPrimary
				DropLabel.TextSize = 13
				DropLabel.TextXAlignment = Enum.TextXAlignment.Left
				local DropArrow = Instance.new("TextLabel")
				DropArrow.Parent = DropHeader
				DropArrow.BackgroundTransparency = 1
				DropArrow.Position = UDim2.new(1, -28, 0, 0)
				DropArrow.Size = UDim2.new(0, 18, 1, 0)
				DropArrow.Font = Enum.Font.GothamBold
				DropArrow.Text = "▾"
				DropArrow.TextColor3 = themeList.TextAccent
				DropArrow.TextSize = 14
				DropHeader.MouseButton1Click:Connect(function()
					opened = not opened
					if opened then
						DropFrame.Size = UDim2.new(1, 0, 0, DropLayout.AbsoluteContentSize.Y)
						Tween(DropArrow, {Rotation = 180}, 0.18)
						Tween(HeaderStroke, {Transparency = 0.4}, 0.15)
					else
						DropFrame.Size = UDim2.new(1, 0, 0, 40)
						Tween(DropArrow, {Rotation = 0}, 0.18)
						Tween(HeaderStroke, {Transparency = 0.85}, 0.15)
					end
					UpdateSectionSize()
				end)
				DropHeader.MouseEnter:Connect(function()
					Tween(DropHeader, {BackgroundColor3 = themeList.ElementHover}, 0.12)
					Tween(HeaderStroke, {Transparency = 0.5}, 0.12)
				end)
				DropHeader.MouseLeave:Connect(function()
					Tween(DropHeader, {BackgroundColor3 = themeList.Element}, 0.12)
					if not opened then Tween(HeaderStroke, {Transparency = 0.85}, 0.12) end
				end)
				for i, option in pairs(list) do
					local Option = Instance.new("TextButton")
					Option.Name = "Option"
					Option.Parent = DropFrame
					Option.BackgroundColor3 = themeList.Element
					Option.BackgroundTransparency = 0.25
					Option.BorderSizePixel = 0
					Option.Size = UDim2.new(1, 0, 0, 32)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.Gotham
					Option.Text = "  " .. option
					Option.TextColor3 = themeList.TextPrimary
					Option.TextSize = 12
					Option.TextXAlignment = Enum.TextXAlignment.Left
					local OptionCorner = Instance.new("UICorner")
					OptionCorner.CornerRadius = UDim.new(0, 5)
					OptionCorner.Parent = Option
					local OptionStroke = Instance.new("UIStroke")
					OptionStroke.Parent = Option
					OptionStroke.Color = themeList.Border
					OptionStroke.Thickness = 1
					OptionStroke.Transparency = 0.93
					Option.MouseButton1Click:Connect(function()
						DropLabel.Text = option
						callback(option)
						opened = false
						DropFrame.Size = UDim2.new(1, 0, 0, 40)
						Tween(DropArrow, {Rotation = 0}, 0.18)
						Tween(HeaderStroke, {Transparency = 0.85}, 0.15)
						UpdateSectionSize()
					end)
					Option.MouseEnter:Connect(function()
						Tween(Option, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.1)
						Tween(OptionStroke, {Transparency = 0.6}, 0.1)
					end)
					Option.MouseLeave:Connect(function()
						Tween(Option, {BackgroundTransparency = 0.25, TextColor3 = themeList.TextPrimary}, 0.1)
						Tween(OptionStroke, {Transparency = 0.93}, 0.1)
					end)
					coroutine.wrap(function()
						while wait(0.5) do
							Option.BackgroundColor3 = themeList.Element
							Option.TextColor3 = themeList.TextPrimary
							OptionStroke.Color = themeList.Border
						end
					end)()
				end
				coroutine.wrap(function()
					while wait(0.5) do
						DropHeader.BackgroundColor3 = themeList.Element
						DropLabel.TextColor3 = themeList.TextPrimary
						DropArrow.TextColor3 = themeList.TextAccent
						HeaderStroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
				local DropFunctions = {}
				function DropFunctions:Refresh(newList)
					for _, child in pairs(DropFrame:GetChildren()) do
						if child.Name == "Option" then child:Destroy() end
					end
					for i, option in pairs(newList) do
						local Option = Instance.new("TextButton")
						Option.Name = "Option"
						Option.Parent = DropFrame
						Option.BackgroundColor3 = themeList.Element
						Option.BackgroundTransparency = 0.25
						Option.BorderSizePixel = 0
						Option.Size = UDim2.new(1, 0, 0, 32)
						Option.AutoButtonColor = false
						Option.Font = Enum.Font.Gotham
						Option.Text = "  " .. option
						Option.TextColor3 = themeList.TextPrimary
						Option.TextSize = 12
						Option.TextXAlignment = Enum.TextXAlignment.Left
						local OC = Instance.new("UICorner")
						OC.CornerRadius = UDim.new(0, 5)
						OC.Parent = Option
						Option.MouseButton1Click:Connect(function()
							DropLabel.Text = option
							callback(option)
							opened = false
							DropFrame.Size = UDim2.new(1, 0, 0, 40)
							Tween(DropArrow, {Rotation = 0}, 0.18)
							UpdateSectionSize()
						end)
						Option.MouseEnter:Connect(function()
							Tween(Option, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.1)
						end)
						Option.MouseLeave:Connect(function()
							Tween(Option, {BackgroundTransparency = 0.25, TextColor3 = themeList.TextPrimary}, 0.1)
						end)
					end
					if opened then
						DropFrame.Size = UDim2.new(1, 0, 0, DropLayout.AbsoluteContentSize.Y)
					end
					UpdateSectionSize()
				end
				return DropFunctions
			end
			UpdateSectionSize()
			return Elements
		end
		return Sections
	end
	return Tabs
end
return BinaryUI
