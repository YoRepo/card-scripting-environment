--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 风暴密码人  (ID: 89571015)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 4
-- ATK 2400 | DEF 0
-- Setcode: 229
--
-- Effect Text:
-- ①：这张卡不能直接攻击，不能向额外怪兽区域的怪兽攻击。
-- ②：这张卡不受额外怪兽区域的怪兽发动的效果影响，不会被和额外怪兽区域的怪兽的战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--ストームサイファー
function c89571015.initial_effect(c)
	--cannot attack directly
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	--cannot attack emz
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c89571015.atlimit)
	c:RegisterEffect(e2)
	--immune
	local e3=e1:Clone()
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c89571015.immval)
	c:RegisterEffect(e3)
	--indes
	local e4=e2:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e4)
end
function c89571015.atlimit(e,c)
	return c:GetSequence()>4
end
function c89571015.immval(e,te)
	return te:IsActivated() and te:GetActivateLocation()==LOCATION_MZONE and te:GetActivateSequence()>4
end
