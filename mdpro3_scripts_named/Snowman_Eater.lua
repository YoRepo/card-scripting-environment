--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Snowman Eater  (ID: 91133740)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 0 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is flipped face-up: Target 1 face-up monster on the field; destroy that target.
--[[ __CARD_HEADER_END__ ]]

--スノーマンイーター
function c91133740.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91133740,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetCode(EVENT_FLIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c91133740.destg)
	e1:SetOperation(c91133740.desop)
	c:RegisterEffect(e1)
end
function c91133740.filter(c)
	return c:IsFaceup()
end
function c91133740.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c91133740.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c91133740.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c91133740.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
