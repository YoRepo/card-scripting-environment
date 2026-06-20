--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 看门狗  (ID: 57346400)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 反转：这个回合对方玩家不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガード・ドッグ
function c57346400.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57346400,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c57346400.operation)
	c:RegisterEffect(e1)
end
function c57346400.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
