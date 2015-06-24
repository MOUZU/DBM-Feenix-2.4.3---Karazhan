local Moroes = DBM:NewBossMod("Moroes", DBM_MOROES_NAME, DBM_MOROES_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 2);

Moroes.Version			= "1.1";
Moroes.Author			= "LYQ";
Moroes.LastVanish		= 0;

Moroes:RegisterEvents(
	"SPELL_AURA_APPLIED",
    "CHAT_MSG_MONSTER_YELL",
    
    "SPELL_CAST_START",
    "SPELL_INTERRUPT"
);

Moroes:AddOption("VanishWarn", true, DBM_MOROES_OPTION_1);
Moroes:AddOption("VanishWarnFade", true, DBM_MOROES_OPTION_2);
Moroes:AddOption("VanishWarnSoon", true, DBM_MOROES_OPTION_3);
Moroes:AddOption("GarroteWarn", true, DBM_MOROES_OPTION_4);

Moroes:AddBarOption("Vanish")
Moroes:AddBarOption("Vanish Fade")

Moroes:RegisterCombat("YELL", DBM_MOROES_YELL_START);

function Moroes:OnCombatStart(delay)
	self:StartStatusBarTimer(29.5, "Vanish", "Interface\\Icons\\Ability_Vanish");
	self:ScheduleSelf(25, "SoonWarning");
end

function Moroes:OnEvent(event, arg1)	
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 29448 then
            -- LYQ: I don't know if this works, I'll try it for now
			if self.Options.VanishWarn then
				self:Announce(DBM_MOROES_VANISH_WARN, 3);
			end
			self.LastVanish = GetTime();
            self:StartStatusBarTimer(12, "Vanish Fade", "Interface\\Icons\\Ability_Vanish");
		elseif arg1.spellId == 37066 and self.Options.GarroteWarn then
			self:Announce(string.format(DBM_MOROES_GARROTE_WARN, tostring(arg1.destName)), 2);
		end
    elseif event == "SPELL_CAST_START" or event == "SPELL_INTERRUPT" then
        if arg1.spellId == 29448 then
           print(event.." triggered Moroes Vanish") 
        end
	elseif event == "SoonWarning" and self.Options.VanishWarnSoon then
		self:Announce(DBM_MOROES_VANISH_SOON, 2);
        
    elseif event == "CHAT_MSG_MONSTER_YELL" then
        if string.find(arg1,DBM_MOROES_YELL_BACK1) or string.find(arg1,DBM_MOROES_YELL_BACK2) then
            self:StartStatusBarTimer(30, "Vanish", "Interface\\Icons\\Ability_Vanish");
            self:ScheduleSelf(25, "SoonWarning");
            if self.Options.VanishWarnFade then
				self:Announce(DBM_MOROES_VANISH_FADED, 3);
			end
        end
	end
end
