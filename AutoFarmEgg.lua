local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local eggFolder = workspace:WaitForChild("EggEvent") -- Папка с яйцами

-- Проверка близости к spawn
local function isNearSpawn(obj, spawnPos)
	if not obj:IsA("BasePart") then return false end
	return (obj.Position - spawnPos).Magnitude < 5
end

-- Подсветка яйца
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

-- Телепорт к яйцу
function teleportToEgg(part)
	RootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
end

-- Автосбор яйца
function autoCollectEgg(part)
	teleportToEgg(part)
	task.wait(0.3) -- Небольшая задержка для сбора
end

-- Слежка за появлением объектов
workspace.DescendantAdded:Connect(function(obj)
	task.wait(0.1)
	for _, spawn in pairs(eggFolder:GetDescendants()) do
		if spawn:IsA("BasePart") and spawn.Name == "spawn" then
			if isNearSpawn(obj, spawn.Position) then
				highlightRealEgg(obj)
				autoCollectEgg(obj)
			end
		end
	end
end)

print("✅ Подсветка, телепорт и автосбор активированы!")

