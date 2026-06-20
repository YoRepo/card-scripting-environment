--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 灵兽使的长老  (ID: 14513016)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 2
-- ATK 200 | DEF 1000
-- Setcode: 4277
--
-- Effect Text:
-- 自己对「灵兽使的长老」1回合只能有1次特殊召唤。
-- ①：这张卡召唤时适用。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「灵兽」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--霊獣使いの長老
function c14513016.initial_effect(c)
	c:SetSPSummonOnce(14513016)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c14513016.sumop)
	c:RegisterEffect(e1)
end
function c14513016.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,14513016)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(14513016,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb5))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,14513016,RESET_PHASE+PHASE_END,0,1)
end
