local Players = game:GetService("Players")
local player = Players.LocalPlayer

local KORBLOX_MESH_ID    = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"

-- Fungsi utama untuk apply visual
local function applyVisuals(char)
    if not char or not char:Parent then return end

    -- Logic Headless
    local head = char:FindFirstChild("Head")
    if head and head.Transparency ~= 1 then
        local face = head:FindFirstChildOfClass("Decal")
        if face then face.Transparency = 1 end
        head.Transparency = 1
        
        local headMesh = head:FindFirstChildOfClass("SpecialMesh")
        if headMesh and headMesh.Scale ~= Vector3.new(0, 0, 0) then
            headMesh.Scale = Vector3.new(0, 0, 0)
        end
    end

    -- Logic Korblox Right Leg (R6 & R15 Support)
    local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
    if rightLeg then
        -- Cek apakah mesh sudah ada agar tidak spam create
        if not rightLeg:FindFirstChild("KorbloxMesh") then
            -- Bersihkan mesh lama
            for _, v in pairs(rightLeg:GetChildren()) do
                if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") or v:IsA("MeshPart") then
                    if v.Name ~= "KorbloxMesh" then
                        v:Destroy()
                    end
                end
            end

            local mesh = Instance.new("SpecialMesh")
            mesh.Name = "KorbloxMesh"
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = KORBLOX_MESH_ID
            mesh.TextureId = KORBLOX_TEXTURE_ID
            mesh.Scale = Vector3.new(1.08, 1.08, 1.08)
            mesh.Parent = rightLeg
            
            -- Menghilangkan part asli jika R15
            if rightLeg:IsA("MeshPart") then
                rightLeg.Transparency = 1
            else
                rightLeg.Transparency = 0
            end
        end
    end
end

-- SCANNER: Mencari karakter player di manapun (Workspace, Folder lain, atau GUI)
task.spawn(function()
    while task.wait(1) do -- Refresh setiap 1 detik
        -- 1. Cek karakter utama
        if player.Character then
            applyVisuals(player.Character)
        end

        -- 2. Cek karakter di dalam folder atau viewport (GUI)
        -- Mencari semua model di game yang namanya sama dengan nama Player
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == player.Name then
                -- Pastikan model memiliki Head atau Humanoid (tanda itu karakter)
                if obj:FindFirstChild("Head") or obj:FindFirstChildOfClass("Humanoid") then
                    applyVisuals(obj)
                end
            end
        end
    end
end)
