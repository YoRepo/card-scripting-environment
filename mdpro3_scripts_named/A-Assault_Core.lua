--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: A-Assault Core  (ID: 30012506)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1900 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 LIGHT Machine monster you control; equip this card to that
-- target, OR: Unequip this card and Special Summon it.
-- A monster equipped with this card is unaffected by your opponent's monster effects (except its own),
-- also if the equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- If this card is sent from the field to the GY: You can add 1 other Union monster from your GY to
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--A－アサルト・コア
function c30012506.initial_effect(c)
	aux.EnableUnionAttribute(c,c30012506.filter)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c30012506.efilter)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c30012506.thcon)
	e5:SetTarget(c30012506.thtg)
	e5:SetOperation(c30012506.thop)
	c:RegisterEffect(e5)
end
c30012506.has_text_type=TYPE_UNION
function c30012506.filter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c30012506.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner()
		and te:IsActiveType(TYPE_MONSTER)
end
function c30012506.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c30012506.thfilter(c)
	return c:IsType(TYPE_UNION) and c:IsAbleToHand()
end
function c30012506.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30012506.thfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c30012506.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30012506.thfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
