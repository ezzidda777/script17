-- Local Script (클라이언트에서 실행)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- 파트가 생성될 범위
local PushForce = 1000  -- 밀어내는 힘
local PartSize = Vector3.new(5, 5, 5)  -- 생성되는 파트의 크기
local PushRange = 20  -- 파트 생성 후 밀어낼 범위 (단위: 스터디)

-- 마우스 클릭 시 호출되는 함수
local function onClick()
    -- 마우스 위치에 파트 생성
    local targetPosition = Mouse.Hit.p

    -- 파트 생성
    local part = Instance.new("Part")
    part.Size = PartSize
    part.Position = targetPosition
    part.Anchored = true  -- 파트를 고정
    part.CanCollide = false  -- 충돌 방지
    part.Parent = workspace

    -- 파트 주변 플레이어들을 밀어내는 힘 적용
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (targetPosition - humanoidRootPart.Position).Magnitude

                -- 범위 내에 있는 플레이어에게 밀어내는 힘 적용
                if distance <= PushRange then
                    local direction = (humanoidRootPart.Position - targetPosition).unit
                    humanoidRootPart.Velocity = direction * PushForce  -- 밀어내는 힘
                end
            end
        end
    end

    -- 0.5초 후에 파트 삭제
    game.Debris:AddItem(part, 0.5)
end

-- 마우스 왼쪽 버튼 클릭 시 onClick 함수 실행
Mouse.Button1Click:Connect(onClick)
