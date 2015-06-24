local TerestianIllhoof = DBM:NewBossMod("TerestianIllhoof", DBM_TI_NAME, DBM_TI_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 9);

TerestianIllhoof.Version		= "1.1";
TerestianIllhoof.Author			= "LYQ";

TerestianIllhoof:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
    "UNIT_DIED"
);

TerestianIllhoof:RegisterCombat("YELL", DBM_TI_YELL_PULL);

TerestianIllhoof:AddOption("WarnSoon", true, DBM_TI_OPTION_1);

TerestianIllhoof:AddBarOption("Weakened")
TerestianIllhoof:AddBarOption("Sacrifice")
TerestianIllhoof:AddBarOption("Kil'rek spawn")

function TerestianIllhoof:OnCombatStart()
    self:StartStatusBarTimer(5,"Kil'rek spawn","Interface\\Icons\\Spell_Shadow_SummonImp")
    self:StartStatusBarTimer(30, "Sacrifice", "Interface\\Icons\\Spell_Shadow_AntiMagicShell");
    self:ScheduleSelf(28, "SacrificeWarning")
end

function TerestianIllhoof:OnEvent(event, arg1)
	if event == "SacrificeWarning" then
		self:Announce(DBM_TI_SACRIFICE_SOON, 2);
	elseif event == "ImpRespawn" and self.Options.WarnSoon then
        self:Announce(DBM_TI_IMP_SOON, 1);
    elseif event == "UNIT_DIED" then
		if args.destName == "Kil'rek" then
            self:StartStatusBarTimer(45, "Weakened", "Interface\\Icons\\Spell_Shadow_BloodBoil");
            self:Announce(DBM_TI_WEAKENED_WARN, 1);
            self:ScheduleSelf(40, "ImpRespawn");
        end
	elseif event == "SPELL_CAST_SUCCESS" then
        -- LYQ: not sure if this works here, I'll leave it for now
		if arg1.spellId == 30066 and self.Options.WarnSoon then
			self:Announce(DBM_TI_IMP_RESPAWNED, 2);
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 30115 then
			local target = arg1.destName
			if target then
				self:Announce(string.format(DBM_TI_SACRIFICE_WARN, target), 3);
				self:StartStatusBarTimer(29, "Sacrifice", "Interface\\Icons\\Spell_Shadow_AntiMagicShell");
				self:UnScheduleSelf("SacrificeWarning");
				self:ScheduleSelf(27, "SacrificeWarning");
			end
		end
	end
end
