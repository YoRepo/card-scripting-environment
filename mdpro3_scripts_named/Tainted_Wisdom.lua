--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恶魔的智慧  (ID: 28725004)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1250 | DEF 800
--
-- Effect Text:
-- 这张卡的表示形式从攻击表示变成守备表示时，洗自己的卡组。
--[[ __CARD_HEADER_END__ ]]

--悪魔の知恵
function c28725004.initial_effect(c)
	--shuffle
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28725004,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c28725004.condition)
	e1:SetOperation(c28725004.operation)
	c:RegisterEffect(e1)
end
function c28725004.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_ATTACK) and e:GetHandler():IsPosition(POS_DEFENSE)
end
function c28725004.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ShuffleDeck(tp)
end
