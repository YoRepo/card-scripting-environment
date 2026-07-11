--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Legacy Hunter  (ID: 87010442)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1000 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card attacks a face-down Defense Position monster and destroys it and sends it to the
-- Graveyard as a result of battle, your opponent returns 1 random card from their hand to their Deck.
-- Their Deck is then shuffled.
--[[ __CARD_HEADER_END__ ]]

--レガシーハンター
function c87010442.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87010442,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c87010442.condition)
	e1:SetTarget(c87010442.target)
	e1:SetOperation(c87010442.operation)
	c:RegisterEffect(e1)
end
function c87010442.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc:GetBattlePosition()==POS_FACEDOWN_DEFENSE and c:IsRelateToBattle() and c:IsFaceup()
end
function c87010442.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c87010442.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
