--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Vylon Stigma  (ID: 10712320)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1600 | DEF 1000
-- Setcode: 0x30
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during either player's turn: You can target 1 face-up "Vylon" Equip Card you control
-- and 1 appropriate face-up monster; equip the first target to the second target.
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・スティグマ
function c10712320.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10712320,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c10712320.eqtg)
	e1:SetOperation(c10712320.eqop)
	c:RegisterEffect(e1)
end
function c10712320.filter1(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x30) and c:GetEquipTarget()
		and Duel.IsExistingTarget(c10712320.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c:GetEquipTarget(),c)
end
function c10712320.filter2(c,eqc)
	return c:IsFaceup() and eqc:CheckEquipTarget(c)
end
function c10712320.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c10712320.filter1,tp,LOCATION_SZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c10712320.filter1,tp,LOCATION_SZONE,0,1,1,nil,tp)
	local eqc=g1:GetFirst()
	e:SetLabelObject(eqc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g2=Duel.SelectTarget(tp,c10712320.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,eqc:GetEquipTarget(),eqc)
end
function c10712320.eqop(e,tp,eg,ep,ev,re,r,rp)
	local eqc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==eqc then tc=g:GetNext() end
	if not eqc:IsRelateToEffect(e) then return end
	Duel.Equip(tp,eqc,tc)
end
