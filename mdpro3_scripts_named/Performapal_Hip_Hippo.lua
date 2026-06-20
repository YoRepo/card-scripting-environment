--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 娱乐伙伴 探寻河马  (ID: 41440148)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 800 | DEF 800
-- Setcode: 159
--
-- Effect Text:
-- ①：这张卡召唤成功的回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只7星以上的怪兽表侧攻击表示上级召唤。
--[[ __CARD_HEADER_END__ ]]

--EMディスカバー・ヒッポ
function c41440148.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c41440148.sumop)
	c:RegisterEffect(e1)
end
function c41440148.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,41440148)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(41440148,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,7))
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,41440148,RESET_PHASE+PHASE_END,0,1)
end
