--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Bot Herder  (ID: 45951104)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 monster your opponent controls, that is a face-up monster you own or a face-down Defense
-- Position monster; if that monster is no longer on the field, or is a monster you own (if face-down,
-- reveal it briefly to check), apply these effects in sequence.
-- ● Inflict 200 damage to your opponent.
-- ● Take control of all monsters your opponent controls, except that monster.
--[[ __CARD_HEADER_END__ ]]

--ボット・ハーダー
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c,tp)
	return c:IsFacedown() or (c:IsFaceup() and c:GetOwner()==tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	if g:GetCount()>0 and g:GetFirst():GetOwner()==tp then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,200)
	end
end
function s.ctfilter(c)
	return c:IsControlerCanBeChanged(true)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsOnField() and tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
	if not tc:IsRelateToChain() or tc:GetOwner()==tp then
		Duel.Damage(1-tp,200,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(s.ctfilter,tp,0,LOCATION_MZONE,tc)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.GetControl(g,tp)
		end
	end
end
