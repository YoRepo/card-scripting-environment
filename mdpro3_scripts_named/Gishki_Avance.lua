--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 遗式先锋 阿旺斯  (ID: 16693254)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 800
-- Setcode: 58
--
-- Effect Text:
-- 1回合1次，可以从自己卡组选择1只名字带有「遗式」的怪兽在卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--リチュア・アバンス
function c16693254.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16693254,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c16693254.target)
	e1:SetOperation(c16693254.operation)
	c:RegisterEffect(e1)
end
function c16693254.filter(c)
	return c:IsSetCard(0x3a) and c:IsType(TYPE_MONSTER)
end
function c16693254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c16693254.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c16693254.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(16693254,1))
	local g=Duel.SelectMatchingCard(tp,c16693254.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
