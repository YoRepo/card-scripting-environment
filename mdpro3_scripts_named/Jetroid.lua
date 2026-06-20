--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 喷气机人  (ID: 43697559)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 22
--
-- Effect Text:
-- 这张卡被对方怪兽选作为攻击对象时，这张卡的控制者可以从手卡发动陷阱卡。
--[[ __CARD_HEADER_END__ ]]

--ジェット・ロイド
function c43697559.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43697559,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(c43697559.operation)
	c:RegisterEffect(e1)
end
function c43697559.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
