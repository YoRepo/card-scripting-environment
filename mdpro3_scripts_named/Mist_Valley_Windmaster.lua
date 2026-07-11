--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Mist Valley Windmaster  (ID: 92933195)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 2
-- ATK 400 | DEF 800
-- Setcode: 0x37
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, if both players have 5 or more cards in their hand, you can activate this effect to
-- make both players send cards from their hand to the Graveyard until they have 4 cards.
--[[ __CARD_HEADER_END__ ]]

--霞の谷の風使い
function c92933195.initial_effect(c)
	--hand adjust
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92933195,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c92933195.handcon)
	e1:SetOperation(c92933195.handop)
	c:RegisterEffect(e1)
end
function c92933195.handcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=5 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=5
end
function c92933195.handop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local ht1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht1>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,ht1-4,ht1-4,nil)
		g:Merge(sg)
	end
	local ht2=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	if ht2>=5 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(1-tp,aux.TRUE,1-tp,LOCATION_HAND,0,ht2-4,ht2-4,nil)
		g:Merge(sg)
	end
	Duel.SendtoGrave(g,REASON_EFFECT)
end
