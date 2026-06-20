--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 一星同调士  (ID: 56897896)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 4119
--
-- Effect Text:
-- 把这张卡作为同调素材的场合，其他的同调素材怪兽必须是4星以下的战士族·机械族怪兽，那些等级当作1星使用。
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
