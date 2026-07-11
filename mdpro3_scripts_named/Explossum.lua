--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Explossum  (ID: 38210374)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 1
-- ATK 100 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can target 1 face-up Xyz Monster your opponent controls; equip this monster from your hand or
-- your side of the field to that target.
-- If a monster equipped with this card by this effect has no Xyz Materials, destroy that monster.
-- While this card is equipped to a monster, during each of your opponent's Standby Phases: Detach 1
-- Xyz Material from the equipped monster.
--[[ __CARD_HEADER_END__ ]]

--バク団
function c38210374.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38210374,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c38210374.eqtg)
	e1:SetOperation(c38210374.eqop)
	c:RegisterEffect(e1)
	--remove material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(38210374,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c38210374.rmcon)
	e2:SetTarget(c38210374.rmtg)
	e2:SetOperation(c38210374.rmop)
	c:RegisterEffect(e2)
end
function c38210374.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c38210374.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c38210374.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c38210374.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c38210374.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c38210374.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c38210374.eqlimit)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c38210374.descon)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
function c38210374.eqlimit(e,c)
	return c:IsType(TYPE_XYZ)
end
function c38210374.descon(e)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and ec:GetOverlayCount()==0
end
function c38210374.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c38210374.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ec=e:GetHandler():GetEquipTarget()
		return ec and ec:CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
	end
end
function c38210374.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ec=e:GetHandler():GetEquipTarget()
	if ec then
		ec:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	end
end
