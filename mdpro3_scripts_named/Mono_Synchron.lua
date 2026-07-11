--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Mono Synchron  (ID: 56897896)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x1017
-- Scope: OCG / TCG
--
-- Effect Text:
-- When using this card as Synchro Material, the other Synchro Material(s) must be Level 4 or lower
-- Warrior or Machine-Type monsters, and they are treated as Level 1.
--[[ __CARD_HEADER_END__ ]]

--モノ・シンクロン
function c56897896.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c56897896.synlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_CHECK)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c56897896.syncheck)
	c:RegisterEffect(e2)
end
function c56897896.synlimit(e,c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WARRIOR+RACE_MACHINE)
end
function c56897896.syncheck(e,c)
	if c~=e:GetHandler() then
		c:AssumeProperty(ASSUME_LEVEL,1)
	end
end
