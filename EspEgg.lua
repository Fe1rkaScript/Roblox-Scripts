local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local eggFolder = workspace:WaitForChild("EggEvent")

-- Функция для проверки, находится ли объект рядом со спавном
local function isNearSpawn(obj, spawnPos)
    if not obj:IsA("BasePart") then return false end
    return (obj.Position - spawnPos).Magnitude < 5 -- расстояние в студии можешь подправить
end

-- Функция подсветки
function highlightRealEgg(part)
    part.Color = Color3.fromRGB(0, 255, 0)
    part.Material = Enum.Material.Neon

    local a1 = Instance.new("Attachment", RootPart)
    local a2 = Instance.new("Attachment", part)

    local beam = Instance.new("Beam")
    beam.Attachment0 = a1
    beam.Attachment1 = a2
    beam.Width0 = 0.05
    beam.Width1 = 0.05
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(Color3.new(0, 1, 0))
    beam.Parent = a1
end

-- Слушаем появление новых объектов
workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.1) -- чуть подождать, чтобы Position прогрузился
    for _, spawn in pairs(eggFolder:GetDescendants()) do
        if spawn:IsA("BasePart") and spawn.Name == "spawn" then
            if isNearSpawn(obj, spawn.Position) then
                highlightRealEgg(obj)
            end
        end
    end
end)

print("🎯 Реальные яйца будут подсвечены при появлении!")
