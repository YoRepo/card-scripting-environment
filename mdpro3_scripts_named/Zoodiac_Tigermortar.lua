--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Zoodiac Tigermortar  (ID: 11510448)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Rank: 4
-- ATK ? | DEF ?
-- Setcode: 0xf1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 4 monsters
-- Once per turn, you can also Xyz Summon "Zoodiac Tigermortar" by using 1 "Zoodiac" monster you
-- control with a different name as Xyz Material.
-- (If you used an Xyz Monster, any Xyz Materials attached to it also become Xyz Materials on this
-- card.)
-- This card gains ATK and DEF equal to the ATK and DEF of all "Zoodiac" monsters attached to it as
-- Materials.
-- Once per turn: You can detach 1 Xyz Material from this card, then target 1 Xyz Monster you control
-- and 1 "Zoodiac" monster in your Graveyard; attach that "Zoodiac" monster to that Xyz Monster as Xyz
-- Material.
--[[ __CARD_HEADER_END__ ]]

--十二獣タイグリス
function c11510448.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3,c11510448.ovfilter,aux.Stringid(11510448,0),3,c11510448.xyzop)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c11510448.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c11510448.defval)
	c:RegisterEffect(e2)
	--xyz material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11510448,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c11510448.cost)
	e3:SetTarget(c11510448.target)
	e3:SetOperation(c11510448.operation)
	c:RegisterEffect(e3)
end
function c11510448.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf1) and not c:IsCode(11510448)
end
function c11510448.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,11510448)==0 end
	Duel.RegisterFlagEffect(tp,11510448,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c11510448.atkfilter(c)
	return c:IsSetCard(0xf1) and c:GetAttack()>=0
end
function c11510448.atkval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c11510448.atkfilter,nil)
	return g:GetSum(Card.GetAttack)
end
function c11510448.deffilter(c)
	return c:IsSetCard(0xf1) and c:GetDefense()>=0
end
function c11510448.defval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c11510448.deffilter,nil)
	return g:GetSum(Card.GetDefense)
end
function c11510448.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c11510448.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c11510448.filter2(c)
	return c:IsSetCard(0xf1) and c:IsType(TYPE_MONSTER) and c:IsCanOverlay()
end
function c11510448.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c11510448.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c11510448.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11510448,2))
	Duel.SelectTarget(tp,c11510448.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectTarget(tp,c11510448.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c11510448.opfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsCanOverlay()
end
function c11510448.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc1=g:Filter(Card.IsLocation,nil,LOCATION_MZONE):GetFirst()
	local g2=g:Filter(c11510448.opfilter,nil)
	if tc1 and tc1:IsFaceup() and not tc1:IsImmuneToEffect(e) and g2:GetCount()>0 then
		Duel.Overlay(tc1,g2)
	end
end
