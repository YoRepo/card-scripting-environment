--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Link Disciple  (ID: 32995276)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 4 or lower Cyberse monster
-- You can Tribute 1 monster this card points to; draw 1 card, then place 1 card from your hand on the
-- bottom of the Deck.
-- You can only use this effect of "Link Disciple" once per turn.
--[[ __CARD_HEADER_END__ ]]

--リンク・ディサイプル
function c32995276.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c32995276.matfilter,1,1)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32995276,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,32995276)
	e1:SetCost(c32995276.cost)
	e1:SetTarget(c32995276.target)
	e1:SetOperation(c32995276.operation)
	c:RegisterEffect(e1)
end
function c32995276.matfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkRace(RACE_CYBERSE)
end
function c32995276.cfilter(c,g)
	return g:IsContains(c)
end
function c32995276.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.CheckReleaseGroup(tp,c32995276.cfilter,1,nil,lg) end
	local g=Duel.SelectReleaseGroup(tp,c32995276.cfilter,1,1,nil,lg)
	Duel.Release(g,REASON_COST)
end
function c32995276.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c32995276.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
