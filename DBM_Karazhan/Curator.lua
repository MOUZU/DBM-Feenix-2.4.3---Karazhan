local Curator = DBM:NewBossMod("Curator", DBM_CURA_NAME, DBM_CURA_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 8);

Curator.Version			= "1.1";
Curator.Author			= "LYQ";

Curator:RegisterEvents("CHAT_MSG_MONSTER_YELL");

Curator:RegisterCombat("YELL", DBM_CURA_YELL_PULL);

Curator:AddBarOption("Evocation")
Curator:AddBarOption("Next Evocation")
Curator:AddBarOption("Flare #(%d+)")

local flare = 1

Curator:AddOption("RangeCheck", true, DBM_MOV_OPTION_1, function()
	DBM:GetMod("Curator").Options.RangeCheck = not DBM:GetMod("Curator").Options.RangeCheck;
	
	if DBM:GetMod("Curator").Options.RangeCheck and DBM:GetMod("Curator").InCombat then
		DBM_Gui_DistanceFrame_Show();
	elseif not DBM:GetMod("Curator").Options.RangeCheck and DBM:GetMod("Curator").InCombat then
		DBM_Gui_DistanceFrame_Hide();
	end
end);

function Curator:OnCombatStart()
	self:StartStatusBarTimer(100.5, "Next Evocation", "Interface\\Icons\\Spell_Nature_Purge");
	self:ScheduleSelf(95, "EvoWarn", "soon");
    self:StartStatusBarTimer(10, "Flare #1", "Interface\\Icons\\Spell_Fire_Flare");
    self:ScheduleSelf(10, "NextFlare");
	self:ScheduleAnnounce(40, DBM_CURA_EVO_1MIN, 1)
	
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Curator:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Curator:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_CURA_YELL_OOM then
			self:StartStatusBarTimer(20, "Evocation", "Interface\\Icons\\Spell_Nature_Purge");
			self:Announce(DBM_CURA_EVO_NOW, 3);
			self:UnScheduleSelf("EvoWarn", "soon");
            self:ScheduleSelf(10, "NextEvo");
		end
		
	elseif event == "EvoWarn" then
		self:Announce(DBM_CURA_EVO_SOON, 2);
		
    elseif event == "NextFlare" then
        flare = flare + 1 ;
        if flare <= 10 then
            self:StartStatusBarTimer(10, "Flare #"..flare, "Interface\\Icons\\Spell_Fire_Flare");
            self:ScheduleSelf(10, "NextFlare");
        else
            flare = 0
            self:UnScheduleSelf(10, "NextFlare");
        end
    elseif event == "NextEvo" then
        self:StartStatusBarTimer(100.5, "Next Evocation", "Interface\\Icons\\Spell_Nature_Purge");
        self:ScheduleSelf(95, "EvoWarn", "soon");
        self:ScheduleAnnounce(40, DBM_CURA_EVO_1MIN, 1)
        self:ScheduleSelf(10, "NextFlare");
	end
end