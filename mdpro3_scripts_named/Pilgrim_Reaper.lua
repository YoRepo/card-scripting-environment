--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Pilgrim Reaper  (ID: 45742626)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank: 6
-- ATK ? | DEF ?
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 6 monsters
-- Gains 200 ATK/DEF for each DARK monster in the GYs.
-- You can detach 1 material from this card; each player sends the top 5 cards from their Deck to the
-- GY (or their entire Deck, if less than 5).
-- You can only use this effect of "Pilgrim Reaper" once per turn.
--[[ __CARD_HEADER_END__ ]]

--巡死神リーパー
function c45742626.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c45742626.value)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--deckdes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(45742626,0))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,45742626)
	e3:SetCost(c45742626.cost)
	e3:SetTarget(c45742626.target)
	e3:SetOperation(c45742626.operation)
	c:RegisterEffect(e3)
end
function c45742626.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsAttribute,0,LOCATION_GRAVE,LOCATION_GRAVE,nil,ATTRIBUTE_DARK)*200
end
function c45742626.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c45742626.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) and Duel.IsPlayerCanDiscardDeck(1-tp,5) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,PLAYER_ALL,5)
end
function c45742626.operation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,5)
	local g2=Duel.GetDecktopGroup(1-tp,5)
	g1:Merge(g2)
	Duel.DisableShuffleCheck()
	Duel.SendtoGrave(g1,REASON_EFFECT)
end
