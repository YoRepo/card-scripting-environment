--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Solitaire Magician  (ID: 28966434)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 1600 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can select 1 face-up "Fortune Lady" monster you control and 1 other face-up
-- monster on the field.
-- Reduce the Level of the selected "Fortune Lady" monster by 3, and destroy the other selected
-- monster.
--[[ __CARD_HEADER_END__ ]]

--ソリテア・マジカル
function c28966434.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28966434,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c28966434.destg)
	e1:SetOperation(c28966434.desop)
	c:RegisterEffect(e1)
end
function c28966434.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x31) and c:IsLevelAbove(4)
end
function c28966434.filter2(c)
	return c:IsFaceup()
end
function c28966434.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c28966434.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c28966434.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(28966434,1))
	local g1=Duel.SelectTarget(tp,c28966434.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c28966434.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,g1:GetFirst())
	e:SetLabelObject(g1:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,1,0,0)
end
function c28966434.desop(e,tp,eg,ep,ev,re,r,rp)
	local c1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==c1 then tc=g:GetNext() end
	if c1:IsLevelBelow(3) or c1:IsFacedown() or not c1:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(-3)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c1:RegisterEffect(e1)
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Destroy(tc,REASON_EFFECT)
end
