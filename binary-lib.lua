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
		Background = Color3.fromRGB(5, 5, 8),
		Surface = Color3.fromRGB(10, 12, 18),
		SurfaceAlt = Color3.fromRGB(14, 17, 25),
		Element = Color3.fromRGB(16, 20, 30),
		ElementHover = Color3.fromRGB(20, 26, 40),
		Header = Color3.fromRGB(7, 8, 13),
		Border = Color3.fromRGB(0, 160, 230),
		TextPrimary = Color3.fromRGB(220, 240, 255),
		TextSecondary = Color3.fromRGB(100, 140, 180),
		TextAccent = Color3.fromRGB(0, 200, 255),
	},
	Midnight = {
		Primary = Color3.fromRGB(140, 80, 255),
		PrimaryGlow = Color3.fromRGB(170, 110, 255),
		Background = Color3.fromRGB(5, 5, 8),
		Surface = Color3.fromRGB(10, 10, 18),
		SurfaceAlt = Color3.fromRGB(14, 14, 25),
		Element = Color3.fromRGB(16, 16, 30),
		ElementHover = Color3.fromRGB(22, 20, 42),
		Header = Color3.fromRGB(7, 7, 13),
		Border = Color3.fromRGB(130, 70, 240),
		TextPrimary = Color3.fromRGB(230, 220, 255),
		TextSecondary = Color3.fromRGB(120, 100, 180),
		TextAccent = Color3.fromRGB(160, 100, 255),
	},
	Ember = {
		Primary = Color3.fromRGB(255, 90, 30),
		PrimaryGlow = Color3.fromRGB(255, 130, 60),
		Background = Color3.fromRGB(8, 5, 5),
		Surface = Color3.fromRGB(14, 10, 10),
		SurfaceAlt = Color3.fromRGB(20, 14, 12),
		Element = Color3.fromRGB(22, 16, 14),
		ElementHover = Color3.fromRGB(30, 22, 18),
		Header = Color3.fromRGB(10, 7, 7),
		Border = Color3.fromRGB(220, 80, 20),
		TextPrimary = Color3.fromRGB(255, 235, 220),
		TextSecondary = Color3.fromRGB(180, 120, 100),
		TextAccent = Color3.fromRGB(255, 120, 50),
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
	if not themeList then
		themeList = themeStyles.Binary
	end
	if type(themeList) == "string" then
		themeList = themeStyles[themeList] or themeStyles.Binary
	end
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
	Main.Position = UDim2.new(0.5, -340, 0.5, -240)
	Main.Size = UDim2.new(0, 680, 0, 480)
	Main.ClipsDescendants = false
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 10)
	MainCorner.Parent = Main
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = themeList.Border
	MainStroke.Thickness = 1.5
	MainStroke.Transparency = 0.5
	MainStroke.Parent = Main
	local ScanLine = Instance.new("Frame")
	ScanLine.Parent = Main
	ScanLine.BackgroundColor3 = themeList.Primary
	ScanLine.BackgroundTransparency = 0.93
	ScanLine.BorderSizePixel = 0
	ScanLine.Size = UDim2.new(1, 0, 0, 2)
	ScanLine.Position = UDim2.new(0, 0, 0, 0)
	ScanLine.ZIndex = 100
	local scanRunning = true
	coroutine.wrap(function()
		while scanRunning do
			Tween(ScanLine, {Position = UDim2.new(0, 0, 1, -2)}, 3, Enum.EasingStyle.Linear)
			wait(3)
			ScanLine.Position = UDim2.new(0, 0, 0, 0)
			wait(0.1)
		end
	end)()
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.5, -340, 0.5, -260)
	Tween(Main, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -340, 0.5, -240)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = Main
	Header.BackgroundColor3 = themeList.Header
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 50)
	Header.ZIndex = 2
	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.CornerRadius = UDim.new(0, 10)
	HeaderCorner.Parent = Header
	local HeaderCover = Instance.new("Frame")
	HeaderCover.BackgroundColor3 = themeList.Header
	HeaderCover.BorderSizePixel = 0
	HeaderCover.Position = UDim2.new(0, 0, 0.6, 0)
	HeaderCover.Size = UDim2.new(1, 0, 0.4, 0)
	HeaderCover.Parent = Header
	local HeaderLine = Instance.new("Frame")
	HeaderLine.BackgroundColor3 = themeList.Primary
	HeaderLine.BackgroundTransparency = 0.6
	HeaderLine.BorderSizePixel = 0
	HeaderLine.Position = UDim2.new(0, 0, 1, -1)
	HeaderLine.Size = UDim2.new(1, 0, 0, 1)
	HeaderLine.Parent = Header
	EnableDragging(Header, Main)
	local Logo = Instance.new("ImageLabel")
	Logo.Name = "Logo"
	Logo.Parent = Header
	Logo.BackgroundTransparency = 1
	Logo.Position = UDim2.new(0, 12, 0.5, -13)
	Logo.Size = UDim2.new(0, 26, 0, 26)
	Logo.Image = "rbxassetid://75637976565211"
	Logo.ImageColor3 = themeList.Primary
	Logo.ZIndex = 3
	coroutine.wrap(function()
		while true do
			Tween(Logo, {ImageColor3 = themeList.PrimaryGlow}, 1.2, Enum.EasingStyle.Sine)
			wait(1.2)
			Tween(Logo, {ImageColor3 = themeList.Primary}, 1.2, Enum.EasingStyle.Sine)
			wait(1.2)
		end
	end)()
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Header
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 46, 0, 0)
	Title.Size = UDim2.new(0, 300, 1, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = libraryName
	Title.TextColor3 = themeList.TextPrimary
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 3
	local SubTitle = Instance.new("TextLabel")
	SubTitle.Name = "SubTitle"
	SubTitle.Parent = Header
	SubTitle.BackgroundTransparency = 1
	SubTitle.Position = UDim2.new(0, 46, 0.55, 0)
	SubTitle.Size = UDim2.new(0, 200, 0, 14)
	SubTitle.Font = Enum.Font.Gotham
	SubTitle.Text = "BINARY UI  •  v2.0"
	SubTitle.TextColor3 = themeList.TextAccent
	SubTitle.TextSize = 10
	SubTitle.TextXAlignment = Enum.TextXAlignment.Left
	SubTitle.TextTransparency = 0.2
	SubTitle.ZIndex = 3
	local function MakeWindowButton(offsetX, icon, bgNormal, bgHover)
		local Btn = Instance.new("TextButton")
		Btn.Parent = Header
		Btn.BackgroundColor3 = bgNormal
		Btn.BorderSizePixel = 0
		Btn.Position = UDim2.new(1, offsetX, 0.5, -11)
		Btn.Size = UDim2.new(0, 32, 0, 22)
		Btn.Font = Enum.Font.GothamBold
		Btn.Text = icon
		Btn.TextColor3 = themeList.TextPrimary
		Btn.TextSize = 16
		Btn.AutoButtonColor = false
		Btn.ZIndex = 5
		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 5)
		BtnCorner.Parent = Btn
		local BtnStroke = Instance.new("UIStroke")
		BtnStroke.Color = themeList.Border
		BtnStroke.Thickness = 1
		BtnStroke.Transparency = 0.7
		BtnStroke.Parent = Btn
		Btn.MouseEnter:Connect(function()
			Tween(Btn, {BackgroundColor3 = bgHover}, 0.12)
			Tween(BtnStroke, {Transparency = 0.3}, 0.12)
		end)
		Btn.MouseLeave:Connect(function()
			Tween(Btn, {BackgroundColor3 = bgNormal}, 0.12)
			Tween(BtnStroke, {Transparency = 0.7}, 0.12)
		end)
		return Btn, BtnStroke
	end
	local minimized = false
	local MinBtn = MakeWindowButton(-90, "−", themeList.Element, themeList.ElementHover)
	MinBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			Tween(Main, {Size = UDim2.new(0, 680, 0, 50)}, 0.3, Enum.EasingStyle.Quart)
		else
			Tween(Main, {Size = UDim2.new(0, 680, 0, 480)}, 0.35, Enum.EasingStyle.Back)
		end
	end)
	local CloseBtn = MakeWindowButton(-50, "✕", themeList.Element, Color3.fromRGB(200, 40, 40))
	CloseBtn.MouseButton1Click:Connect(function()
		scanRunning = false
		Tween(Main, {Size = UDim2.new(0, 680, 0, 0), BackgroundTransparency = 1}, 0.25, Enum.EasingStyle.Quart)
		wait(0.3)
		ScreenGui:Destroy()
	end)
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Main
	Sidebar.BackgroundColor3 = themeList.Surface
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0, 50)
	Sidebar.Size = UDim2.new(0, 190, 1, -50)
	local SidebarCorner = Instance.new("UICorner")
	SidebarCorner.CornerRadius = UDim.new(0, 10)
	SidebarCorner.Parent = Sidebar
	local SidebarCover = Instance.new("Frame")
	SidebarCover.BackgroundColor3 = themeList.Surface
	SidebarCover.BorderSizePixel = 0
	SidebarCover.Position = UDim2.new(1, -10, 0, 0)
	SidebarCover.Size = UDim2.new(0, 10, 1, 0)
	SidebarCover.Parent = Sidebar
	local SidebarLine = Instance.new("Frame")
	SidebarLine.BackgroundColor3 = themeList.Primary
	SidebarLine.BackgroundTransparency = 0.7
	SidebarLine.BorderSizePixel = 0
	SidebarLine.Position = UDim2.new(1, -1, 0, 0)
	SidebarLine.Size = UDim2.new(0, 1, 1, 0)
	SidebarLine.Parent = Sidebar
	local Mascot = Instance.new("ImageLabel")
	Mascot.Name = "Mascot"
	Mascot.Parent = Sidebar
	Mascot.BackgroundTransparency = 1
	Mascot.Position = UDim2.new(0.5, -35, 1, -80)
	Mascot.Size = UDim2.new(0, 70, 0, 70)
	Mascot.Image = "rbxassetid://125348433159932"
	Mascot.ImageTransparency = 0.3
	Mascot.ZIndex = 2
	local TabContainer = Instance.new("Frame")
	TabContainer.Name = "TabContainer"
	TabContainer.Parent = Sidebar
	TabContainer.BackgroundTransparency = 1
	TabContainer.Position = UDim2.new(0, 10, 0, 12)
	TabContainer.Size = UDim2.new(1, -20, 1, -90)
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.Parent = TabContainer
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 6)
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "Content"
	ContentFrame.Parent = Main
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Position = UDim2.new(0, 200, 0, 60)
	ContentFrame.Size = UDim2.new(1, -210, 1, -70)
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
		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Parent = Page
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 10)
		local PagePadding = Instance.new("UIPadding")
		PagePadding.Parent = Page
		PagePadding.PaddingTop = UDim.new(0, 4)
		PagePadding.PaddingBottom = UDim.new(0, 8)
		local function UpdatePageSize()
			local cs = PageLayout.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo.new(0.15), {CanvasSize = UDim2.new(0, cs.X, 0, cs.Y + 12)}):Play()
		end
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = tabName
		TabBtn.Parent = TabContainer
		TabBtn.BackgroundColor3 = themeList.Element
		TabBtn.BackgroundTransparency = firstTab and 0 or 0.4
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 38)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.GothamSemibold
		TabBtn.Text = tabName
		TabBtn.TextColor3 = firstTab and themeList.TextAccent or themeList.TextSecondary
		TabBtn.TextSize = 13
		TabBtn.ZIndex = 3
		local TabBtnCorner = Instance.new("UICorner")
		TabBtnCorner.CornerRadius = UDim.new(0, 7)
		TabBtnCorner.Parent = TabBtn
		local TabBtnStroke = Instance.new("UIStroke")
		TabBtnStroke.Color = themeList.Border
		TabBtnStroke.Thickness = 1
		TabBtnStroke.Transparency = firstTab and 0.5 or 1
		TabBtnStroke.Parent = TabBtn
		local ActiveBar = Instance.new("Frame")
		ActiveBar.Name = "ActiveBar"
		ActiveBar.Parent = TabBtn
		ActiveBar.BackgroundColor3 = themeList.Primary
		ActiveBar.BorderSizePixel = 0
		ActiveBar.Position = UDim2.new(0, 0, 0.2, 0)
		ActiveBar.Size = UDim2.new(0, 3, 0.6, 0)
		ActiveBar.BackgroundTransparency = firstTab and 0 or 1
		local ActiveBarCorner = Instance.new("UICorner")
		ActiveBarCorner.CornerRadius = UDim.new(1, 0)
		ActiveBarCorner.Parent = ActiveBar
		if firstTab then
			Page.Visible = true
			firstTab = false
			UpdatePageSize()
		end
		TabBtn.MouseButton1Click:Connect(function()
			for _, pg in pairs(Pages:GetChildren()) do
				pg.Visible = false
			end
			Page.Visible = true
			for _, btn in pairs(TabContainer:GetChildren()) do
				if btn:IsA("TextButton") then
					Tween(btn, {BackgroundTransparency = 0.4, TextColor3 = themeList.TextSecondary}, 0.2)
					local stroke = btn:FindFirstChildOfClass("UIStroke")
					if stroke then Tween(stroke, {Transparency = 1}, 0.2) end
					local bar = btn:FindFirstChild("ActiveBar")
					if bar then Tween(bar, {BackgroundTransparency = 1}, 0.2) end
				end
			end
			Tween(TabBtn, {BackgroundTransparency = 0, TextColor3 = themeList.TextAccent}, 0.2)
			Tween(TabBtnStroke, {Transparency = 0.5}, 0.2)
			Tween(ActiveBar, {BackgroundTransparency = 0}, 0.2)
			UpdatePageSize()
		end)
		TabBtn.MouseEnter:Connect(function()
			if not Page.Visible then Tween(TabBtn, {BackgroundTransparency = 0.2}, 0.1) end
		end)
		TabBtn.MouseLeave:Connect(function()
			if not Page.Visible then Tween(TabBtn, {BackgroundTransparency = 0.4}, 0.1) end
		end)
		Page.ChildAdded:Connect(UpdatePageSize)
		Page.ChildRemoved:Connect(UpdatePageSize)
		coroutine.wrap(function()
			while wait(0.5) do
				TabBtn.BackgroundColor3 = themeList.Element
				TabBtnStroke.Color = themeList.Border
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
			SectionLayout.Padding = UDim.new(0, 6)
			local SectionHeader = Instance.new("Frame")
			SectionHeader.Name = "Header"
			SectionHeader.Parent = SectionFrame
			SectionHeader.BackgroundColor3 = themeList.SurfaceAlt
			SectionHeader.BorderSizePixel = 0
			SectionHeader.Size = UDim2.new(1, 0, 0, 30)
			SectionHeader.Visible = not hidden
			local SHCorner = Instance.new("UICorner")
			SHCorner.CornerRadius = UDim.new(0, 6)
			SHCorner.Parent = SectionHeader
			local SHStroke = Instance.new("UIStroke")
			SHStroke.Color = themeList.Primary
			SHStroke.Thickness = 1
			SHStroke.Transparency = 0.85
			SHStroke.Parent = SectionHeader
			local SHAccent = Instance.new("Frame")
			SHAccent.BackgroundColor3 = themeList.Primary
			SHAccent.BorderSizePixel = 0
			SHAccent.Position = UDim2.new(0, 0, 0.15, 0)
			SHAccent.Size = UDim2.new(0, 3, 0.7, 0)
			SHAccent.Parent = SectionHeader
			local SHAccentCorner = Instance.new("UICorner")
			SHAccentCorner.CornerRadius = UDim.new(1, 0)
			SHAccentCorner.Parent = SHAccent
			local SectionTitle = Instance.new("TextLabel")
			SectionTitle.Parent = SectionHeader
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Position = UDim2.new(0, 14, 0, 0)
			SectionTitle.Size = UDim2.new(1, -20, 1, 0)
			SectionTitle.Font = Enum.Font.GothamBold
			SectionTitle.Text = sectionName:upper()
			SectionTitle.TextColor3 = themeList.TextAccent
			SectionTitle.TextSize = 11
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			SectionTitle.TextTransparency = 0.1
			local SectionContent = Instance.new("Frame")
			SectionContent.Name = "Content"
			SectionContent.Parent = SectionFrame
			SectionContent.BackgroundTransparency = 1
			SectionContent.Size = UDim2.new(1, 0, 0, 0)
			local ContentLayout = Instance.new("UIListLayout")
			ContentLayout.Parent = SectionContent
			ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContentLayout.Padding = UDim.new(0, 6)
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
					SHStroke.Color = themeList.Primary
				end
			end)()
			local function MakeElement(height)
				local Frame = Instance.new("Frame")
				Frame.Parent = SectionContent
				Frame.BackgroundColor3 = themeList.Element
				Frame.BorderSizePixel = 0
				Frame.Size = UDim2.new(1, 0, 0, height)
				local Corner = Instance.new("UICorner")
				Corner.CornerRadius = UDim.new(0, 7)
				Corner.Parent = Frame
				local Stroke = Instance.new("UIStroke")
				Stroke.Color = themeList.Border
				Stroke.Thickness = 1
				Stroke.Transparency = 0.88
				Stroke.Parent = Frame
				return Frame, Corner, Stroke
			end
			local Elements = {}
			function Elements:NewButton(buttonName, buttonInfo, callback)
				buttonName = buttonName or "Button"
				buttonInfo = buttonInfo or "Click this button"
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(42)
				local Highlight = Instance.new("Frame")
				Highlight.BackgroundColor3 = themeList.Primary
				Highlight.BackgroundTransparency = 1
				Highlight.BorderSizePixel = 0
				Highlight.Size = UDim2.new(1, 0, 1, 0)
				Highlight.Parent = Frame
				local HCorner = Instance.new("UICorner")
				HCorner.CornerRadius = UDim.new(0, 7)
				HCorner.Parent = Highlight
				local Btn = Instance.new("TextButton")
				Btn.Parent = Frame
				Btn.BackgroundTransparency = 1
				Btn.Size = UDim2.new(1, 0, 1, 0)
				Btn.Font = Enum.Font.GothamSemibold
				Btn.Text = buttonName
				Btn.TextColor3 = themeList.TextPrimary
				Btn.TextSize = 14
				Btn.AutoButtonColor = false
				Btn.ZIndex = 2
				Btn.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Btn.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.88}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				Btn.MouseButton1Click:Connect(function()
					Tween(Highlight, {BackgroundTransparency = 0.8}, 0.05)
					wait(0.05)
					Tween(Highlight, {BackgroundTransparency = 1}, 0.2)
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
				function ButtonFunctions:UpdateButton(newText)
					Btn.Text = newText
				end
				return ButtonFunctions
			end
			function Elements:NewToggle(toggleName, toggleInfo, callback)
				toggleName = toggleName or "Toggle"
				toggleInfo = toggleInfo or "Toggle something"
				callback = callback or function() end
				local toggled = false
				local Frame, Corner, Stroke = MakeElement(42)
				local ToggleLabel = Instance.new("TextLabel")
				ToggleLabel.Parent = Frame
				ToggleLabel.BackgroundTransparency = 1
				ToggleLabel.Position = UDim2.new(0, 14, 0, 0)
				ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
				ToggleLabel.Font = Enum.Font.GothamSemibold
				ToggleLabel.Text = toggleName
				ToggleLabel.TextColor3 = themeList.TextPrimary
				ToggleLabel.TextSize = 14
				ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
				local ToggleIndicator = Instance.new("Frame")
				ToggleIndicator.Parent = Frame
				ToggleIndicator.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
				ToggleIndicator.BorderSizePixel = 0
				ToggleIndicator.Position = UDim2.new(1, -52, 0.5, -9)
				ToggleIndicator.Size = UDim2.new(0, 40, 0, 18)
				local IndicatorCorner = Instance.new("UICorner")
				IndicatorCorner.CornerRadius = UDim.new(1, 0)
				IndicatorCorner.Parent = ToggleIndicator
				local TrackStroke = Instance.new("UIStroke")
				TrackStroke.Color = Color3.fromRGB(50, 60, 80)
				TrackStroke.Thickness = 1
				TrackStroke.Parent = ToggleIndicator
				local IndicatorCircle = Instance.new("Frame")
				IndicatorCircle.Parent = ToggleIndicator
				IndicatorCircle.BackgroundColor3 = Color3.fromRGB(140, 160, 200)
				IndicatorCircle.BorderSizePixel = 0
				IndicatorCircle.Position = UDim2.new(0, 2, 0.5, -7)
				IndicatorCircle.Size = UDim2.new(0, 14, 0, 14)
				local CircleCorner = Instance.new("UICorner")
				CircleCorner.CornerRadius = UDim.new(1, 0)
				CircleCorner.Parent = IndicatorCircle
				local ClickBtn = Instance.new("TextButton")
				ClickBtn.Parent = Frame
				ClickBtn.BackgroundTransparency = 1
				ClickBtn.Size = UDim2.new(1, 0, 1, 0)
				ClickBtn.Text = ""
				ClickBtn.ZIndex = 3
				ClickBtn.MouseButton1Click:Connect(function()
					toggled = not toggled
					if toggled then
						Tween(IndicatorCircle, {Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = themeList.Primary}, 0.2, Enum.EasingStyle.Back)
						Tween(ToggleIndicator, {BackgroundColor3 = Color3.fromRGB(0, 50, 90)}, 0.2)
						Tween(TrackStroke, {Color = themeList.Primary}, 0.2)
						Tween(ToggleLabel, {TextColor3 = themeList.TextAccent}, 0.2)
					else
						Tween(IndicatorCircle, {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(140, 160, 200)}, 0.2, Enum.EasingStyle.Back)
						Tween(ToggleIndicator, {BackgroundColor3 = Color3.fromRGB(30, 35, 50)}, 0.2)
						Tween(TrackStroke, {Color = Color3.fromRGB(50, 60, 80)}, 0.2)
						Tween(ToggleLabel, {TextColor3 = themeList.TextPrimary}, 0.2)
					end
					callback(toggled)
				end)
				ClickBtn.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				ClickBtn.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.88}, 0.12)
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
							IndicatorCircle.Position = UDim2.new(1, -16, 0.5, -7)
							ToggleIndicator.BackgroundColor3 = themeList.Primary
						else
							IndicatorCircle.Position = UDim2.new(0, 2, 0.5, -7)
							ToggleIndicator.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
						end
						callback(toggled)
					end
				end
				return ToggleFunctions
			end
			function Elements:NewSlider(sliderName, sliderInfo, maxValue, minValue, callback)
				sliderName = sliderName or "Slider"
				sliderInfo = sliderInfo or "Adjust value"
				maxValue = maxValue or 100
				minValue = minValue or 0
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(56)
				local SliderLabel = Instance.new("TextLabel")
				SliderLabel.Parent = Frame
				SliderLabel.BackgroundTransparency = 1
				SliderLabel.Position = UDim2.new(0, 14, 0, 6)
				SliderLabel.Size = UDim2.new(1, -90, 0, 18)
				SliderLabel.Font = Enum.Font.GothamSemibold
				SliderLabel.Text = sliderName
				SliderLabel.TextColor3 = themeList.TextPrimary
				SliderLabel.TextSize = 13
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
				local SliderValue = Instance.new("TextLabel")
				SliderValue.Parent = Frame
				SliderValue.BackgroundTransparency = 1
				SliderValue.Position = UDim2.new(1, -80, 0, 6)
				SliderValue.Size = UDim2.new(0, 70, 0, 18)
				SliderValue.Font = Enum.Font.GothamBold
				SliderValue.Text = tostring(minValue)
				SliderValue.TextColor3 = themeList.TextAccent
				SliderValue.TextSize = 13
				SliderValue.TextXAlignment = Enum.TextXAlignment.Right
				local SliderTrack = Instance.new("Frame")
				SliderTrack.Parent = Frame
				SliderTrack.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
				SliderTrack.BorderSizePixel = 0
				SliderTrack.Position = UDim2.new(0, 14, 1, -20)
				SliderTrack.Size = UDim2.new(1, -28, 0, 6)
				local TrackCorner = Instance.new("UICorner")
				TrackCorner.CornerRadius = UDim.new(1, 0)
				TrackCorner.Parent = SliderTrack
				local SliderFill = Instance.new("Frame")
				SliderFill.Parent = SliderTrack
				SliderFill.BackgroundColor3 = themeList.Primary
				SliderFill.BorderSizePixel = 0
				SliderFill.Size = UDim2.new(0, 0, 1, 0)
				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(1, 0)
				FillCorner.Parent = SliderFill
				local SliderKnob = Instance.new("Frame")
				SliderKnob.Parent = SliderTrack
				SliderKnob.BackgroundColor3 = themeList.Primary
				SliderKnob.BorderSizePixel = 0
				SliderKnob.Position = UDim2.new(0, -6, 0.5, -6)
				SliderKnob.Size = UDim2.new(0, 12, 0, 12)
				SliderKnob.ZIndex = 2
				local SKCorner = Instance.new("UICorner")
				SKCorner.CornerRadius = UDim.new(1, 0)
				SKCorner.Parent = SliderKnob
				local SliderButton = Instance.new("TextButton")
				SliderButton.Parent = SliderTrack
				SliderButton.BackgroundTransparency = 1
				SliderButton.Size = UDim2.new(1, 0, 4, 0)
				SliderButton.Position = UDim2.new(0, 0, -1.5, 0)
				SliderButton.Text = ""
				SliderButton.ZIndex = 4
				local dragging = false
				SliderButton.MouseButton1Down:Connect(function() dragging = true end)
				UserInputService.InputEnded:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
				end)
				UserInputService.InputChanged:Connect(function(inp)
					if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
						local pct = math.clamp((inp.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
						local val = math.floor(minValue + (maxValue - minValue) * pct)
						SliderFill.Size = UDim2.new(pct, 0, 1, 0)
						SliderKnob.Position = UDim2.new(pct, -6, 0.5, -6)
						SliderValue.Text = tostring(val)
						callback(val)
					end
				end)
				Frame.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Frame.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.88}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.Element}, 0.12)
				end)
				coroutine.wrap(function()
					while wait(0.5) do
						Frame.BackgroundColor3 = themeList.Element
						SliderLabel.TextColor3 = themeList.TextPrimary
						SliderValue.TextColor3 = themeList.TextAccent
						SliderFill.BackgroundColor3 = themeList.Primary
						SliderKnob.BackgroundColor3 = themeList.Primary
						Stroke.Color = themeList.Border
					end
				end)()
				UpdateSectionSize()
			end
			function Elements:NewTextBox(textboxName, textboxInfo, callback)
				textboxName = textboxName or "TextBox"
				textboxInfo = textboxInfo or "Enter text"
				callback = callback or function() end
				local Frame, Corner, Stroke = MakeElement(42)
				local TextBoxLabel = Instance.new("TextLabel")
				TextBoxLabel.Parent = Frame
				TextBoxLabel.BackgroundTransparency = 1
				TextBoxLabel.Position = UDim2.new(0, 14, 0, 0)
				TextBoxLabel.Size = UDim2.new(0, 110, 1, 0)
				TextBoxLabel.Font = Enum.Font.GothamSemibold
				TextBoxLabel.Text = textboxName
				TextBoxLabel.TextColor3 = themeList.TextPrimary
				TextBoxLabel.TextSize = 13
				TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
				local BoxBg = Instance.new("Frame")
				BoxBg.Parent = Frame
				BoxBg.BackgroundColor3 = themeList.Background
				BoxBg.BorderSizePixel = 0
				BoxBg.Position = UDim2.new(0, 128, 0.5, -12)
				BoxBg.Size = UDim2.new(1, -142, 0, 24)
				local BoxCorner = Instance.new("UICorner")
				BoxCorner.CornerRadius = UDim.new(0, 5)
				BoxCorner.Parent = BoxBg
				local BoxStroke = Instance.new("UIStroke")
				BoxStroke.Color = themeList.Border
				BoxStroke.Thickness = 1
				BoxStroke.Transparency = 0.8
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
					Tween(BoxStroke, {Transparency = 0.3, Color = themeList.Primary}, 0.15)
				end)
				TextBox.FocusLost:Connect(function(enter)
					Tween(BoxStroke, {Transparency = 0.8, Color = themeList.Border}, 0.15)
					if enter then callback(TextBox.Text) end
				end)
				Frame.MouseEnter:Connect(function()
					Tween(Stroke, {Transparency = 0.5}, 0.12)
					Tween(Frame, {BackgroundColor3 = themeList.ElementHover}, 0.12)
				end)
				Frame.MouseLeave:Connect(function()
					Tween(Stroke, {Transparency = 0.88}, 0.12)
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
				local Frame, Corner, Stroke = MakeElement(36)
				Frame.BackgroundTransparency = 0.4
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
				function LabelFunctions:UpdateLabel(newText)
					Label.Text = "  " .. newText
				end
				return LabelFunctions
			end
			function Elements:NewDropdown(dropName, dropInfo, list, callback)
				dropName = dropName or "Dropdown"
				dropInfo = dropInfo or "Select option"
				list = list or {}
				callback = callback or function() end
				local opened = false
				local DropFrame = Instance.new("Frame")
				DropFrame.Name = "Dropdown"
				DropFrame.Parent = SectionContent
				DropFrame.BackgroundTransparency = 1
				DropFrame.ClipsDescendants = true
				DropFrame.Size = UDim2.new(1, 0, 0, 42)
				local DropLayout = Instance.new("UIListLayout")
				DropLayout.Parent = DropFrame
				DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropLayout.Padding = UDim.new(0, 4)
				local DropHeader = Instance.new("TextButton")
				DropHeader.Name = "Header"
				DropHeader.Parent = DropFrame
				DropHeader.BackgroundColor3 = themeList.Element
				DropHeader.BorderSizePixel = 0
				DropHeader.Size = UDim2.new(1, 0, 0, 42)
				DropHeader.AutoButtonColor = false
				DropHeader.Text = ""
				local HeaderCornerDrop = Instance.new("UICorner")
				HeaderCornerDrop.CornerRadius = UDim.new(0, 7)
				HeaderCornerDrop.Parent = DropHeader
				local HeaderStroke = Instance.new("UIStroke")
				HeaderStroke.Parent = DropHeader
				HeaderStroke.Color = themeList.Border
				HeaderStroke.Thickness = 1
				HeaderStroke.Transparency = 0.88
				local DropLabel = Instance.new("TextLabel")
				DropLabel.Parent = DropHeader
				DropLabel.BackgroundTransparency = 1
				DropLabel.Position = UDim2.new(0, 14, 0, 0)
				DropLabel.Size = UDim2.new(1, -45, 1, 0)
				DropLabel.Font = Enum.Font.GothamSemibold
				DropLabel.Text = dropName
				DropLabel.TextColor3 = themeList.TextPrimary
				DropLabel.TextSize = 13
				DropLabel.TextXAlignment = Enum.TextXAlignment.Left
				local DropArrow = Instance.new("TextLabel")
				DropArrow.Parent = DropHeader
				DropArrow.BackgroundTransparency = 1
				DropArrow.Position = UDim2.new(1, -32, 0, 0)
				DropArrow.Size = UDim2.new(0, 22, 1, 0)
				DropArrow.Font = Enum.Font.GothamBold
				DropArrow.Text = "▼"
				DropArrow.TextColor3 = themeList.TextAccent
				DropArrow.TextSize = 11
				DropHeader.MouseButton1Click:Connect(function()
					opened = not opened
					if opened then
						DropFrame.Size = UDim2.new(1, 0, 0, DropLayout.AbsoluteContentSize.Y)
						Tween(DropArrow, {Rotation = 180}, 0.2)
						Tween(HeaderStroke, {Transparency = 0.5}, 0.15)
					else
						DropFrame.Size = UDim2.new(1, 0, 0, 42)
						Tween(DropArrow, {Rotation = 0}, 0.2)
						Tween(HeaderStroke, {Transparency = 0.88}, 0.15)
					end
					UpdateSectionSize()
				end)
				DropHeader.MouseEnter:Connect(function()
					Tween(DropHeader, {BackgroundColor3 = themeList.ElementHover}, 0.12)
					Tween(HeaderStroke, {Transparency = 0.5}, 0.12)
				end)
				DropHeader.MouseLeave:Connect(function()
					Tween(DropHeader, {BackgroundColor3 = themeList.Element}, 0.12)
					if not opened then Tween(HeaderStroke, {Transparency = 0.88}, 0.12) end
				end)
				for i, option in pairs(list) do
					local Option = Instance.new("TextButton")
					Option.Name = "Option"
					Option.Parent = DropFrame
					Option.BackgroundColor3 = themeList.Element
					Option.BackgroundTransparency = 0.3
					Option.BorderSizePixel = 0
					Option.Size = UDim2.new(1, 0, 0, 34)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.Gotham
					Option.Text = "  " .. option
					Option.TextColor3 = themeList.TextPrimary
					Option.TextSize = 12
					Option.TextXAlignment = Enum.TextXAlignment.Left
					local OptionCorner = Instance.new("UICorner")
					OptionCorner.CornerRadius = UDim.new(0, 6)
					OptionCorner.Parent = Option
					local OptionStroke = Instance.new("UIStroke")
					OptionStroke.Parent = Option
					OptionStroke.Color = themeList.Border
					OptionStroke.Thickness = 1
					OptionStroke.Transparency = 0.95
					Option.MouseButton1Click:Connect(function()
						DropLabel.Text = option
						callback(option)
						opened = false
						DropFrame.Size = UDim2.new(1, 0, 0, 42)
						DropArrow.Rotation = 0
						Tween(HeaderStroke, {Transparency = 0.88}, 0.15)
						UpdateSectionSize()
					end)
					Option.MouseEnter:Connect(function()
						Tween(Option, {BackgroundTransparency = 0}, 0.1)
						Tween(OptionStroke, {Transparency = 0.7}, 0.1)
					end)
					Option.MouseLeave:Connect(function()
						Tween(Option, {BackgroundTransparency = 0.3}, 0.1)
						Tween(OptionStroke, {Transparency = 0.95}, 0.1)
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
						Option.BackgroundTransparency = 0.3
						Option.BorderSizePixel = 0
						Option.Size = UDim2.new(1, 0, 0, 34)
						Option.AutoButtonColor = false
						Option.Font = Enum.Font.Gotham
						Option.Text = "  " .. option
						Option.TextColor3 = themeList.TextPrimary
						Option.TextSize = 12
						Option.TextXAlignment = Enum.TextXAlignment.Left
						local OptionCorner = Instance.new("UICorner")
						OptionCorner.CornerRadius = UDim.new(0, 6)
						OptionCorner.Parent = Option
						Option.MouseButton1Click:Connect(function()
							DropLabel.Text = option
							callback(option)
							opened = false
							DropFrame.Size = UDim2.new(1, 0, 0, 42)
							DropArrow.Rotation = 0
							UpdateSectionSize()
						end)
						Option.MouseEnter:Connect(function()
							Tween(Option, {BackgroundTransparency = 0}, 0.1)
						end)
						Option.MouseLeave:Connect(function()
							Tween(Option, {BackgroundTransparency = 0.3}, 0.1)
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
