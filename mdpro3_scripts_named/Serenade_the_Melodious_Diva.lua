--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻奏的音女 塞瑞娜  (ID: 42029847)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 400 | DEF 1900
-- Setcode: 155
--
-- Effect Text:
-- ①：天使族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
-- ②：这张卡特殊召唤成功的回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「幻奏」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女セレナ
function c42029847.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c42029847.condition)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c42029847.regop)
	c:RegisterEffect(e2)
end
function c42029847.condition(e,c)
	return c:IsRace(RACE_FAIRY)
end
function c42029847.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,42029847)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(42029847,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x9b))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,42029847,RESET_PHASE+PHASE_END,0,1)
end
