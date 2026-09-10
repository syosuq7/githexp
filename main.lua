local starterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")
local virtualInputManager = game:GetService("VirtualInputManager")
local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")
local rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
pcall(function() setclipboard("t.me/SpectreX_hub") end)

starterGui:SetCore("SendNotification", {
  Title = "SpectrX Hub",
  Text = "Telegram link copied!\nПрисоединяйтесь: t.me/SpectreX_hub",
  Duration = 8,
})

local window = rayfield:CreateWindow({
  Name = "SpectrX Hub - YBA Classic FIXED",
  LoadingTitle = "Restoring & Updating...",
  LoadingSubtitle = "by SpectrX_Hub",
  ConfigurationSaving = { Enabled = true, FileName = "SpectrX_Config" },
  KeySystem = true,
  KeySettings = {
    Title = "SpectrX Hub - Key System",
    Subtitle = "Enter your activation key",
    Note = [[
Join our Telegram for key: t.me/SpectreX_hub

Key valid for 32 hours]],
    FileName = "SpectrX_Key",
    SaveKey = true,
    GrabKeyFromSite = false,
    Key = { "SPX_IAV&N!x%" },
  },
})

local localPlayer = game.Players.LocalPlayer

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
bodyVelocity.Velocity = Vector3.zero

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)

getgenv().AutoFarm = false
getgenv().PVPMode = false
getgenv().AutoBlock = false
getgenv().TargetName = ""

local health = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
    and localPlayer.Character.Humanoid.Health
  or 100

local function f1()
  if getgenv().PVPMode and getgenv().TargetName ~= "" then
    for key, value in pairs(game.Players:GetPlayers()) do
      if value ~= localPlayer and value.Name:lower():find(getgenv().TargetName:lower())
        and value.Character and value.Character:FindFirstChild("HumanoidRootPart") then
        if value.Character.Humanoid.Health > 0 then
          return value.Character.HumanoidRootPart
        end
      end
    end

    return nil
  elseif getgenv().AutoFarm then
    local living = workspace:FindFirstChild("Living")

    if living then
      for key2, value2 in pairs(living:GetChildren()) do
        if value2.Name == "Alpha Thug" and value2:FindFirstChild("HumanoidRootPart")
          and value2.Humanoid.Health > 0 then
          return value2.HumanoidRootPart
        end
      end

      return nil
    end

    return nil
  else
    return nil
  end
end

task.spawn(function()
  while task.wait(0.15) do
    if (getgenv().AutoFarm or getgenv().PVPMode) and f1() then
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
      task.wait(0.02)
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
  end
end)

task.spawn(function()
  while task.wait() do
    if getgenv().AutoBlock and localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid") then
      local health2 = localPlayer.Character.Humanoid.Health

      if health2 < health then
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(1.5)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
      end

      health = health2
    end
  end
end)

runService.Heartbeat:Connect(function()
  if not getgenv().AutoFarm and not getgenv().PVPMode then
    bodyVelocity.Parent = nil
    bodyGyro.Parent = nil
    return
  end

  pcall(function()
    local v1 = f1()
    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if v1 and humanoidRootPart then
      bodyVelocity.Parent = humanoidRootPart
      bodyGyro.Parent = humanoidRootPart
      local cframe = CFrame.new(0, 2.8, 1.5)
      local v2 = v1.CFrame * cframe
      humanoidRootPart.CFrame = CFrame.lookAt(v2.p, v1.Position)
      bodyGyro.CFrame = CFrame.lookAt(v2.p, v1.Position)

      for key3, value3 in pairs(character:GetDescendants()) do
        if value3:IsA("BasePart") then
          value3.CanCollide = false
        end
      end
    else
      bodyVelocity.Parent = nil
      bodyGyro.Parent = nil
    end
  end)
end)

local function f2()
  return localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local v3 = 50

local function f3()
  local v4 = f2()

  local humanoid = localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if not v4 or not humanoid then
    return
  else
    local moveDirection = humanoid.MoveDirection

    if moveDirection.Magnitude > 0 then
      local heartbeat = runService.Heartbeat
      v4.CFrame = v4.CFrame + moveDirection * (heartbeat:Wait() * 50 * (v3 / 16))
      humanoid.WalkSpeed = 16
    end

    return
  end
end

local v5 = false
local jumpPower = 50

local function f4()
  if not v5 then
    return
  else
    local humanoid2 = localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid2 then
      humanoid2.UseJumpPower = true
      humanoid2.JumpPower = jumpPower
    end

    return
  end
end

local v6 = false
local v7 = false

local function f5()
  if not v7 or not localPlayer.Character then
    return
  end

  for index, value4 in ipairs(localPlayer.Character:GetDescendants()) do
    local v8 = value4

    if v8:IsA("BasePart") then
      v8.CanCollide = false

      pcall(function()
        for index2, value5 in ipairs((getconnections(v8:GetPropertyChangedSignal("CanCollide")))) do
          value5:Disable()
        end
      end)
    end
  end
end

local fly = false
local v9 = 5
local v10 = nil

local function f6()
  if v10 then
    v10:Destroy()
    v10 = nil
  end
end

local v11 = {
  W = false,
  A = false,
  S = false,
  D = false,
  Space = false,
  Shift = false,
}

local function f7()
  if v10 and v10.Parent then
    return
  else
    local flyButtons = Instance.new("ScreenGui")
    flyButtons.Name = "FlyButtons"
    flyButtons.ResetOnSpawn = false
    flyButtons.Parent = coreGui

    local textButton = Instance.new("TextButton")
    textButton.Size = UDim2.new(0, 80, 0, 80)
    textButton.Position = UDim2.new(0.5, -100, 1, -90)
    textButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    textButton.Text = "⬆"
    textButton.TextSize = 30
    textButton.Font = Enum.Font.GothamBold
    textButton.TextColor3 = Color3.new(1, 1, 1)
    textButton.Parent = flyButtons

    local textButton2 = Instance.new("TextButton")
    textButton2.Size = UDim2.new(0, 80, 0, 80)
    textButton2.Position = UDim2.new(0.5, 20, 1, -90)
    textButton2.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    textButton2.Text = "⬇"
    textButton2.TextSize = 30
    textButton2.Font = Enum.Font.GothamBold
    textButton2.TextColor3 = Color3.new(1, 1, 1)
    textButton2.Parent = flyButtons

    textButton.MouseButton1Down:Connect(function() v11.Space = true end)
    textButton.MouseButton1Up:Connect(function() v11.Space = false end)

    textButton2.MouseButton1Down:Connect(function() v11.Shift = true end)
    textButton2.MouseButton1Up:Connect(function() v11.Shift = false end)

    textButton.TouchLongPress:Connect(function() v11.Space = true end)
    textButton.TouchEnded:Connect(function() v11.Space = false end)

    textButton2.TouchLongPress:Connect(function() v11.Shift = true end)
    textButton2.TouchEnded:Connect(function() v11.Shift = false end)

    v10 = flyButtons
    return
  end
end

local v12 = {}

local function f8(p1)
  if p1 == localPlayer then
    return
  else
    local character2 = p1.Character

    if not character2 then
      return
    else
      local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")
        or character2:FindFirstChild("Torso") or character2:FindFirstChild("UpperTorso")

      if not humanoidRootPart2 then
        return
      else
        if v12[p1] then
          for index3, value6 in ipairs(v12[p1]) do
            local v13 = value6
            pcall(function() v13:Destroy() end)
          end

          v12[p1] = nil
        end

        local v14 = {}

        local highlight = Instance.new("Highlight")
        highlight.Adornee = character2
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Color3.new(1, 0, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = character2

        table.insert(v14, highlight)

        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 200, 0, 60)
        billboardGui.AlwaysOnTop = true
        billboardGui.ClipsDescendants = false
        billboardGui.MaxDistance = 500
        billboardGui.Adornee = humanoidRootPart2
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.Parent = character2

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = billboardGui

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = p1.Name .. "\n[0]"
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextSize = 16
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextWrapped = true
        textLabel.Parent = frame

        table.insert(v14, billboardGui)
        v12[p1] = v14
        return
      end
    end
  end
end

local bodyVelocity2, connect

local function f9()
  local v15 = f2()

  if not v15 then
    return
  end

  if bodyVelocity2 then
    bodyVelocity2:Destroy()
  end

  bodyVelocity2 = Instance.new("BodyVelocity")
  bodyVelocity2.MaxForce = Vector3.new(100000, 100000, 100000)
  bodyVelocity2.Parent = v15

  for key4 in pairs(v11) do
    v11[key4] = false
  end

  if userInputService.TouchEnabled then
    f7()
  end

  connect = runService.Heartbeat:Connect(function()
    if not fly or not localPlayer.Character then
      if bodyVelocity2 then
        bodyVelocity2:Destroy()
      end

      return
    else
      local v16 = f2()
      local character3 = localPlayer.Character

      local humanoid3 = character3
      humanoid3 = character3 and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      local v17 = not v16
      local v18 = humanoid3

      if v17 or not v18 then
        return
      else
        local cframe2 = workspace.CurrentCamera.CFrame
        local vectorToObjectSpace = cframe2:VectorToObjectSpace(v18.MoveDirection)

        local v19 = cframe2.RightVector * vectorToObjectSpace.X
          - cframe2.LookVector * vectorToObjectSpace.Z

        local v20 = 0

        if v11.Space then
          v20 = v20 + 1
        end

        if v11.Shift then
          v20 = v20 - 1
        end

        bodyVelocity2.Velocity = v19 * 50 * v9 + Vector3.new(0, v20 * 50 * v9, 0)
        return
      end
    end
  end)
end

local function f10()
  if connect then
    connect:Disconnect()
    connect = nil
  end

  if bodyVelocity2 then
    bodyVelocity2:Destroy()
    bodyVelocity2 = nil
  end

  f6()
end

local v21 = false

local function f11()
  local v22 = f2()

  if not v22 then
    return
  end

  for key5, value7 in pairs(v12) do
    local character4 = key5.Character

    if character4 and value7[2] then
      local humanoidRootPart3 = character4:FindFirstChild("HumanoidRootPart")
        or character4:FindFirstChild("Torso") or character4:FindFirstChild("UpperTorso")

      if humanoidRootPart3 then
        local magnitude = (v22.Position - humanoidRootPart3.Position).Magnitude
        local v23 = value7[2]

        if v23 and v23:IsA("BillboardGui") then
          local textLabel2 = v23.Frame and v23.Frame.TextLabel

          if textLabel2 then
            textLabel2.Text = key5.Name .. "\n[" .. math.floor(magnitude) .. "]"
          end
        end

        if magnitude > 500 then
          for index4, value8 in ipairs(value7) do
            value8.Enabled = false
          end
        else
          for index5, value9 in ipairs(value7) do
            value9.Enabled = true
          end
        end
      else
        for index6, value10 in ipairs(value7) do
          value10.Enabled = false
        end
      end
    else
      for index7, value11 in ipairs(value7) do
      end

      v12[key5] = nil
    end
  end
end

local function f12()
  for key6, value12 in pairs(v12) do
  end

  v12 = {}
end

getgenv().itempicker = false
local v24

local function f13()
  getgenv().itempicker = false

  if v24 then
    coroutine.close(v24)
    v24 = nil
  end
end

local function f14(cframe3)
  local v25 = f2()

  if v25 then
    v25.CFrame = cframe3
  end
end

local f15

local function f16()
  if v24 then
    coroutine.close(v24)
    v24 = nil
  end

  v24 = coroutine.create(function()
    local items = workspace:FindFirstChild("Item_Spawns")
      and workspace.Item_Spawns:FindFirstChild("Items")

    if not items then
      rayfield:Notify({ Title = "Auto Farm", Content = "Items folder not found!", Duration = 3 })
      return
    end

    while getgenv().itempicker do
      for index8, value13 in ipairs(items:GetChildren()) do
        if not getgenv().itempicker then
          break
        else
          local cframe4 = nil

          if value13:IsA("Model") then
            if value13.PrimaryPart then
              cframe4 = value13.PrimaryPart.CFrame
            else
              local part = value13:FindFirstChildWhichIsA("Part")

              if part then
                cframe4 = part.CFrame
              end
            end
          elseif value13:IsA("Part") then
            cframe4 = value13.CFrame
          end

          if cframe4 then
            f14(cframe4)
            task.wait(0.5)
            f15()
            task.wait(1)
          end
        end
      end

      task.wait()
    end
  end)

  coroutine.resume(v24)
end

function f15()
  virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
  task.wait(1)
  virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local mainTab = window:CreateTab("Main")
mainTab:CreateSection("Combat System")

mainTab:CreateToggle({
  Name = "Auto Farm",
  CurrentValue = false,
  Callback = function(value14) getgenv().AutoFarm = value14 end,
})

mainTab:CreateToggle({
  Name = "PVP Mode",
  CurrentValue = false,
  Callback = function(value15) getgenv().PVPMode = value15 end,
})

mainTab:CreateInput({
  Name = "PVP Target Nickname",
  PlaceholderText = "Enter name...",
  Callback = function(value16) getgenv().TargetName = value16 end,
})

mainTab:CreateToggle({
  Name = "Auto Block",
  CurrentValue = false,
  Callback = function(value17) getgenv().AutoBlock = value17 end,
})

local movementTab = window:CreateTab("Movement")
movementTab:CreateSection("Movement Enhancements")

local connect2

movementTab:CreateToggle({
  Name = "Walkspeed Bypass",
  CurrentValue = false,
  Callback = function(value18)
    if value18 then
      if connect2 then
        connect2:Disconnect()
      end

      connect2 = runService.Heartbeat:Connect(f3)
    else
      if connect2 then
        connect2:Disconnect()
        connect2 = nil
      end

      local character5 = localPlayer.Character

      local humanoid4 = character5
      humanoid4 = character5 and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        humanoid4.WalkSpeed = 16
      end
    end
  end,
})

movementTab:CreateSlider({
  Name = "Speed Value (1-100)",
  Range = { 1, 100 },
  Increment = 1,
  Suffix = " speed",
  CurrentValue = 50,
  Callback = function(value19) v3 = value19 end,
})

local connect3

movementTab:CreateToggle({
  Name = "Jump Power",
  CurrentValue = false,
  Callback = function(value20)
    v5 = value20

    if value20 then
      f4()

      if connect3 then
        connect3:Disconnect()
      end

      connect3 = runService.Heartbeat:Connect(f4)
    else
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end

      local character6 = localPlayer.Character

      local humanoid5 = character6
      humanoid5 = character6 and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid5 then
        humanoid5.JumpPower = 50
      end
    end
  end,
})

movementTab:CreateSlider({
  Name = "Jump Power Value (1-100)",
  Range = { 1, 100 },
  Increment = 1,
  Suffix = " power",
  CurrentValue = 50,
  Callback = function(value21)
    jumpPower = value21

    if v5 then
      f4()
    end
  end,
})

local connect4

movementTab:CreateToggle({
  Name = "Infinite Jump",
  CurrentValue = false,
  Callback = function(value22)
    v6 = value22

    if value22 then
      if connect4 then
        connect4:Disconnect()
      end

      connect4 = userInputService.JumpRequest:Connect(function()
        if v6 then
          local humanoid6 = localPlayer.Character
            and localPlayer.Character:FindFirstChildOfClass("Humanoid")

          if humanoid6 then
            humanoid6:ChangeState("Jumping")
          end
        end
      end)
    elseif connect4 then
      connect4:Disconnect()
      connect4 = nil
    end
  end,
})

local connect5

movementTab:CreateToggle({
  Name = "Noclip",
  CurrentValue = false,
  Callback = function(value23)
    v7 = value23

    if value23 then
      f5()

      if connect5 then
        connect5:Disconnect()
      end

      connect5 = runService.Stepped:Connect(f5)
    else
      if connect5 then
        connect5:Disconnect()
        connect5 = nil
      end

      if localPlayer.Character then
        for index9, value24 in ipairs(localPlayer.Character:GetDescendants()) do
          if value24:IsA("BasePart") then
            value24.CanCollide = true
          end
        end
      end
    end
  end,
})

movementTab:CreateToggle({
  Name = "Fly",
  CurrentValue = false,
  Callback = function(value25)
    fly = value25

    if value25 then
      f9()
    else
      f10()
    end
  end,
})

movementTab:CreateSlider({
  Name = "Fly Speed Multiplier (1-10)",
  Range = { 1, 10 },
  Increment = 1,
  Suffix = "x",
  CurrentValue = 5,
  Callback = function(value26) v9 = value26 end,
})

movementTab:CreateSection("Auto Farm Items")

movementTab:CreateToggle({
  Name = "Auto Farm Items",
  CurrentValue = false,
  Callback = function(value27)
    getgenv().itempicker = value27

    if value27 then
      f16()
    else
      f13()
    end
  end,
})

local visualsTab = window:CreateTab("Visuals")
visualsTab:CreateSection("ESP")

local connect6, connect7, connect8

visualsTab:CreateToggle({
  Name = "ESP",
  CurrentValue = false,
  Callback = function(value28)
    v21 = value28

    if value28 then
      for index10, value29 in ipairs(game.Players:GetPlayers()) do
        f8(value29)
      end

      connect7 = game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
          if v21 then
            f8(player)
          end
        end)

        if player.Character then
          f8(player)
        end
      end)

      connect8 = game.Players.PlayerRemoving:Connect(function(player2)
        if v12[player2] then
          for index11, value30 in ipairs(v12[player2]) do
            local v26 = value30
            pcall(function() v26:Destroy() end)
          end

          v12[player2] = nil
        end
      end)

      if connect6 then
        connect6:Disconnect()
      end

      connect6 = runService.Heartbeat:Connect(f11)
    else
      if connect7 then
        connect7:Disconnect()
        connect7 = nil
      end

      if connect8 then
        connect8:Disconnect()
        connect8 = nil
      end

      if connect6 then
        connect6:Disconnect()
        connect6 = nil
      end

      f12()
    end
  end,
})

local infoTab = window:CreateTab("Info")
infoTab:CreateSection("How to use")
infoTab:CreateLabel("• Auto Farm Alpha Thugs: Automatically kills Alpha Thugs (Living folder).")
infoTab:CreateLabel("• PVP Mode: Hunts a player by nickname (enter below).")
infoTab:CreateLabel("• Auto Block: Presses F automatically when you take damage.")
infoTab:CreateLabel("• Walkspeed Bypass: Adjustable speed (1-100).")
infoTab:CreateLabel("• Jump Power: Adjustable jump height (1-100).")
infoTab:CreateLabel("• Infinite Jump: Jump repeatedly in air.")
infoTab:CreateLabel("• Noclip: Walk through walls.")
infoTab:CreateLabel("• Fly: Toggle flight. Speed multiplier 1-10.")
infoTab:CreateLabel("• Auto Farm Items: Collects all items in Item_Spawns.")
infoTab:CreateLabel("• ESP: Red highlight + name tags for players.")
infoTab:CreateLabel("• Join Telegram: t.me/SpectreX_hub")
infoTab:CreateSection("Script Info")
infoTab:CreateLabel("Script: YBA script by SpectrX_Hub")
infoTab:CreateLabel("Version: 8.0 (Classic Combat Fixed)")
infoTab:CreateLabel("Status: ACTIVE")

local creditsTab = window:CreateTab("Credits")
creditsTab:CreateLabel("Script written by SpectrX_Hub")
creditsTab:CreateLabel("Special for my Subscribers")
creditsTab:CreateLabel("Telegram: t.me/SpectreX_hub")

creditsTab:CreateButton({
  Name = "Copy Telegram Link",
  Callback = function()
    pcall(function() setclipboard("t.me/SpectreX_hub") end)
    rayfield:Notify({ Title = "Telegram", Content = "Link copied!", Duration = 8 })
  end,
})

rayfield:Notify({ Title = "SpectrX", Content = "Script Fixed & Updated!", Duration = 3 })

game.Players.PlayerRemoving:Connect(function(player3)
  if player3 == localPlayer then
    getgenv().AutoFarm = false
    getgenv().PVPMode = false
    getgenv().AutoBlock = false

    if connect2 then
      connect2:Disconnect()
    end

    if connect3 then
      connect3:Disconnect()
    end

    if connect4 then
      connect4:Disconnect()
    end

    if connect5 then
      connect5:Disconnect()
    end

    if connect then
      connect:Disconnect()
    end

    if connect6 then
      connect6:Disconnect()
    end

    if connect7 then
      connect7:Disconnect()
    end

    if connect8 then
      connect8:Disconnect()
    end

    f10()
    f12()
    f13()
    bodyVelocity.Parent = nil
    bodyGyro.Parent = nil
  end
end)
