--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 邻家割草  (ID: 11110587)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己卡组的数量比对方多的场合才能发动。直到卡组数量变成和对方相同为止，从自己卡组上面把卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--隣の芝刈り
function c11110587.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c11110587.condition)
	e1:SetTarget(c11110587.target)
	e1:SetOperation(c11110587.activate)
	c:RegisterEffect(e1)
end
function c11110587.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
end
function c11110587.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)-Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDiscardDeck(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
end
function c11110587.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)-Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct>0 then
		Duel.DiscardDeck(tp,ct,REASON_EFFECT)
	end
end
