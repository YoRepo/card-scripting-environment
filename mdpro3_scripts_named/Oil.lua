--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Oil  (ID: 74055055)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target up to 2 Level 4 or lower FIRE monsters with different names in your GY; add them to your
-- hand.
-- You can only activate 1 "Oil" per turn.
--[[ __CARD_HEADER_END__ ]]

--石油採掘
function c74055055.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74055055,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,74055055+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c74055055.target)
	e1:SetOperation(c74055055.activate)
	c:RegisterEffect(e1)
end
function c74055055.filter(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_FIRE)
		and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function c74055055.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c74055055.filter(chkc,e) end
	local g=Duel.GetMatchingGroup(c74055055.filter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,2)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c74055055.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
