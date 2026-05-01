local Players = game:GetService("Players")
local player = Players.LocalPlayer

local KORBLOX_MESH_ID    = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"

-- Fungsi untuk memasang efek ke model karakter apa pun
local function applyVisuals(char)
    if not char then return end
    
    -- Tunggu sebentar agar model ter-load sempurna oleh game
    task.wait(0.5)

    -- 1. Logic Headless
    local head = char:FindFirstChild("Head")
    if head then
        local face = head:FindFirstChildOfClass("Decal")
        if face then face.Transparency = 1 end
        head.Transparency = 1
        
        local headMesh = head:FindFirstChildOfClass("SpecialMesh")
        if headMesh then
            headMesh.Scale = Vector3.new(0, 0, 0)
        end
    end

    -- 2. Logic Korblox Right Leg
    -- Cek "Right Leg" (R6) atau "RightLowerLeg" (R15)
    local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
    
    if rightLeg then
        -- Hapus mesh asli agar tidak tumpang tindih
        for _, v in pairs(rightLeg:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then
                v:Destroy()
            end
        end

        -- Buat Mesh Korblox baru
        local mesh = Instance.new("SpecialMesh")
        mesh.Name = "KorbloxMesh"
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = KORBLOX_MESH_ID
        mesh.TextureId = KORBLOX_TEXTURE_ID
        mesh.Scale = Vector3.new(1.08, 1.08, 1.08)
        mesh.Parent = rightLeg

        -- Jika R15 (MeshPart), buat part aslinya transparan
        if rightLeg:IsA("MeshPart") then
            rightLeg.Transparency = 1
        else
            rightLeg.Transparency = 0
        end
    end
end

-- LOOP REFRESHER (Agar selalu update meskipun pertandingan selesai atau menu berganti)
task.spawn(function()
    while true do
        -- A. Target Karakter Utama (yang jalan-jalan di Map)
        if player.Character then
            applyVisuals(player.Character)
        end

        -- B. Target Karakter di Inventory (Path spesifik yang kamu berikan)
        local inventoryPath = workspace:FindFirstChild("Game") 
            and workspace.Game:FindFirstChild("MenuView") 
            and workspace.Game.MenuView:FindFirstChild("Parts") 
            and workspace.Game.MenuView.Parts:FindFirstChild("Inventory")
        
        if inventoryPath then
            local inventoryChar = inventoryPath:FindFirstChild("StarterCharacter")
            if inventoryChar then
                applyVisuals(inventoryChar)
            end
        end

        task.wait(2) -- Cek setiap 2 detik agar tidak berat/lag
    end
end)
