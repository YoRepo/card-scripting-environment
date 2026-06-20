--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 避雷神  (ID: 40672993)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 1800 | DEF 100
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己·对方的主要阶段1内，双方不能把魔法卡发动。
--[[ __CARD_HEADER_END__ ]]

--避雷神
function c40672993.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c40672993.actlimit)
	c:RegisterEffect(e1)
end
function c40672993.actlimit(e,te,tp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
		and te:IsHasType(EFFECT_TYPE_ACTIVATE) and te:IsActiveType(TYPE_SPELL)
end
