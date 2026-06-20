--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 雪龙  (ID: 3070049)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level 4
-- ATK 1400 | DEF 900
--
-- Effect Text:
-- 这张卡被战斗或者卡的效果破坏送去墓地时，给场上表侧表示存在的全部怪兽放置1个冰指示物。
--[[ __CARD_HEADER_END__ ]]

--スノー・ドラゴン
function c3070049.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3070049,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c3070049.condition)
	e1:SetOperation(c3070049.operation)
	c:RegisterEffect(e1)
end
function c3070049.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c3070049.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,0x1015,1)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1015,1,REASON_EFFECT)
		tc=g:GetNext()
	end
end
