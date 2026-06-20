--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 火石战机  (ID: 83812099)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1500 | DEF 800
--
-- Effect Text:
-- 场上有表侧表示的「打火石」存在的场合，可以给这张卡装备。这个效果1回合只能使用1次。此外，可以把这张卡装备的1张「打火石」给场上存在的1只表侧表示怪兽装备。这张卡可以装备的「打火石」最多1张。只要这张
-- 卡有「打火石」装备，这张卡不受「打火石」的效果影响，并且不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--フリントロック
function c83812099.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83812099,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c83812099.eqcon1)
	e1:SetTarget(c83812099.eqtg1)
	e1:SetOperation(c83812099.eqop1)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83812099,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c83812099.eqcon2)
	e2:SetTarget(c83812099.eqtg2)
	e2:SetOperation(c83812099.eqop2)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c83812099.eqcon2)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c83812099.eqcon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetEquipGroup():IsExists(Card.IsCode,1,nil,75560629)
end
function c83812099.filter1(c,ec)
	return c:IsFaceup() and c:IsCode(75560629) and c:CheckEquipTarget(ec)
end
function c83812099.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83812099.filter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,e:GetHandler()) end
end
function c83812099.eqop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,c83812099.filter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,c)
	local eqc=g:GetFirst()
	if eqc then
		Duel.Equip(tp,eqc,c)
	end
end
function c83812099.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipGroup():IsExists(Card.IsCode,1,nil,75560629)
end
function c83812099.filter2(c,eqc)
	return c:IsFaceup() and eqc:CheckEquipTarget(c)
end
function c83812099.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local eqc=e:GetHandler():GetEquipGroup():Filter(Card.IsCode,nil,75560629):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c83812099.filter2(chkc,eqc) end
	if chk==0 then return Duel.IsExistingTarget(c83812099.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),eqc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c83812099.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),eqc)
end
function c83812099.eqop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local eqc=e:GetHandler():GetEquipGroup():Filter(Card.IsCode,nil,75560629):GetFirst()
	if eqc then
		Duel.Equip(tp,eqc,tc)
	end
end
