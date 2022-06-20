local function callback(Text)
end
 
local NotificationBindable = Instance.new("BindableFunction")
NotificationBindable.OnInvoke = callback
 
game.StarterGui:SetCore("SendNotification", {
    Title = "yurr";
    Text = "0k baby";
    Duration = "1";
    Callback = NotificationBindable;
})

local function ChatSpy()
    local StarterGui = game:GetService("StarterGui")
    repeat wait() until StarterGui:GetCore("ChatWindowSize") ~= nil
    local chatWindowSize = StarterGui:GetCore("ChatWindowSize")
    StarterGui:SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.414965987, 0))
    enabled = true
	spyOnMyself = true
	public = false
	publicItalics = false
	privateProperties = {
		Color = Color3.fromRGB(87, 198, 235); 
		Font = Enum.Font.SourceSansBold;
		TextSize = 18;
	}
	local StarterGui = game:GetService("StarterGui")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
	local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	local instance = (_G.chatSpyInstance or 0) + 1
	_G.chatSpyInstance = instance

	local function onChatted(p,msg)
		if _G.chatSpyInstance == instance then
			if p==player and msg:lower():sub(1,4)=="/spy" then
				enabled = not enabled
				wait()
				privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
				StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
			elseif enabled and (spyOnMyself==true or p~=player) then
				msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				local hidden = true
				local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
					if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						hidden = false
					end
				end)
				wait(1)
				conn:Disconnect()
				if hidden and enabled then
					if public then
						saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
					else
						privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
						StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
					end
				end
			end
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end
	Players.PlayerAdded:Connect(function(p)
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end)
	privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
	StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
	if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end
	local chatFrame = player.PlayerGui.Chat.Frame
	chatFrame.ChatChannelParentFrame.Visible = true
	chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end
ChatSpy()



print([[

=================================COMBAT===============================
[1] camlock/cl - camlocks on player 
[2] uncamlock/uncl - uncamlocks player
[3] aimbot/target - aimlocks on player
[4] unaimbot/untarget - unaimlocks on player
[5] aimpart - aimpart (Head or Torso)
[6] aimvelocity/av - sets aimvelocity
=================================MISC===============================
[1] sit - makes you sit so u can suck dick ;)
[2] view/spy - spys on a player 
[3] unview/unspy - no view :) 
[4] removeseats/rs/noSeats/ns - ur penis cant go into someones mouth anymore
[5] nodoors/removeDoors/nds/rds - Remove doors
[6] autoReset/autoRe/ar - Resets you when ragdolled (idk if works anymore)
[7] fov - Changes your fieldofview
[8] skybox1/sky1 - skybox 1 
[9] esp/find - esp's a player :)
[10] unesp/unfind - unesp's a player ::))))
[11] gunanims - pawels gun anims :)
[12] skybox2/sky2 - skybox 2 
[12] balling - hamster ball 
===============================KEYBINDS===============================
Noclip - "X"
Reset - "R"
Shotty/Glock Colour - "G"
-------------------------------------------------------------------------
]])



	local LoadingTime = tick();
local Commands, Prefix = {}, ""
getgenv().Notify = function(title, text, icon, time)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = title;
        Text = text;
        Icon = "";
        Duration = time;
    }) 
end

getgenv().SearchPlayers = function(Name)
    local Inserted = {}
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do 
        if string.lower(string.sub(p.Name, 1, string.len(Name))) == string.lower(Name) then 
            table.insert(Inserted, p);return p
        end
    end
end


getgenv().GetInit = function(CName)
    for _, v in next, Commands do 
        if v.Name == CName or table.find(v.Aliases, CName) then 
            return v.Function 
        end 
    end
end

getgenv().RunCommand = function(Cmd)
    Cmd = string.lower(Cmd)
    pcall(function()
        if Cmd:sub(1, #Prefix) == Prefix then 
            local Args = string.split(Cmd:sub(#Prefix + 1), " ")
            local CmdName = GetInit(table.remove(Args, 1))
            if CmdName and Args then
                return CmdName(Args)
            end
        end
    end)
end

local ScreenGui = Instance.new("ScreenGui")
local Cmdbar = Instance.new("TextBox")
local CmdbarARC = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

coroutine.resume(coroutine.create(function()
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Cmdbar.Name = "Cmdbar"
Cmdbar.Parent = ScreenGui
Cmdbar.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
Cmdbar.BorderColor3 = Color3.fromRGB(255, 0, 255)
Cmdbar.BorderSizePixel = 3
Cmdbar.Position = UDim2.new(0, 0, 0.362876266, 0)
Cmdbar.Size = UDim2.new(0, 320, 0, 16)
Cmdbar.SizeConstraint = Enum.SizeConstraint.RelativeYY
Cmdbar.Font = Enum.Font.SourceSansSemibold
Cmdbar.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Cmdbar.Text = ""
Cmdbar.TextColor3 = Color3.fromRGB(255, 255, 255)
Cmdbar.TextSize = 19.000
Cmdbar.TextWrapped = true
Cmdbar.TextXAlignment = Enum.TextXAlignment.Center
Cmdbar.Visible = false

CmdbarARC.Name = "CmdbarARC"
CmdbarARC.Parent = Cmdbar
CmdbarARC.BackgroundColor3 = Color3.fromRGB(255, 170, 255)
CmdbarARC.BorderColor3 = Color3.fromRGB(255, 255, 255)
CmdbarARC.BorderSizePixel = 3
CmdbarARC.Position = UDim2.new(-0.123076916, 0, 0, 0)
CmdbarARC.Size = UDim2.new({0, 12},{0, 32})
CmdbarARC.Font = Enum.Font.Code
CmdbarARC.Text = ">"
CmdbarARC.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdbarARC.TextSize = 10.000
CmdbarARC.TextWrapped = true
CmdbarARC.Visible = true

Frame.Parent = Cmdbar
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.BorderColor3 = Color3.fromRGB(255,255,255)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(-0.123076923, 0, 0.972426474, 0)
Frame.Size = UDim2.new(0, 292, 0, 2)
Frame.Visible = false

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100,225,200)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(100,225,200)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(128,0,128))}
UIGradient.Parent = Frame
end))


local Uis = game:GetService("UserInputService")
Uis.InputBegan:Connect(function(Key, Typing)
    if Typing then return end
    if Key.KeyCode == Enum.KeyCode.Semicolon then
        Cmdbar.Visible = true
        Cmdbar.Text = ""
        wait()
        Cmdbar:CaptureFocus()
        --Cmdbar:TweenSize(UDim2.new(0, 419, 0, 20), "Out", "Quad", 0.1, true)
    end
end)
Cmdbar.FocusLost:Connect(function(Foc)
    if Foc == true then
        Cmdbar.Visible = false
            RunCommand(Cmdbar.Text)
    end
end)
Uis.InputEnded:Connect(function(Key)
    if Key.KeyCode.Name == "LeftAlt" then
        Cmdbar.Visible = false
    end
end)

-- [[ locals ]] -- 
local Players, RService, RStorage, VUser, SGui, TPService = game:GetService("Players"), game:GetService("RunService"), game:GetService("ReplicatedStorage"), game:GetService("VirtualUser"), game:GetService("StarterGui"), game:GetService("TeleportService")
local Client, Mouse, Camera, CF, INew, Vec3, Vec2, UD2, UD = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Instance.new, Vector3.new, Vector2.new, UDim2.new, UDim.new;
local Noclip, Blink, Esp, Flying, Noseats = false, false, true, false, false;
local Aimbot, Viewing, Camlock = false, false, false;
local AimbotTarget = nil;
local ViewTarget = nil;
local CamlockTarget = nil;
local EspTarget = nil;
local Aimvelocity = 7;
local CamPart = "Torso";
local AimPart ="Torso";
local StreetsID = 455366377
local PrisonID = 4669040;
-- [[ functions ]] -- 
local AimPartTable = {
    ["torso"] = "Torso";
    ["head"] = "Head";
}
local KeysTable = {
    ["W"] = false;["A"] = false;
    ["S"] = false;["D"] = false;
    ["LeftControl"] = false;["LeftShift"] = false;
}



local function ConfirmCallbacks()
    wait()
    SGui:SetCore("ResetButtonCallback", true)
end
ConfirmCallbacks()

getgenv().ResetCharacter = function()
    if Client and Client.Character and Client.Character:FindFirstChild("Humanoid") then 
        Client.Character.Humanoid:ChangeState(15)
    end
end


getgenv().EspPlayer = function(Dude)
    


	local bgui = Instance.new("BillboardGui", Dude.Character.Head)
	local tlabel = Instance.new("TextLabel", bgui)

	bgui.Name = "ESP"
	bgui.Adornee = part
	bgui.AlwaysOnTop = true
	bgui.ExtentsOffset = Vector3.new(0, 3, 0)
	bgui.Size = UDim2.new(0, 5, 0, 5)
    bgui.ResetOnSpawn = true
	
	tlabel.Name = "espTarget"
	tlabel.BackgroundColor3 = Color3.new(255, 255, 255)
	tlabel.BackgroundTransparency = 1
	tlabel.BorderSizePixel = 0
	tlabel.Position = UDim2.new(0, 0, 0, -30)
	tlabel.Size = UDim2.new(1, 0, 7, 0)
	tlabel.Visible = true
	tlabel.ZIndex = 10
	tlabel.Font = "SourceSansSemibold"
	tlabel.FontSize = "Size28"
	RService.RenderStepped:Connect(function()
		if Dude and Dude.Character and Dude.Character:FindFirstChildOfClass("Humanoid") then 
		    
			tlabel.Text = Dude.Name
			.." HP:["..math.floor(Dude.Character.Humanoid.Health)
			.."]"
		end
	end)
	tlabel.TextColor3 = Color3.fromRGB(255, 0, 255)
	tlabel.TextStrokeTransparency = 0.5
end

local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
local char = plr.Character


Uis.InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode.X then 
            Noclip = not Noclip 
            Notify("yurr", "Noclip: "..tostring(Noclip), "", 3)
        end
    end)
--COMMANDS
Commands["Sit"] = {
    ["Aliases"] = {"sit"};
    ["Function"] = function(Args)
game.Players.LocalPlayer.Character.Humanoid.Sit = true
end
}
Commands["GunAnims"] = {
    ["Aliases"] = {"gunanims", "gunanim"};
    ["Function"] = function(Args)
game:GetService("Players").LocalPlayer.Backpack.Shotty.LocalScript:Destroy()
game:GetService("Players").LocalPlayer.Backpack.Shotty.Reloading:Destroy()
game:GetService("Players").LocalPlayer.Backpack.Shotty.Idle:Destroy()
local lplr = game:GetService("Players").LocalPlayer
local shotty = lplr.Backpack:FindFirstChild("Shotty")
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://9863740031"
local plr = game:GetService('Players').LocalPlayer
local HUM = plr.Character.Humanoid:LoadAnimation(Animation)
shotty.Equipped:connect(function()
    wait(.1)
    HUM:Play()
    HUM:AdjustSpeed(0.0)
end)
shotty.Unequipped:connect(function()
    HUM:Stop()
end)
game:GetService("Players").LocalPlayer.Backpack.Glock.LocalScript:Destroy()
game:GetService("Players").LocalPlayer.Backpack.Glock.Reloading:Destroy()
game:GetService("Players").LocalPlayer.Backpack.Glock.Idle:Destroy()
local lplr = game:GetService("Players").LocalPlayer
local Glock = lplr.Backpack:FindFirstChild("Glock")
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://9863740031"
local plr = game:GetService('Players').LocalPlayer
local HUM = plr.Character.Humanoid:LoadAnimation(Animation)
Glock.Equipped:connect(function()
    wait(.1)
    HUM:Play()
    HUM:AdjustSpeed(0.0)
end)
Glock.Unequipped:connect(function()
    HUM:Stop()
end)
Notify("yurr", "gun anims on")
end
}
Commands["NoDoors"] = {
    ["Aliases"] = {"nodoors", "doors"};
    ["Function"] = function(Args)
local doors = game.Workspace:GetChildren()
for i,v in pairs (doors)do 
    if v.Name == "Door" then
        v:Destroy()
        
     
    end    
    end
end
}
Commands["SkyBox1"] = {
    ["Aliases"] = {"sky1"};
    ["Function"] = function(Args)
 local lighting = game.Lighting
        if lighting:FindFirstChild("ColorCorrection") then
            lighting:FindFirstChild("ColorCorrection"):Remove()
        end
        if lighting:FindFirstChild("Correction") then
            lighting:FindFirstChild("Correction"):Remove()
        end

        local sunray = Instance.new("SunRaysEffect", lighting)
        local sky = lighting.Sky
        sky.SkyboxBk = "http://www.roblox.com/asset/?id=150335574"
        sky.SkyboxDn = "http://www.roblox.com/asset/?id=150335585"
        sky.SkyboxFt = "http://www.roblox.com/asset/?id=150335628"
        sky.SkyboxLf = "http://www.roblox.com/asset/?id=150335620"
        sky.SkyboxRt = "http://www.roblox.com/asset/?id=150335610"
        sky.SkyboxUp = "http://www.roblox.com/asset/?id=150335642"

        sky.StarCount = 3000
        sky.SunAngularSize = 21
        sky.MoonAngularSize = 11

        local correction = Instance.new("ColorCorrectionEffect", lighting)
        correction.Name = "Correction"
        correction.Saturation = -0.4
        correction.TintColor = Color3.fromRGB(255, 255, 255)
end
}
Commands["SkyBox2"] = {
    ["Aliases"] = {"sky2"};
    ["Function"] = function(Args)
 local lighting = game.Lighting
        if lighting:FindFirstChild("ColorCorrection") then
            lighting:FindFirstChild("ColorCorrection"):Remove()
        end
        if lighting:FindFirstChild("Correction") then
            lighting:FindFirstChild("Correction"):Remove()
        end

        local sunray = Instance.new("SunRaysEffect", lighting)
        local sky = lighting.Sky
        sky.SkyboxBk = "http://www.roblox.com/asset/?id=218955819"
        sky.SkyboxDn = "http://www.roblox.com/asset/?id=218953419"
        sky.SkyboxFt = "http://www.roblox.com/asset/?id=218954524"
        sky.SkyboxLf = "http://www.roblox.com/asset/?id=218958493"
        sky.SkyboxRt = "http://www.roblox.com/asset/?id=218957134"
        sky.SkyboxUp = "http://www.roblox.com/asset/?id=218950090"

        sky.StarCount = 3000
        sky.SunAngularSize = 21
        sky.MoonAngularSize = 11

        local correction = Instance.new("ColorCorrectionEffect", lighting)
        correction.Name = "Correction"
        correction.Saturation = -0.4
        correction.TintColor = Color3.fromRGB(255, 255, 255) 
end
}
Commands["Sets your FieldOfView"] = {
    ["Aliases"] = {"fieldofview", "fov"};
    ["Function"] = function(Args)
        if Args[1] then 
            Camera.FieldOfView = tonumber(Args[1])
        end
        Notify("yurr", "FieldOfView: "..tonumber(Args[1]), "", 3)
    end
}
Commands["Sets Aimbot Target"] = {
    ["Aliases"] = {"aim", "target"};
    ["Function"] = function(Args)
        if Args[1] then 
            AimbotTarget = SearchPlayers(Args[1]);Aimbot = true
        end
        Notify("yurr", "Aimbot Target: "..tostring(AimbotTarget), "", 3)
    end
}
Commands["UnAimbots Aimbotted Target"] = {
    ["Aliases"] = {"unaim"};
    ["Function"] = function()
        AimbotTarget = nil;Aimbot = false
        Notify("yurr", "Aimbot: "..tostring(Aimbot), "", 3)
    end
}
Commands["Sets Camlock Target"] = {
    ["Aliases"] = {"camlock","cl"};
    ["Function"] = function(Args)
        if Args[1] then 
            CamlockTarget = SearchPlayers(Args[1]);Camlock = true
        end
        Notify("yurr", "Camlock Target: "..tostring(CamlockTarget), "", 3)
    end
}
Commands["UnCamlocks Camlocked Target"] = {
    ["Aliases"] = {"uncamlock", "uncl"};
    ["Function"] = function()
        CamlockTarget = nil;Camlock = false 
        Notify("yurr", "Camlock: "..tostring(Camlock), "", 3)
    end
}
Commands["Sets Aimbot Part"] = {
    ["Aliases"] = {"aimpart"};
    ["Function"] = function(Args)
        AimPart = Args[1]
        if AimPartTable[Args[1]] then 
            AimPart = AimPartTable[Args[1]] 
        end
        Notify("yurr", "AimPart: "..tostring(AimPart), "", 3)
    end
}
Commands["Sets Aimvelocity"] = {
    ["Aliases"] = {"aimvelocity", "av"};
    ["Function"] = function(Args)
        if Args[1] then 
            Aimvelocity = tonumber(Args[1])
        end
        Notify("yurr", "Aimvelocity: "..tonumber(Args[1]), "", 3)
    end
}
Commands["Esp a Player"] = {
    ["Aliases"] = {"esp", "find"};
    ["Function"] = function(Args)
        if Args[1] then
            EspTarget = SearchPlayers(Args[1])
            if EspTarget then
                EspPlayer(EspTarget)
            end
        end
        Notify("yurr", "Esp Target: "..tostring(EspTarget), "", 3)
    end
}
Commands["UnEsp Esp'd Player"] = {
    ["Aliases"] = {"unesp", "unfind"};
    ["Function"] = function(Args)
        if Args[1] then 
			local UnEspPlayer;UnEspPlayer = SearchPlayers(Args[1])
			if UnEspPlayer then 
				for _, v in next, UnEspPlayer.Character:GetDescendants() do 
					if v:IsA("BillboardGui") or v:IsA("TextLabel") then 
						v:Destroy() 
					end
				end
			end
		end
	end
}
Commands["Resets Your Character"] = {
    ["Aliases"] = {"r", "reset", "re", "res"};
    ["Function"] = function()
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
}
Commands["View a Player"] = {
    ["Aliases"] = {"view"};
    ["Function"] = function(Args)
        if Args[1] then 
            ViewTarget = SearchPlayers(Args[1]);Viewing = true 
        end
        Notify("yurr", "View Target: "..tostring(ViewTarget), "", 3)
    end
}
Commands["UnView Viewed Target"] = {
    ["Aliases"] = {"unview"};
    ["Function"] = function()
        ViewTarget = nil;Viewing = false
        Camera.CameraSubject = Client.Character
        Notify("yurr", "Viewing: "..tostring(Viewing), "", 3)
    end
}
Commands["Toggles Noclip"] = {
    ["Aliases"] = {"noclip", "nc", "nclip"};
    ["Function"] = function()
        Noclip = not Noclip 
        Notify("yurr", "Noclip: "..tostring(Noclip), "", 3)
    end
}
Commands["Removes Chairs"] = {
    ["Aliases"] = { "removeseats", "rs", "noseats", "ns"};
    ["Function"] = function()
        
for i,v in next, workspace:GetDescendants() do
    if v:IsA'Seat' then
        v:Destroy()
    end
        end
Notify("yurr", "Removed all seats")
    end
}
Commands["balling"] = {
    ["Aliases"] = {"balling"};
    ["Function"] = function(Args)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local SPEED_MULTIPLIER = 30
local JUMP_POWER = 60
local JUMP_GAP = 0.3

local character = game.Players.LocalPlayer.Character

for i,v in ipairs(character:GetDescendants()) do
    if v:IsA("BasePart") then
        v.CanCollide = false
    end
end

local ball = character.HumanoidRootPart
ball.Shape = Enum.PartType.Ball
ball.Size = Vector3.new(5,5,5)
local humanoid = character:WaitForChild("Humanoid")
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Blacklist
params.FilterDescendantsInstances = {character}

local tc = RunService.RenderStepped:Connect(function(delta)
    ball.CanCollide = true
    humanoid.PlatformStand = true
	if UserInputService:GetFocusedTextBox() then return end
	if UserInputService:IsKeyDown("W") then
		ball.RotVelocity -= Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
	end
	if UserInputService:IsKeyDown("A") then
		ball.RotVelocity -= Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
	end
	if UserInputService:IsKeyDown("S") then
		ball.RotVelocity += Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
	end
	if UserInputService:IsKeyDown("D") then
		ball.RotVelocity += Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
	end
	--ball.RotVelocity = ball.RotVelocity - Vector3.new(0,ball.RotVelocity.Y/50,0)
end)

UserInputService.JumpRequest:Connect(function()
	local result = workspace:Raycast(
		ball.Position,
		Vector3.new(
			0,
			-((ball.Size.Y/2)+JUMP_GAP),
			0
		),
		params
	)
	if result then
		ball.Velocity = ball.Velocity + Vector3.new(0,JUMP_POWER,0)
	end
end)

Camera.CameraSubject = ball
humanoid.Died:Connect(function() tc:Disconnect() end)
end
}
Commands["AutoReset"] = {
    ["Aliases"] = { "autore", "ar"};
    ["Function"] = function()
         game.StarterGui:SetCore("SendNotification", {
Title = "yurr";
Text = "auto setspawn reset looped";
Duration = 5;
})
while wait() do
        pcall(function()
        if game.Players.LocalPlayer.Character.Head:FindFirstChild("Bone") then
            local LocalP = game.Players.LocalPlayer
            local Mouse = LocalP:GetMouse()
            prev = LocalP.Character:WaitForChild('HumanoidRootPart').CFrame
            Mouse.KeyDown:Connect(function(key)
                if key == "r" then
                    prev = LocalP.Character:WaitForChild('HumanoidRootPart').CFrame
                    LocalP.Character.Parent = workspace.Terrain
                    LocalP.Character.Torso:Destroy()
                    game:GetService('Workspace'):WaitForChild(LocalP.Name) 
                    for i=1,10 do
                        LocalP.Character:WaitForChild('HumanoidRootPart').CFrame = prev
                        wait()
                    end
                end
            end)
        end
        end)
        end
    end
}



--End of cmds

RService.Stepped:Connect(function()
    if Camlock == true and CamlockTarget and CamlockTarget.Character and CamlockTarget.Character:FindFirstChild(CamPart) then 
        Camera.CoordinateFrame = CF(Camera.CoordinateFrame.p, CF(CamlockTarget.Character[CamPart].Position).p)
    end
     if Viewing == true and ViewTarget ~= nil then 
        Camera.CameraSubject = ViewTarget.Character
     end
    if Noclip == true then 
        for i = 1, #Client.Character:GetChildren() do
            local CG = Client.Character:GetChildren()[i]
            if CG:IsA("BasePart") then 
                CG.CanCollide = false 
            end
        end
    end
end)
 
print([[


]])
game:GetService("Workspace").FallenPartsDestroyHeight = math.huge-math.huge
Notify("yurr", "Took "..string.format("%.3f", tick() - LoadingTime).." seconds to load", "" , 3)



local P = game:GetService("Players")
local LP = P.LocalPlayer
local mouse = LP:GetMouse()

mouse.Button1Down:Connect(function()
	for _,a in pairs(LP.Character:GetChildren()) do
		if a:IsA("Tool") and a.Name == "Shotty" or a.Name == "Glock" or a.Name == "Sawed Off" or a.Name == "Uzi" then


			a.Shoot:FireServer(mouse.Hit)



		end
	end
end)


game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(key)
 if key == "r" then
    local LocalP = game.Players.LocalPlayer
    local Mouse = LocalP:GetMouse()
    prev = LocalP.Character:WaitForChild('HumanoidRootPart').CFrame
    Mouse.KeyDown:Connect(function(key)
        if key == "r" then
            prev = LocalP.Character:WaitForChild('HumanoidRootPart').CFrame
            LocalP.Character.Parent = workspace.Terrain
            LocalP.Character.Torso:Destroy()
            game:GetService('Workspace'):WaitForChild(LocalP.Name) 
            for i=1,10 do
                LocalP.Character:WaitForChild('HumanoidRootPart').CFrame = prev
                wait()
            end
        end
    end)
 end
end)

mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(key)
        if key:lower() == "g" then
    local glock  = game.Players.LocalPlayer.Backpack.Glock:GetChildren()
for i,v in pairs (glock) do
   if v.Name == "Union" or "Heh" or "Handle" or "Barrel" or "Clip" then
    v.UsePartColor = true
    wait()
    v.Material = "ForceField"
    v.Color = Color3.fromRGB(255, 255, 255)
    v.Transparency = 0.6


    end
end
end
end)
mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(key)
        if key:lower() == "g" then
    local shotty = game.Players.LocalPlayer.Backpack.Shotty:GetChildren()
for i,v in pairs (shotty) do
    if v.Name == "Union" then
    v.UsePartColor = true
    wait()
    v.Material = "ForceField"
    v.Color = Color3.fromRGB(255, 255, 255)
    v.Transparency = 0.6
end
end
end
end)
