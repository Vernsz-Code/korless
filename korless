local Players = game:GetService("Players")
local player = Players.LocalPlayer

local KORBLOX_MESH_ID    = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"

local function applyVisuals(char)
    if not char then return end
    
    task.wait(0.8)

    -- Logic Headless
    local head = char:FindFirstChild("Head")
    if head then
        local face = head:FindFirstChildOfClass("Decal")
        if face then face.Transparency = 1 end
        head.Transparency = 1
        
        -- Support untuk beberapa executor yang butuh penghancuran mesh kepala
        local headMesh = head:FindFirstChildOfClass("SpecialMesh")
        if headMesh then
            headMesh.Scale = Vector3.new(0, 0, 0)
        end
    end

    -- Logic Korblox Right Leg
    local rightLeg = char:FindFirstChild("Right Leg")
    if rightLeg then
        for _, v in pairs(rightLeg:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then
                v:Destroy()
            end
        end

        local mesh = Instance.new("SpecialMesh")
        mesh.Name = "KorbloxMesh"
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = KORBLOX_MESH_ID
        mesh.TextureId = KORBLOX_TEXTURE_ID
        mesh.Scale = Vector3.new(1.08, 1.08, 1.08)
        mesh.Parent = rightLeg

        rightLeg.Transparency = 0
    end
end

if player.Character then
    applyVisuals(player.Character)
end

player.CharacterAdded:Connect(function(newChar)
    applyVisuals(newChar)
end)
