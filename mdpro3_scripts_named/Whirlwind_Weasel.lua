--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 真空鼬鼠  (ID: 93730409)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Beast
-- Level 3
-- ATK 500 | DEF 1500
--
-- Effect Text:
-- ①：这张卡反转的场合发动。这个回合，对方不能把魔法·陷阱卡发动。
--[[ __CARD_HEADER_END__ ]]

--真空イタチ
function c93730409.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93730409,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c93730409.operation)
	c:RegisterEffect(e1)
end
function c93730409.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c93730409.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c93730409.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
