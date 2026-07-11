--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Dark Coffin  (ID: 1804528)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this face-down card is destroyed and sent to the Graveyard, your opponent selects and executes
-- 1 of the following effects:
-- ● Discard 1 random card in their hand.
-- ● Select 1 monster on their side of the field and destroy it.
--[[ __CARD_HEADER_END__ ]]

--呪われた棺
function c1804528.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1804528,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c1804528.descon)
	e1:SetOperation(c1804528.desop)
	c:RegisterEffect(e1)
end
function c1804528.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY)~=0
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEDOWN)
end
function c1804528.desop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local opt=0
	if g1:GetCount()>0 and g2:GetCount()>0 then
		opt=Duel.SelectOption(1-tp,aux.Stringid(1804528,1),aux.Stringid(1804528,2))
	elseif g1:GetCount()>0 then
		opt=Duel.SelectOption(1-tp,aux.Stringid(1804528,1))
	elseif g2:GetCount()>0 then
		opt=Duel.SelectOption(1-tp,aux.Stringid(1804528,2))+1
	else return end
	if opt==0 then
		local dg=g1:RandomSelect(1-tp,1)
		Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
	else
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
		local dg=g2:Select(1-tp,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
