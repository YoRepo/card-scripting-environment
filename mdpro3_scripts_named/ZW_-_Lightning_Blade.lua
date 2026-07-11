--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: ZW - Lightning Blade  (ID: 45082499)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 5
-- ATK 1200 | DEF 2000
-- Setcode: 0x107e
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can target 1 "Utopia" monster you control; equip this monster from your hand or your side of the
-- field to that target.
-- It gains 1200 ATK.
-- While this card is equipped to a monster, face-up "ZW -" cards you control cannot be destroyed by
-- your opponent's card effects.
-- If a monster equipped with this card would be destroyed by a card effect, destroy this card instead.
-- You can only control 1 face-up "ZW - Lightning Blade".
--[[ __CARD_HEADER_END__ ]]

--ZW－雷神猛虎剣
function c45082499.initial_effect(c)
	c:SetUniqueOnField(1,0,45082499)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45082499,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCondition(c45082499.eqcon)
	e1:SetTarget(c45082499.eqtg)
	e1:SetOperation(c45082499.eqop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x107e))
	e2:SetCondition(c45082499.indcon)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--destroy sub
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetValue(c45082499.repval)
	c:RegisterEffect(e3)
end
function c45082499.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():CheckUniqueOnField(tp)
end
function c45082499.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c45082499.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c45082499.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c45082499.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c45082499.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c45082499.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	c45082499.zw_equip_monster(c,tp,tc)
end
function c45082499.zw_equip_monster(c,tp,tc)
	if not Duel.Equip(tp,c,tc) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c45082499.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1200)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
function c45082499.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c45082499.indcon(e)
	return e:GetHandler():GetEquipTarget()
end
function c45082499.repval(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
