local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local eggFolder = workspace:WaitForChild("EggEvent") -- Папка со спавнами

-- Телепорт к позиции
local function teleportTo(position)
	RootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
end

-- Сканирование и телепорт ко всем яйцам
local function collectAllEggs()
	for _, spawn in pairs(eggFolder:GetDescendants()) do
		if spawn:IsA("BasePart") and spawn.Name == "spawn" then
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Position - spawn.Position).Magnitude < 5 then
					teleportTo(obj.Position)
					task.wait(0.05)
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

print("✅ Авто-ТП к яйцам активирован (без подсветки)")

