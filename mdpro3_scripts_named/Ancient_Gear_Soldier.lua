--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 古代的机械士兵  (ID: 56094445)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1300 | DEF 1300
-- Setcode: 7
--
-- Effect Text:
-- ①：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--古代の機械兵士
function c56094445.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c56094445.aclimit)
	e1:SetCondition(c56094445.actcon)
	c:RegisterEffect(e1)
end
function c56094445.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c56094445.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
