--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Driving Snow  (ID: 473469)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can activate this card when 1 or more of your Trap Cards are destroyed and sent from the field
-- to the Graveyard by a card effect your opponent controls.
-- Destroy 1 Spell or Trap Card on the field.
--[[ __CARD_HEADER_END__ ]]

--猛吹雪
function c473469.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c473469.condition)
	e1:SetTarget(c473469.target)
	e1:SetOperation(c473469.activate)
	c:RegisterEffect(e1)
end
function c473469.filter(c,tp)
	return c:IsType(TYPE_TRAP) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
		and bit.band(c:GetReason(),0x41)==0x41
end
function c473469.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and eg:IsExists(c473469.filter,1,nil,tp)
end
function c473469.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c473469.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c473469.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c473469.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c473469.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c473469.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
