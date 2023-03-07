function fps_info.fps_changed(callback)
	task.spawn(function()
		local LastIteration, Start
		local FrameUpdateTable = {}
		local CurrentFPS = 0
		game:GetService("RunService").Heartbeat:Connect(function()
			LastIteration = tick()
			for Index = #FrameUpdateTable, 1, -1 do
				FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
			end
			FrameUpdateTable[1] = LastIteration
			callback(math.floor((tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))))
		end)
		Start = tick()
	end)
end
return fps_info
