--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Old Vindictive Magician  (ID: 45141844)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 2
-- ATK 450 | DEF 600
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Target 1 monster your opponent controls; destroy that target.
--[[ __CARD_HEADER_END__ ]]

--執念深き老魔術師
function c45141844.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45141844,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c45141844.target)
	e1:SetOperation(c45141844.operation)
	c:RegisterEffect(e1)
end
function c45141844.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c45141844.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
