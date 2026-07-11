--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Desertapir  (ID: 13409151)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 900 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Target 1 face-up monster on the field, except "Desertapir"; change it to face-down Defense
-- Position.
--[[ __CARD_HEADER_END__ ]]

--砂バク
function c13409151.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13409151,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c13409151.postg)
	e1:SetOperation(c13409151.posop)
	c:RegisterEffect(e1)
end
function c13409151.filter(c)
	return c:IsFaceup() and not c:IsCode(13409151) and c:IsCanTurnSet()
end
function c13409151.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13409151.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c13409151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c13409151.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
