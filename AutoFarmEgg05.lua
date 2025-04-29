local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local eggFolder = workspace:WaitForChild("EggEvent") -- Папка со спавнами

-- Подсветка яйца
local function highlightEgg(part)
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

-- Телепорт к объекту
local function teleportTo(position)
	RootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
end

-- Сканирование и телепорт ко всем яйцам
local function collectAllEggs()
	for _, spawn in pairs(eggFolder:GetDescendants()) do
		if spawn:IsA("BasePart") and spawn.Name == "spawn" then
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Position - spawn.Position).Magnitude < 5 then
					highlightEgg(obj)
					teleportTo(obj.Position)
					task.wait(0.05) -- чуть-чуть пауза между телепортами
				end
			end
		end
	end
end

-- Цикл телепорта каждые 0.5 секунды
while true do
	collectAllEggs()
	task.wait(0.5)
end

print("✅ Быстрый авто-ТП и подсветка яиц включены (0.5 сек)")
