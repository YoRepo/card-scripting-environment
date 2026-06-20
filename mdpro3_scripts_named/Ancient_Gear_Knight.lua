--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 古代的机械骑士  (ID: 39303359)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 500
-- Setcode: 7
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--古代の機械騎士
function c39303359.initial_effect(c)
	aux.EnableDualAttribute(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c39303359.aclimit)
	e1:SetCondition(c39303359.actcon)
	c:RegisterEffect(e1)
end
function c39303359.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c39303359.actcon(e)
	return aux.IsDualState(e) and Duel.GetAttacker()==e:GetHandler()
end
