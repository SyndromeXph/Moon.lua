--源码由司空提供，盗卖4000+
--加入群聊获取更多源码
--神秘数字 1108203505
local UI_URL = "https://sikon.226618.xyz/moon lua UI源码.lua"

local ok, Library = pcall(function()
    return loadstring(game:HttpGet(UI_URL))()
end)

if not ok or type(Library) ~= "table" then
    warn("[示例] UI 库加载失败: " .. tostring(Library))
    return
end
print("[示例] 库版本:", Library.Version)

local Window = Library:CreateWindow({
    Name              = "MoonLuaDemo",
    Title             = "全控件示例",
    Version           = "v1.0",
    Theme             = "Nord",
    Backdrop          = true,
    ShowBackdrop      = true,
    GradientAnimation = true,
    ConfigFolder      = "MoonLuaDemo",
    SearchTab         = true,
    Visible           = true,
})

local TabMain  = Window:CreateTab("基础控件")
local Page1    = TabMain:CreateModule("按钮 / 开关", "mouse-pointer", {})

local TabNum   = Window:CreateTab("数值")
local Page2    = TabNum:CreateModule("滑块", "sliders", {})

local TabInput = Window:CreateTab("输入类")
local Page3    = TabInput:CreateModule("选择与输入", "keyboard", {})

local TabStyle = Window:CreateTab("外观")
local Page4    = TabStyle:CreateModule("主题", "palette", {})

local TabSys   = Window:CreateTab("系统")
local Page5    = TabSys:CreateModule("工具", "wrench", {})

local clicks = 0

Page1:CreateButton("点我一下", function()
    print("[示例] 按钮被点击")
    Window:Notify({ Title = "按钮", Content = "你点了我一下", Duration = 3 })
end)

Page1:CreateButton("点我计数", function()
    clicks = clicks + 1
    Window:Notify({ Title = "计数", Content = "已经点了 " .. clicks .. " 次", Duration = 2 })
end)

local toggle = Page1:CreateToggle("启用某功能", false, function(value)
    print("[示例] 开关:", value)
end)

Page1:CreateToggle({
    Name     = "带 Id 的开关",        
    Id       = "DemoToggle",
    Default  = true,
    Callback = function(value) print("[示例] DemoToggle =", value) end,
})

local slider = Page2:CreateSlider("速度", 0, 100, 50, function(value)
    print("[示例] 速度:", value)
end)

local dbl = Page2:CreateDoubleSlider("区间", 0, 100, { 25, 75 }, function(minValue, maxValue)
    print("[示例] 区间:", minValue, maxValue)
end)

Page2:CreateButton("读当前值", function()
    Window:Notify({ Title = "当前值", Content = "速度 = " .. tostring(slider:Get()), Duration = 3 })
end)

Page2:CreateButton("设成 88", function() slider:Set(88) end)

Page2:CreateButton("+10", function() slider:Set(math.min(100, slider:Get() + 10)) end)

local selector = Page3:CreateSelector("选一个模式", { "普通", "快速", "狂暴" }, "普通", function(value)
    print("[示例] 模式:", value)
end)

Page3:CreateSelector({
    Name     = "表写法示例",
    Options  = { "选项A", "选项B", "选项C" },
    Default  = "选项B",
    Callback = function(value) print("[示例] 选择:", value) end,
})

local input = Page3:CreateInput("输入点什么", "", function(value)
    print("[示例] 输入:", value)
end)

Page3:CreateInput({
    Name        = "带占位符",
    Placeholder = "在这里打字…",
    Default     = "",
    Callback    = function(value) print("[示例] 输入2:", value) end,
})

local keybind = Page3:CreateKeybind("开启快捷键", Enum.KeyCode.RightShift, function(key)
    print("[示例] 按键:", key)
end)

Page3:CreateButton("读当前按键", function()
    Window:Notify({ Title = "按键", Content = tostring(keybind:Get()), Duration = 3 })
end)

local picker = Page3:CreateColorPicker("主题色", Color3.fromRGB(120, 90, 255), function(color)
    print("[示例] 颜色:", color)
end)

Page3:CreateButton("随机换色", function()
    picker:Set(Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255)))
end)

for _, themeName in ipairs({ "Nord", "Rainbow", "Gothic", "Purple", "Creida", "Cherry", "Winter" }) do
    Page4:CreateButton("切换到 " .. themeName, function()
        Window:SetTheme(themeName)
        Window:Notify({ Title = "主题", Content = themeName, Duration = 2 })
    end)
end

Page4:CreateButton("自定义配色", function()
    Window:SetCustomTheme(Color3.fromRGB(140, 90, 255), Color3.fromRGB(255, 110, 200))
end)

local grad = Page4:CreateToggle("渐变流动", true, function(value)
    Window:SetGradientAnimation(value)
end)

Page4:CreateButton("隐藏窗口", function() Window:Hide() end)
Page4:CreateButton("显示窗口", function() Window:Show() end)
Page4:CreateButton("开关切换", function() Window:Toggle() end)

Page5:CreateButton("保存配置", function()
    local okk, err = pcall(function() Window:SaveConfig("我的配置") end)
    Window:Notify({
        Title   = okk and "已保存" or "保存失败",
        Content = okk and "我的配置" or tostring(err),
        Duration = 3,
    })
end)

Page5:CreateButton("读取配置", function()
    local okk, err = pcall(function() Window:LoadConfig("我的配置") end)
    if not okk then
        Window:Notify({ Title = "读取失败", Content = tostring(err), Duration = 3 })
    end
end)

Page5:CreateButton("删除配置", function()
    pcall(function() Window:DeleteConfig("我的配置") end)
end)

Page5:CreateButton("全部恢复默认", function()
    toggle:Set(false)
    slider:Set(50)
    selector:Set("普通")
    keybind:Set(Enum.KeyCode.RightShift)
    picker:Set(Color3.fromRGB(120, 90, 255))
    grad:Set(true)
    Window:Notify({ Title = "重置", Content = "已恢复默认", Duration = 3 })
end)

Page5:CreateButton("生成玩家列表", function()
    local okk, err = pcall(function()
        Window:CreatePlayerList({ Title = "在线玩家" })
    end)
    if not okk then
        Window:Notify({ Title = "玩家列表", Content = tostring(err), Duration = 4 })
    end
end)

Page5:CreateButton("库级通知", function()
    Library:Notify("来自 Library", "这条不经过窗口", 4)
end)

Page5:CreateButton("打印自适应字号", function()
    print("[示例] 字号:", Library.GetFontSize(14, 1))
end)

Page5:CreateToggle("折叠上面的分组", false, function(value)
    pcall(function() Page1:SetExpanded(not value) end)
end)

Window:Notify({
    Title    = "示例已加载",
    Content  = "左侧 5 个页签，每个里面有一个或多个分组",
    Duration = 5,
})