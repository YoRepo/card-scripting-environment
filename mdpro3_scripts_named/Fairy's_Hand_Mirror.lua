--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Fairy's Hand Mirror  (ID: 17653779)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell Card that targets exactly 1 monster (and no other cards) on the
-- field: Target another card that would be an appropriate target; that Spell now targets the new
-- target.
--[[ __CARD_HEADER_END__ ]]

--天使の手鏡
function c17653779.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c17653779.tgcon)
	e1:SetTarget(c17653779.tgtg)
	e1:SetOperation(c17653779.tgop)
	c:RegisterEffect(e1)
end
function c17653779.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_SPELL)
		or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_MZONE)
end
function c17653779.filter(c,ct)
	return Duel.CheckChainTarget(ct,c)
end
function c17653779.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsLocation(LOCATION_MZONE) and c17653779.filter(chkc,ev) end
	if chk==0 then return Duel.IsExistingTarget(c17653779.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetLabelObject(),ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c17653779.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetLabelObject(),ev)
end
function c17653779.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
end
