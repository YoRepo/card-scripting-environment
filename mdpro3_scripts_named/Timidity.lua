--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 癔病风  (ID: 40350910)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 直到下次的对方回合的结束阶段，场上的盖放的魔法·陷阱不能破坏。
--[[ __CARD_HEADER_END__ ]]

--おくびょうかぜ
function c40350910.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c40350910.activate)
	c:RegisterEffect(e1)
end
function c40350910.activate(e,tp,eg,ep,ev,re,r,rp)
	--indestructable
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTarget(c40350910.infilter)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c40350910.infilter(e,c)
	return c:IsFacedown()
end
