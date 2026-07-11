--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Galaxy-Eyes Full Armor Photon Dragon  (ID: 39030163)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Dragon
-- Rank: 8
-- ATK 4000 | DEF 3500
-- Setcode: 0x107b, 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 8 monsters
-- You can also Xyz Summon this card by using a "Galaxy-Eyes" Xyz Monster you control as material,
-- except "Galaxy-Eyes Full Armor Photon Dragon".
-- (Transfer its materials to this card.)
-- Once per turn: You can target up to 2 Equip Cards equipped to this card; attach them to this card as
-- material.
-- Once per turn: You can detach 1 material from this card, then target 1 face-up card your opponent
-- controls; destroy it.
--[[ __CARD_HEADER_END__ ]]

--ギャラクシーアイズ FA・フォトン・ドラゴン
function c39030163.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,3,c39030163.ovfilter,aux.Stringid(39030163,0))
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39030163,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCost(c39030163.mtcost)
	e1:SetTarget(c39030163.mttg)
	e1:SetOperation(c39030163.mtop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39030163,2))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c39030163.descost)
	e2:SetTarget(c39030163.destg)
	e2:SetOperation(c39030163.desop)
	c:RegisterEffect(e2)
end
function c39030163.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107b) and c:IsType(TYPE_XYZ) and not c:IsCode(39030163)
end
function c39030163.mtcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c39030163.mtfilter(c,e)
	return c:IsCanOverlay() and c:IsCanBeEffectTarget(e)
end
function c39030163.mttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetHandler():GetEquipGroup()
	if chkc then return g:IsContains(chkc) and c39030163.mtfilter(chkc,e) end
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) and g:IsExists(c39030163.mtfilter,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local tg=g:FilterSelect(tp,c39030163.mtfilter,1,2,nil,e)
	Duel.SetTargetCard(tg)
end
function c39030163.matfilter(c,e)
	return c:IsRelateToEffect(e) and not c:IsImmuneToEffect(e) and c:IsCanOverlay()
end
function c39030163.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c39030163.matfilter,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c39030163.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c39030163.desfilter(c)
	return c:IsFaceup()
end
function c39030163.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c39030163.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39030163.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c39030163.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c39030163.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
