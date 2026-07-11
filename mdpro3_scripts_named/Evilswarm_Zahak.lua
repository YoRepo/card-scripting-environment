--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Evilswarm Zahak  (ID: 3536537)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1850 | DEF 850
-- Setcode: 0xa
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this face-up card you control is destroyed by your opponent's card (by battle or card effect) and
-- sent to your Graveyard: Target 1 Special Summoned Level 5 or higher monster on the field; destroy
-- that target.
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・ザッハーク
function c3536537.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3536537,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c3536537.descon)
	e1:SetTarget(c3536537.destg)
	e1:SetOperation(c3536537.desop)
	c:RegisterEffect(e1)
end
function c3536537.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsPreviousControler(tp) and bit.band(r,REASON_DESTROY)~=0
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c3536537.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(5) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c3536537.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c3536537.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3536537.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c3536537.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
